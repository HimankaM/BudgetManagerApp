import 'package:budget_recorder/models/Account.dart';
import 'package:budget_recorder/models/Category.dart';
import 'package:budget_recorder/services/AccountService.dart';
import 'package:budget_recorder/widgets/dialogbox/custom_dialogbox.dart';
import 'package:flutter/material.dart';

//
// Manage Accounts - ADD/EDIT Forms
//

class AccountForm extends StatefulWidget {
  final String formType, accountID, accountDescription, accountName;
  final double accountBalance;
  final AccountService _accountService;
  const AccountForm({
    Key? key,
    required this.formType,
    required this.accountDescription,
    required this.accountName,
    required this.accountBalance,
    required this.accountID,
  })  : _accountService = const AccountService(),
        super(key: key);

  @override
  State<AccountForm> createState() => _AccountFormState();
}

class _AccountFormState extends State<AccountForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Account _account = Account("", "", 0, "");

  //Create new account
  void createNewAccount() async {
    //save form fields
    _formKey.currentState!.save();
    // print(_account.name);

    await widget._accountService.createAccount(_account).then(
      (value) {
        print(value);
        if (value!) {
          //if success
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return const CustomDialogBox(
                title: "Success!",
                descriptions: "Account Created Successfully!",
                text: "OK",
                route: "/home",
                arguments: {
                  "tabIndex": 2, //category tab
                },
                btnColor: "", //Error
              );
            },
          );
          //reset form
          _formKey.currentState!.reset();
        } else {
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
    ).onError(
      (error, stackTrace) {
        print(error);
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
      },
    );
  }

  //Edit account
  void editAccount() async {
    //save form fields
    _formKey.currentState!.save();
    // print(_account.name);

    await widget._accountService.updateAccount(_account).then(
      (value) {
        print(value);
        if (value!) {
          //if success
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return const CustomDialogBox(
                title: "Success!",
                descriptions: "Account Updated Successfully!",
                text: "OK",
                route: "/home",
                arguments: {
                  "tabIndex": 2, //category tab
                },
                btnColor: "", //Error
              );
            },
          );
          //reset form
          _formKey.currentState!.reset();
        } else {
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
    ).onError(
      (error, stackTrace) {
        print(error);
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
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(10),
        // color: Colors.amber,
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    initialValue: widget.accountName,
                    maxLength: 20,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: 'Account Name',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter account name';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _account.setAccName(value!);
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                  // ===============================================================
                  widget.formType == "Edit"
                      ? TextFormField(
                          initialValue: widget.accountBalance.toString(),
                          maxLength: 15,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            labelText: 'Account Balance',
                          ),
                          enabled: false,
                        )
                      : TextFormField(
                          initialValue: widget.accountBalance.toString(),
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            labelText: 'Amount',
                          ),
                          validator: (value) {
                            try {
                              if (value == null || value.isEmpty) {
                                return 'Please enter Transaction Amount';
                              } else if (double.parse(value) < 0) {
                                return 'Please enter amount grater than 0';
                              } else if (!RegExp(
                                      r'^\-?[0-9]+(?:\.[0-9]{1,2})?$')
                                  .hasMatch(value)) {
                                return 'Please enter amount to two decimal points';
                              }
                            } on Exception catch (_) {
                              //non numeric values E.g: 0.0.0
                              // return 'Please enter valid Transaction Amount';
                              return null;
                            }
                            return null;
                          },
                          onSaved: (value) {
                            if (value != null) {
                              _account.setAccBalance(double.parse(value));
                            }
                          },
                        ),

                  const SizedBox(
                    height: 25,
                  ),
                  // ===============================================================
                  TextFormField(
                    initialValue: widget.accountDescription,
                    keyboardType: TextInputType.multiline,
                    textInputAction: TextInputAction.newline,
                    minLines: 1,
                    maxLines: 3,
                    maxLength: 30,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: 'Description',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter account description';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _account.setAccDescription(value!);
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  // ===============================================================
                  ElevatedButton(
                    onPressed: () {
                      // Validate returns true if the form is valid, or false otherwise.
                      if (_formKey.currentState!.validate()) {
                        // If the form is valid, display a snackbar. In the real world,
                        // ScaffoldMessenger.of(context).showSnackBar(
                        //   const SnackBar(content: Text('Processing Data...')),
                        // );
                        if (_formKey.currentState!.validate()) {
                          if (widget.formType == "Edit") {
                            // set account id
                            _account.setAccID(widget.accountID);
                            //edit account
                            editAccount();
                          } else {
                            //create new
                            createNewAccount();
                          }
                        }
                      }
                    },
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      backgroundColor:
                          MaterialStateProperty.all(Colors.green[800]),
                      elevation: MaterialStateProperty.all(5),
                      padding:
                          MaterialStateProperty.all(const EdgeInsets.all(15)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.save,
                          size: 30,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          "${widget.formType == "Add" ? "Save" : "Update"}",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
