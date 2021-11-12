import 'package:flutter/material.dart';
import 'package:food_app/di/singleton_module_container.dart';
import 'package:food_app/navigation/app_router.dart';
import 'package:food_app/ui/base/divider/divider_widget.dart';
import 'package:food_app/ui/base/list_item.dart';
import 'package:food_app/ui/base/pagination_loading/pagination_loading_item.dart';
import 'package:food_app/ui/base/pagination_loading/pagination_loading_widget.dart';
import 'package:food_app/ui/base/stub/text_stub_widget.dart';
import 'package:food_app/ui/food_list/food_item.dart';
import 'package:food_app/ui/food_list/food_widget.dart';
import 'package:flutter_cubit/flutter_cubit.dart';
import 'package:food_app/business/cubit_foods.dart';
import 'package:food_app/business/list_state.dart';

class FoodListWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FoodListWidgetState();
}

class _FoodListWidgetState extends State<FoodListWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Food  😍"),
        actions: [IconButton(icon: Icon(Icons.list), onPressed: _pushFavorites)],
      ),
      body: CubitBuilder<FoodsCubit, ListState>(builder: (context, state) {
        switch (state.runtimeType) {
          case Loading:
            return Center(child: CircularProgressIndicator());
          case Error:
            return TextStubWidget(stubText: "Error occurred...");
          case Data:
            return _buildList((state as Data).items);
          default:
            throw Exception("Unsupported state: $state");
        }
      }),
    );
  }

  Widget _buildList(List<ListItem> data) => NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollInfo) {
          if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
            CubitProvider.of<FoodsCubit>(context).loadMore();
            return true;
          }
          return false;
        },
        child: ListView.separated(
          itemBuilder: (context, i) => _buildRow(data[i]),
          separatorBuilder: (context, index) => DividerWidget(),
          itemCount: data.length,
          // Possible ListView performance improvement
          // https://github.com/flutter/flutter/issues/22314
          physics: const AlwaysScrollableScrollPhysics(),
        ),
      );

  Widget _buildRow(ListItem item) {
    switch (item.runtimeType) {
      case FoodItem:
        return FoodWidget(item: (item as FoodItem));
      case PaginationLoadingItem:
        return PaginationLoadingWidget();
      default:
        throw Exception("Unsupported item type: $item");
    }
  }

  void _pushFavorites() {
    Navigator.of(context).push(SingletonModuleContainer.get().get<AppRouter>().favoriteFoodsRoute());
  }
}
