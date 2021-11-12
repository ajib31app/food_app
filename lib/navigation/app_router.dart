import 'package:flutter/widgets.dart';
import 'package:food_app/di/favorite_foods_module_container.dart';
import 'package:food_app/di/singleton_module_container.dart';

class AppRouter {
  Route favoriteFoodsRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => FavoriteFoodsModuleContainer.getScreenComposition(SingletonModuleContainer.get()),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(1.0, 0.0);
        var end = Offset.zero;
        var tween = Tween(begin: begin, end: end);
        var offsetAnimation = animation.drive(tween);
        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    );
  }
}
