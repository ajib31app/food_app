import 'package:food_app/data/model/food_model.dart';
import 'package:dio/dio.dart';
import 'package:food_app/data/provider/api/api_constants.dart';
import 'package:food_app/data/provider/api/ifoods_api_provider.dart';

class FoodsApiDataProvider extends IFoodsApiDataProvider {
  final Dio _client;

  FoodsApiDataProvider({required Dio client}) : _client = client;

  @override
  Future<List<FoodModel>> initialData() async {
    try {
      final url = "$BASE_URL$FOODS_GET";
      final response = await _client.get(url);
      print(">> "+response.data['meals'].toString());
      final foods = List<FoodModel>.of(
        response.data['meals'].map<FoodModel>((json) => FoodModel(
              id: json['idMeal'],
              name: json['strMeal'],
              description: json['strInstructions'],
              imageUrl: json['strMealThumb'],
              favorite: false,
            )),
      );
      return foods;
    } catch (e) {
      throw (e);
    }
  }

  @override
  Future<List<FoodModel>> loadMore({required int offset}) async {
    try {
      final foods = <FoodModel>[];
      return foods;
    } catch (e) {
      throw (e);
    }
  }
}
