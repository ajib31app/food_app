import 'package:food_app/data/provider/api/ifoods_api_provider.dart';
import 'package:food_app/data/model/food_model.dart';
import 'package:food_app/data/provider/db/ifoods_db_provider.dart';
import 'package:food_app/data/repository/food_list/ifoods_repository.dart';

class FoodsRepository extends IFoodsRepository {
  final IFoodsApiDataProvider _apiProvider;
  final IFoodsDbDataProvider _dbProvider;

  FoodsRepository({required IFoodsApiDataProvider apiProvider, required IFoodsDbDataProvider dbProvider})
      : _apiProvider = apiProvider,
        _dbProvider = dbProvider;

  @override
  Stream<List<FoodModel>> foodsStream({required int limit, required int offset}) {
    return _dbProvider.foodsStream(limit, offset);
  }

  @override
  Future<void> initialData() async {
    return _dbProvider.insertFoods(await _apiProvider.initialData());
  }

  @override
  Future<void> loadMore({required int offset}) async {
    return _dbProvider.insertFoods(await _apiProvider.loadMore(offset: offset));
  }

  @override
  Future<void> setFavorite({required String id, required bool favorite}) {
    return _dbProvider.setFavorite(id: id, favorite: favorite);
  }
}
