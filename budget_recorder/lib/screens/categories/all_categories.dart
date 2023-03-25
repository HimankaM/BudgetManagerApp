import 'dart:convert';

import 'package:budget_recorder/components/card/category_card.dart';
import 'package:budget_recorder/models/Category.dart';
import 'package:budget_recorder/services/CategoryService.dart';
import 'package:budget_recorder/widgets/dialogbox/custom_dialogbox.dart';
import 'package:budget_recorder/widgets/loaders/dataLoadingIndicator.dart';
import 'package:budget_recorder/widgets/loaders/noData.dart';
import 'package:budget_recorder/widgets/text/appbar_title_text.dart';
import 'package:flutter/material.dart';

//
// All Categories
//

class AllCategories extends StatefulWidget {
  final CategoryService _categoryService;
  const AllCategories({Key? key})
      : _categoryService = const CategoryService(),
        super(key: key);

  @override
  State<AllCategories> createState() => _AllCategoriesState();
}

class _AllCategoriesState extends State<AllCategories> {
  List<Category> allCategories = [];
  bool dataLoading = true;

  void getAllCategories() async {
    await widget._categoryService
        .getAllCategories()
        .then(
          (value) => setState(
            () {
              dataLoading = false;
              allCategories = value!.cast<Category>();
            },
          ),
        )
        .onError(
          (error, stackTrace) => print(error),
        );
  }

  @override
  initState() {
    super.initState();
    //get all categories
    getAllCategories();
  }

  void onGoBack(dynamic value) {
    getAllCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const AppBarTitleText(title: 'Categories'),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, "/category/manage").then(onGoBack);
              },
              child: const Icon(
                Icons.add_circle_rounded,
                size: 30.0,
              ),
            ),
          ),
        ],
        actionsIconTheme: const IconThemeData(
          size: 30.0,
          color: Colors.white,
          opacity: 10.0,
        ),
      ),
      body: SafeArea(
        child: dataLoading == true
            ? const DataLoadingIndicator()
            : allCategories.isNotEmpty
                ? ListView.builder(
                    padding: const EdgeInsets.all(5),
                    itemCount: allCategories.length,
                    itemBuilder: (BuildContext context, int index) {
                      return CategoryCard(
                        id: allCategories[index].cID,
                        name: allCategories[index].name,
                        descriptions: allCategories[index].description,
                        type: allCategories[index].type,
                        callBackFunction: onGoBack,
                      );
                    },
                  )
                : const NoData(),
      ),
    );
  }
}
