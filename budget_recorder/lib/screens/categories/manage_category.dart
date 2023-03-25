import 'package:budget_recorder/components/forms/category_form.dart';
import 'package:budget_recorder/widgets/text/appbar_title_text.dart';
import 'package:flutter/material.dart';

//
// Manage Categories CRUD -UIs
//

class MangeCategoryData extends StatefulWidget {
  const MangeCategoryData({
    Key? key,
  }) : super(key: key);

  @override
  State<MangeCategoryData> createState() => _MangeCategoryDataState();
}

class _MangeCategoryDataState extends State<MangeCategoryData> {
  String? categoryType;
  String _formType = "Add";
  String _id = "";
  String _name = "";
  String _description = "";
  String _type = "";

  @override
  Widget build(BuildContext context) {
    RouteSettings? rs = ModalRoute.of(context)?.settings;

    if (rs!.arguments != null) {
      final Map arguments = rs.arguments as Map;
      print(arguments);
      _formType = "Edit";
      _id = arguments["id"];
      _name = arguments["name"];
      _type = arguments["type"];
      _description = arguments["description"];
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: AppBarTitleText(title: "$_formType Category"),
      ),
      body: SafeArea(
        child: CategoryForm(
          formType: _formType,
          categoryID: _id,
          categoryName: _name,
          categoryType: _type,
          categoryDescription: _description,
        ),
      ),
    );
  }
}
