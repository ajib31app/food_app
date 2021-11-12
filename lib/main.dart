// @dart=2.9
import 'package:flutter/material.dart';
import 'package:food_app/di/food_list_module_container.dart';
import 'package:food_app/di/singleton_module_container.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Foods App',
      theme: ThemeData(primaryColor: Colors.white),
      home: FoodListModuleContainer.getScreenComposition(SingletonModuleContainer.get()),
    );
  }
}
