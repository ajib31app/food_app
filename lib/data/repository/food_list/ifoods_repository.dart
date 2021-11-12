import 'package:food_app/data/model/food_model.dart';

abstract class IFoodsRepository {
  Stream<List<FoodModel>> foodsStream({required int limit, required int offset});

  Future<void> initialData();

  Future<void> loadMore({required int offset});

  Future<void> setFavorite({required String id, required bool favorite});
}
