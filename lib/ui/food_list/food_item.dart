import 'package:food_app/ui/base/list_item.dart';

class FoodItem extends ListItem {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final bool favorite;

  FoodItem({required this.id, required this.name, required this.description, required this.imageUrl, required this.favorite});
}
