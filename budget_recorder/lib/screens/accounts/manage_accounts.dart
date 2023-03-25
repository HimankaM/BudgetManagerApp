import 'package:budget_recorder/components/forms/account_form.dart';
import 'package:budget_recorder/widgets/text/appbar_title_text.dart';
import 'package:flutter/material.dart';

//
// Manage Account CRUD -UIs
//

class ManageAccounts extends StatefulWidget {
  const ManageAccounts({Key? key}) : super(key: key);

  @override
  State<ManageAccounts> createState() => _ManageAccountsState();
}

class _ManageAccountsState extends State<ManageAccounts> {
  String _formType = "Add";
  String _id = "";
  String _name = "";
  String _description = "";
  double _amount = 0;

  @override
  Widget build(BuildContext context) {
    RouteSettings? rs = ModalRoute.of(context)?.settings;

    if (rs!.arguments != null) {
      final Map arguments = rs.arguments as Map;
      print(arguments);
      _formType = "Edit";
      _id = arguments["id"];
      _name = arguments["name"];
      _amount = arguments["amount"];
      _description = arguments["description"];
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: AppBarTitleText(title: "$_formType Account"),
      ),
      body: SafeArea(
        child: AccountForm(
          formType: _formType,
          accountID: _id,
          accountName: _name,
          accountBalance: _amount,
          accountDescription: _description,
        ),
      ),
    );
  }
}
