import 'package:food_app/data/db/database.dart';
import 'package:food_app/data/model/food_model.dart';
import 'package:food_app/ui/base/list_item.dart';
import 'package:food_app/ui/food_list/food_item.dart';

final String _foodPlaceholderUrl = "https://doc-04-7k-docs.googleusercontent.com/docs/securesc/2mok93j5c6gpe7re0aal5680k36ubprd/44vs0j2hesfm4eo8n8conuemub2qali9/1636693800000/05995797269608007347/05995797269608007347/1QsqqYLVGVk5XRcbmIi_t9OYvXxsTVDtb?e=download&authuser=2&nonce=q0usdb8gtlboa&user=05995797269608007347&hash=9u5sc9qv4sj9f5kgfhlfqq032kv3c03n";

extension FoodModelExtension on FoodModel {
  ListItem item() => FoodItem(
        id: this.id,
        name: this.name,
        description: this.description,
        imageUrl: (this.imageUrl == null) ? _foodPlaceholderUrl : this.imageUrl!,
        favorite: this.favorite,
      );

  FoodEntity entity({required bool? favorite}) => FoodEntity(
        id: this.id,
        name: this.name,
        description: this.description,
        imageUrl: (this.imageUrl == null) ? _foodPlaceholderUrl : this.imageUrl!,
        favorite: (favorite == null) ? false : favorite,
      );
}

extension FoodEntityExtension on FoodEntity {
  FoodModel model() => FoodModel(
        id: this.id,
        name: this.name,
        description: this.description,
        imageUrl: this.imageUrl,
        favorite: this.favorite,
      );
}
