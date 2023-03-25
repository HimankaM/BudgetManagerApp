import 'dart:async';

import 'package:budget_recorder/data/currency_data.dart';
import 'package:budget_recorder/providers/ThemeProvider.dart';
import 'package:budget_recorder/services/AccountService.dart';
import 'package:budget_recorder/widgets/dialogbox/custom_dialogbox.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//
// All view(List View) - Account Card
//

class AccountCard extends StatefulWidget {
  final String name, descriptions, id;
  final double balance;
  final AccountService _accountService;
  final Function callBackFunction;
  const AccountCard({
    Key? key,
    required this.id,
    required this.name,
    required this.descriptions,
    required this.balance,
    required this.callBackFunction,
  })  : _accountService = const AccountService(),
        super(key: key);

  @override
  State<AccountCard> createState() => _AccountCardState();
}

class _AccountCardState extends State<AccountCard> {
  String? _selectedItemId;

  void deleteAccount(String id) async {
    await widget._accountService.deleteAccount(id).then((value) {
      setState(
        () {
          if (value!) {
            _selectedItemId = "";
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return const CustomDialogBox(
                  title: "Success!",
                  descriptions: "Deleted Successfully!",
                  text: "OK",
                  route: "/home",
                  arguments: {
                    "tabIndex": 2, //account tab
                  },
                  btnColor: "", //Error
                );
              },
            ).then((value) => widget.callBackFunction(value));
          } else {
            _selectedItemId = "";
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return const CustomDialogBox(
                  title: "Error!",
                  descriptions: "Please Try Again Later.",
                  text: "OK",
                  route: "",
                  arguments: "",
                  btnColor: "Error", //Error
                );
              },
            );
          }
        },
      );
    }).onError(
      (error, stackTrace) {
        print(error);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<ThemeProvider>(context);
    String appCurrencyName = themeChange.appCurrency;
    String appCurrencyLabel = getLabelByName(appCurrencyName);

    //delete dialog box
    AlertDialog alert = AlertDialog(
      title: const Text("Alert!"),
      content: const Text("Are you sure you want to delete this?"),
      actions: [
        ElevatedButton(
          child: const Text("Delete"),
          onPressed: () {
            deleteAccount(_selectedItemId!);
            Navigator.pop(context, false);
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.red[900]),
          ),
        ),
        ElevatedButton(
          child: const Text("Cancel"),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.green[900]),
          ),
          onPressed: () {
            _selectedItemId = "";
            Navigator.pop(context, false);
          },
        ),
      ],
    );

    return Container(
      // color: Theme.of(context).primaryColor,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      // widget.name,
                      "Account: ${widget.name}",
                      style: const TextStyle(
                        // color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      // widget.name,
                      "Balance: $appCurrencyLabel ${widget.balance}",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.red[900],
                        // color: Colors.green[900],
                      ),
                    ),
                    Text(
                      // widget.name,
                      "Description: ${widget.descriptions}",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Edit
                    IconButton(
                      onPressed: () {
                        // Navigator.pushNamed(context, "/account/manage");
                        Navigator.pushNamed(context, "/account/manage",
                            arguments: {
                              "id": widget.id,
                              "name": widget.name,
                              "description": widget.descriptions,
                              "amount": widget.balance,
                            }).then((object) {
                          widget.callBackFunction(object);
                        });
                      },
                      icon: Icon(
                        Icons.settings,
                        color: Colors.green[900],
                        size: 30,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    // Delete
                    IconButton(
                      onPressed: () {
                        _selectedItemId = widget.id;
                        // show the dialog
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return alert;
                          },
                        );
                      },
                      icon: Icon(
                        Icons.delete_forever,
                        color: Colors.red[900],
                        size: 30,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Divider(
            color: Colors.black54,
            thickness: 1,
          ),
        ],
      ),
    );
  }
}
