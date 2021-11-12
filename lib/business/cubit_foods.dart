import 'dart:async';

import 'package:cubit/cubit.dart';
import 'package:food_app/business/list_state.dart';
import 'package:food_app/business/mapper.dart';
import 'package:food_app/data/provider/api/api_constants.dart';
import 'package:food_app/data/model/food_model.dart';
import 'package:food_app/data/repository/food_list/ifoods_repository.dart';
import 'package:food_app/ui/base/list_item.dart';
import 'package:food_app/ui/base/pagination_loading/pagination_loading_item.dart';
import 'package:food_app/ui/food_list/food_item.dart';
import 'list_state.dart';

class FoodsCubit extends Cubit<ListState> {
  final IFoodsRepository _repository;
  StreamSubscription<List<FoodModel>>? _subscription;

  FoodsCubit({required IFoodsRepository repository}) : _repository = repository, super(Initial()) {
    initialData();
  }

  void initialData() async {
    try {
      emit(Loading());
      await _repository.initialData();
      _subscription = _repository.foodsStream(limit: DEFAULT_LIMIT, offset: 0).listen((models) {
        emit(Data(models.map((model) => model.item()).toList()..add(PaginationLoadingItem())));
      });
    } on Exception {
      emit(Error());
    }
  }

  void loadMore() async {
    try {
      final currentFoods = _currentFoods().where((element) => element is FoodItem); // TODO: The non-optimal solution, need to improve
      await _repository.loadMore(offset: currentFoods.length);
      _subscription?.cancel();
      _subscription = _repository.foodsStream(limit: DEFAULT_LIMIT + currentFoods.length, offset: 0).listen((models) {
        emit(Data(models.map((model) => model.item()).toList()..add(PaginationLoadingItem())));
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

  List<ListItem> _currentFoods() => (state is Data) ? (state as Data).items : List.empty();
}
