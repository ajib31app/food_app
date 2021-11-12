import 'package:food_app/data/model/food_model.dart';

abstract class IFoodsDbDataProvider {
  Stream<List<FoodModel>> foodsStream(int limit, int offset);

  Stream<List<FoodModel>> favoriteFoodsStream();

  Future<void> insertFoods(List<FoodModel> models);

  Future<void> setFavorite({required String id, required bool favorite});
}
