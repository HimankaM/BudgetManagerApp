import 'package:budget_recorder/data/currency_data.dart';
import 'package:budget_recorder/models/Account.dart';
import 'package:budget_recorder/providers/ThemeProvider.dart';
import 'package:budget_recorder/services/AccountService.dart';
import 'package:budget_recorder/widgets/loaders/dataLoadingIndicator.dart';
import 'package:budget_recorder/widgets/loaders/noData.dart';
import 'package:flutter/material.dart';
import 'package:budget_recorder/components/card/account_card.dart';
import 'package:budget_recorder/widgets/text/appbar_title_text.dart';
import 'package:provider/provider.dart';

//
// All Accounts
//
class AllAccounts extends StatefulWidget {
  final AccountService _accountService;
  const AllAccounts({Key? key})
      : _accountService = const AccountService(),
        super(key: key);

  @override
  State<AllAccounts> createState() => _AllAccountsState();
}

class _AllAccountsState extends State<AllAccounts> {
  List<Account> allAccounts = <Account>[];
  bool dataLoading = true;

  void getAccounts() async {
    await widget._accountService
        .getAllAccounts()
        .then(
          (value) => setState(
            () {
              dataLoading = false;
              allAccounts = value!.cast<Account>();
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
    //get all accounts
    getAccounts();
  }

  void onGoBack(dynamic value) {
    print("onGoBack called");
    getAccounts();
  }

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<ThemeProvider>(context);
    String appCurrencyName = themeChange.appCurrency;
    String appCurrencyLabel = getLabelByName(appCurrencyName);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const AppBarTitleText(title: 'Accounts'),

        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, "/account/manage").then(onGoBack);
              },
              child: const Icon(
                Icons.add_circle_rounded,
                size: 30.0,
              ),
            ),
          ),
        ],

        // actions: <Widget>[
        //   PopupMenuButton(
        //     itemBuilder: (context) => [
        //       const PopupMenuItem(
        //         child: Text("Add"),
        //         value: 1,
        //       ),
        //       // const PopupMenuItem(
        //       //   child: Text("Summary"),
        //       //   value: 2,
        //       // )
        //     ],
        //     onSelected: (int menu) {
        //       if (menu == 1) {
        //         Navigator.pushNamed(context, "/account/manage").then(onGoBack);
        //       }
        //       // else if (menu == 2) {
        //       //   Navigator.pushNamed(context, "/account/summary");
        //       // }
        //     },
        //   ),
        // ],
      ),

      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     Navigator.pushNamed(context, "/account/manage").then(onGoBack);
      //   },
      //   backgroundColor: Theme.of(context).primaryColor,
      //   child: const Icon(
      //     Icons.add,
      //     size: 30,
      //   ),
      // ),

      body: SafeArea(
        child: Column(
          children: [
            // List view
            Expanded(
              child: dataLoading == true
                  ? const DataLoadingIndicator()
                  : allAccounts.isNotEmpty
                      ? ListView.builder(
                          padding: const EdgeInsets.all(5),
                          itemCount: allAccounts.length,
                          itemBuilder: (BuildContext context, int index) {
                            return SafeArea(
                              child: SingleChildScrollView(
                                child: AccountCard(
                                  id: allAccounts[index].accID,
                                  name: allAccounts[index].name,
                                  descriptions: allAccounts[index].description,
                                  balance: allAccounts[index].amount,
                                  callBackFunction: onGoBack,
                                ),
                              ),
                            );
                          },
                        )
                      : const NoData(),
            ),
          ],
        ),
      ),
    );
  }
}
