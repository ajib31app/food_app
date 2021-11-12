import 'package:dio/dio.dart';
import 'package:food_app/data/db/database.dart';
import 'package:food_app/data/provider/api/foods_api_provider.dart';
import 'package:food_app/data/provider/api/ifoods_api_provider.dart';
import 'package:food_app/data/provider/db/foods_db_provider.dart';
import 'package:food_app/data/provider/db/ifoods_db_provider.dart';
import 'package:food_app/navigation/app_router.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';

class SingletonModuleContainer {
  static Injector? _instance;

  static Injector get() {
    if (_instance == null) {
      _instance = Injector()
        ..map((injector) => AppRouter(), isSingleton: true)
        ..map((injector) => Dio(), isSingleton: true)
        ..map<IFoodsApiDataProvider>((injector) => FoodsApiDataProvider(client: injector.get<Dio>()), isSingleton: true)
        ..map((injector) => FoodsDatabase(), isSingleton: true)
        ..map<IFoodsDbDataProvider>((injector) => FoodsDbDataProvider(db: injector.get<FoodsDatabase>()), isSingleton: true);
    }
    return _instance!;
  }
}
