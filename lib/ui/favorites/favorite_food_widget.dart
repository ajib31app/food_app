import 'package:flutter/material.dart';
import 'package:food_app/business/cubit_favorites.dart';
import 'package:food_app/ui/base/list_item.dart';
import 'package:food_app/ui/base/pagination_loading/pagination_loading_item.dart';
import 'package:food_app/ui/base/pagination_loading/pagination_loading_widget.dart';
import 'package:food_app/ui/base/stub/text_stub_widget.dart';
import 'package:food_app/ui/food_list/food_item.dart';
import 'package:food_app/ui/favorites/favorite_food_card_widget.dart';
import 'package:flutter_cubit/flutter_cubit.dart';
import 'package:food_app/business/list_state.dart';

class FavoriteFoodWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FavoriteFoodWidgetState();
}

class _FavoriteFoodWidgetState extends State<FavoriteFoodWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Favorite Food ❤️"),
      ),
      body: CubitBuilder<FavoritesCubit, ListState>(builder: (context, state) {
        switch (state.runtimeType) {
          case Loading:
            return Center(child: CircularProgressIndicator());
          case Error:
            return TextStubWidget(stubText: "Error occurred...");
          case Data:
            return _buildGrid((state as Data).items);
          default:
            throw Exception("Unsupported state: $state");
        }
      }),
    );
  }

  Widget _buildGrid(List<ListItem> data) {
    // No possibility to make GridView child's height wrap by its content for now
    // https://github.com/flutter/flutter/issues/29035
    final double screenWidth = MediaQuery.of(context).size.width;
    const double gridSpacing = 8.0;
    const int crossAxisCount = 2;
    final double itemWidth = screenWidth / crossAxisCount - gridSpacing * (crossAxisCount + 1);
    final double childAspectRatio = itemWidth / FavoriteFoodCardWidget.CARD_HEIGHT;

    return GridView.builder(
      padding: EdgeInsets.all(gridSpacing),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        childAspectRatio: childAspectRatio,
        crossAxisSpacing: gridSpacing,
        mainAxisSpacing: gridSpacing,
      ),
      itemCount: data.length,
      itemBuilder: (BuildContext context, index) {
        return _buildRow(data[index]);
      },
      physics: const AlwaysScrollableScrollPhysics(),
    );
  }

  Widget _buildRow(ListItem item) {
    switch (item.runtimeType) {
      case FoodItem:
        return FavoriteFoodCardWidget(item: (item as FoodItem));
      case PaginationLoadingItem:
        return PaginationLoadingWidget();
      default:
        throw Exception("Unsupported item type: $item");
    }
  }
}
