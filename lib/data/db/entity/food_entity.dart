import 'package:moor/moor.dart';

@DataClassName("FoodEntity")
class Foods extends Table {

  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get description => text()();
  TextColumn get imageUrl => text()();
  BoolColumn get favorite => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {id};
}