// These imports are only needed to open the database
import 'package:food_app/data/model/food_model.dart';
import 'package:moor/ffi.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:moor/moor.dart';
import 'dart:io';
import 'package:food_app/data/db/entity/food_entity.dart';
import 'package:food_app/business/mapper.dart';

part 'database.g.dart';

LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder for your app.
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return VmDatabase(file);
  });
}

@UseMoor(
  tables: [Foods],
)
class FoodsDatabase extends _$FoodsDatabase {
  // we tell the database where to store the data with this constructor
  FoodsDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  Future<void> insertFoods(List<FoodModel> models) async {
    // keep the favorites attribute
    final List<FoodEntity?> existent = await getFoods();
    await batch((batch) {
      batch.insertAll(
          foods,
          models
              .map((model) => model.entity(favorite: existent.firstWhere((entity) => entity?.id == model.id, orElse: () => null)?.favorite))
              .toList(),
          mode: InsertMode.insertOrReplace);
    });
  }

  Future<List<FoodEntity>> getFoods() {
    return (select(foods)).get();
  }


  Stream<List<FoodModel>> watchFoods(int limit, int offset) {
    return (select(foods)..limit(limit, offset: offset)).map((entity) => entity.model()).watch();
  }

  Stream<List<FoodModel>> watchFavoriteFoods() {
    return (select(foods)..where((food) => food.favorite)).map((entity) => entity.model()).watch();
  }

  Future<void> toggleFavorite(String id) {
    return update(foods).write(FoodsCompanion(id: Value(id), favorite: Value(true)));
  }

  Future<void> setFavorite({required String id, required bool favorite}) {
    return (update(foods)..where((t) => t.id.equals(id))).write(FoodsCompanion(favorite: Value(favorite)));
  }
}
