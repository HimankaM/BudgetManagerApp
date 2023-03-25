import 'package:budget_recorder/widgets/text/appbar_title_text.dart';
import 'package:flutter/material.dart';

class AccountSummary extends StatefulWidget {
  const AccountSummary({Key? key}) : super(key: key);

  @override
  State<AccountSummary> createState() => _AccountSummaryState();
}

class _AccountSummaryState extends State<AccountSummary> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const AppBarTitleText(title: 'Account Summary'),
      ),
      body: SafeArea(
        child: Container(),
      ),
    );
  }
}
