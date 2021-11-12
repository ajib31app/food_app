import 'package:food_app/data/model/food_model.dart';

abstract class IFoodsApiDataProvider {
  Future<List<FoodModel>> initialData();

  Future<List<FoodModel>> loadMore({required int offset});
}
