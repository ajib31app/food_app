import 'package:flutter/material.dart';
import 'package:food_app/business/cubit_favorites.dart';
import 'package:food_app/data/provider/db/ifoods_db_provider.dart';
import 'package:food_app/data/repository/favorites/favorites_repository.dart';
import 'package:food_app/ui/favorites/favorite_food_widget.dart';
import 'package:flutter_cubit/flutter_cubit.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';

class FavoriteFoodsModuleContainer {
  static Widget getScreenComposition(Injector singletonInjector) {
    return CubitProvider<FavoritesCubit>(
      create: (context) => FavoritesCubit(
        repository: FavoritesRepository(
          dbProvider: singletonInjector.get<IFoodsDbDataProvider>(),
        ),
      ),
      child: FavoriteFoodWidget(),
    );
  }
}
