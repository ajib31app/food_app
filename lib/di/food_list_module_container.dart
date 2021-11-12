import 'package:flutter/material.dart';
import 'package:food_app/business/cubit_foods.dart';
import 'package:food_app/data/provider/api/ifoods_api_provider.dart';
import 'package:food_app/data/provider/db/ifoods_db_provider.dart';
import 'package:food_app/data/repository/food_list/foods_repository.dart';
import 'package:food_app/ui/food_list/food_list_widget.dart';
import 'package:flutter_cubit/flutter_cubit.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';

class FoodListModuleContainer {
  static Widget getScreenComposition(Injector singletonInjector) {
    return CubitProvider<FoodsCubit>(
      create: (context) => FoodsCubit(
        repository: FoodsRepository(
          apiProvider: singletonInjector.get<IFoodsApiDataProvider>(),
          dbProvider: singletonInjector.get<IFoodsDbDataProvider>(),
        ),
      ),
      child: FoodListWidget(),
    );
  }
}
