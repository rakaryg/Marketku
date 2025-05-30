import 'package:app_bar_with_search_switch/app_bar_with_search_switch.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marketku/controllers/category_sub/category_sub_controller.dart';
import 'package:marketku/models/category/category.dart';
import 'package:marketku/models/category_sub/category_sub.dart';
import 'package:marketku/views/screens/product/product_screen.dart';
import 'package:marketku/views/widgets/category_sub/category_sub_widget.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key, required this.category});

  final Category category;

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final _categorySubController = CategorySubController();
  late Future<List<CategorySub>> _categorySub;
  @override
  void initState() {
    super.initState();
    _categorySub =
        _categorySubController.onGetAllCategorySub(widget.category.name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWithSearchSwitch(
          onChanged: (value) {},
          appBarBuilder: (context) {
            return AppBar(
              title: Text(widget.category.name),
              actions: const [AppBarSearchButton()],
            );
          }),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 8,
                ),
                Container(
                  height: 150,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(widget.category.banner),
                        fit: BoxFit.scaleDown),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                CategorySubWidget(
                  categorySubData: _categorySub,
                  onClick: (value) {
                    Get.to(
                      ProductScreen(
                        categorySubData: value,
                      ),
                    );
                  },
                )
              ],
            )),
      ),
    );
  }
}
