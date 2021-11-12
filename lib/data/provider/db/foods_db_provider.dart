import 'package:food_app/data/db/database.dart';
import 'package:food_app/data/model/food_model.dart';
import 'package:food_app/data/provider/db/ifoods_db_provider.dart';

class FoodsDbDataProvider extends IFoodsDbDataProvider {
  final FoodsDatabase _db;

  FoodsDbDataProvider({required FoodsDatabase db}) : _db = db;

  @override
  Stream<List<FoodModel>> foodsStream(int limit, int offset) {
    return _db.watchFoods(limit, offset);
  }

  @override
  Stream<List<FoodModel>> favoriteFoodsStream() {
    return _db.watchFavoriteFoods();
  }

  @override
  Future<void> insertFoods(List<FoodModel> models) {
    return _db.insertFoods(models);
  }

  @override
  Future<void> setFavorite({required String id, required bool favorite}) {
    return _db.setFavorite(id: id, favorite: favorite);
  }
}
