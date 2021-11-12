import 'dart:async';

import 'package:cubit/cubit.dart';
import 'package:food_app/business/list_state.dart';
import 'package:food_app/business/mapper.dart';
import 'package:food_app/data/repository/favorites/ifavorites_repository.dart';
import 'list_state.dart';

class FavoritesCubit extends Cubit<ListState> {
  final IFavoritesRepository _repository;
  StreamSubscription? _subscription;

  FavoritesCubit({required IFavoritesRepository repository}) : _repository = repository, super(Initial()) {
    favoritesData();
  }

  void favoritesData() async {
    try {
      emit(Loading());
      _subscription = _repository.favoritesFoodsStream().listen((models) {
        emit(Data(models.map((model) => model.item()).toList()));
      });
    } on Exception {
      emit(Error());
    }
  }

  void setFavorite({required String id, required bool favorite}) async {
    _repository.setFavorite(id: id, favorite: favorite);
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
