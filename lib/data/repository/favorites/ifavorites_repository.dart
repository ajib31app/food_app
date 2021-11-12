import 'package:food_app/data/model/food_model.dart';

abstract class IFavoritesRepository {
  Stream<List<FoodModel>> favoritesFoodsStream();

  Future<void> setFavorite({required String id, required bool favorite});
}
