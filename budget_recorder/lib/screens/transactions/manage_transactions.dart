import 'package:budget_recorder/components/forms/transaction_form.dart';
import 'package:budget_recorder/models/Account.dart';
import 'package:budget_recorder/models/Category.dart';
import 'package:budget_recorder/widgets/text/appbar_title_text.dart';
import 'package:flutter/material.dart';

//
// Manage all CRUD UIS - transactions
//

class ManageTransactions extends StatefulWidget {
  const ManageTransactions({Key? key}) : super(key: key);
  final String formType = "Add";

  @override
  State<ManageTransactions> createState() => _ManageTransactionsState();
}

class _ManageTransactionsState extends State<ManageTransactions> {
  String _formType = "Add";
  String _id = "";
  String _type = "";
  String _description = "";
  String _account = "";
  String _category = "";
  String _date = "";
  double _amount = 0;

  @override
  Widget build(BuildContext context) {
    RouteSettings? rs = ModalRoute.of(context)?.settings;

    if (rs!.arguments != null) {
      final Map arguments = rs.arguments as Map;
      print(arguments);
      _formType = "Edit";
      _id = arguments["id"];
      _type = arguments["type"];
      _amount = arguments["amount"];
      _date = arguments["date"];
      _description = arguments["description"];
      _category = arguments["category"];
      _account = arguments["account"];
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: AppBarTitleText(title: "$_formType Transaction"),
      ),
      body: SafeArea(
        child: TransactionForm(
          formType: _formType,
          transactionID: _id,
          transactionDate: _date,
          transactionAccount: _account,
          transactionAmount: _amount.toString(),
          transactionType: _type,
          transactionCategory: _category,
          transactionDescription: _description,
        ),
      ),
    );
  }
}
