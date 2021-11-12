import 'package:food_app/data/model/food_model.dart';
import 'package:food_app/data/provider/db/ifoods_db_provider.dart';
import 'package:food_app/data/repository/favorites/ifavorites_repository.dart';

class FavoritesRepository extends IFavoritesRepository {
  final IFoodsDbDataProvider _dbProvider;

  FavoritesRepository({required IFoodsDbDataProvider dbProvider}) : _dbProvider = dbProvider;

  @override
  Stream<List<FoodModel>> favoritesFoodsStream() {
    return _dbProvider.favoriteFoodsStream();
  }

  @override
  Future<void> setFavorite({required String id, required bool favorite}) {
    return _dbProvider.setFavorite(id: id, favorite: favorite);
  }
}
