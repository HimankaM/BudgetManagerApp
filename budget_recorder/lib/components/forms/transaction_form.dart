import 'package:budget_recorder/models/Account.dart';
import 'package:budget_recorder/models/Category.dart';
import 'package:budget_recorder/services/AccountService.dart';
import 'package:budget_recorder/services/CategoryService.dart';
import 'package:budget_recorder/services/TransactionServices.dart';
import 'package:budget_recorder/widgets/dialogbox/custom_dialogbox.dart';
import 'package:budget_recorder/widgets/loaders/dataLoadingIndicator.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

//
// Manage Transactions - ADD/EDIT Forms
//

class TransactionForm extends StatefulWidget {
  final String formType,
      transactionID,
      transactionDate,
      transactionType,
      transactionAccount,
      transactionCategory,
      transactionAmount,
      transactionDescription;

  final AccountService _accountService;
  final CategoryService _categoryService;
  final TransactionService _transactionService;

  const TransactionForm({
    Key? key,
    required this.formType,
    required this.transactionID,
    required this.transactionDate,
    required this.transactionAccount,
    required this.transactionType,
    required this.transactionCategory,
    required this.transactionDescription,
    required this.transactionAmount,
  })  : _accountService = const AccountService(),
        _categoryService = const CategoryService(),
        _transactionService = const TransactionService(),
        super(key: key);

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  List<Account> allAccounts = <Account>[];
  List<Category> allCategories = <Category>[];
  bool dataLoading = true;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? _selectedAccount, _selectedCategory, _transactionType;
  String _initialDateVal = DateTime.now().toString();
  String _dateFormatted = "";
  String _selectedID = "";

  var transactionData = {
    "date": "",
    "type": "",
    "amount": "",
    "description": "",
    "account": "",
    "category": ""
  };

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

  void getAccounts() async {
    await widget._accountService
        .getAllAccounts()
        .then(
          (value) => setState(
            () {
              allAccounts = value!.cast<Account>();
              //get all categories
              getAllCategories();
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

    if (widget.formType == "Edit") {
      String dateUtc = widget.transactionDate;
      String formattedDate = "";

      var arr1 = dateUtc.split('T');
      var arr2 = arr1[1].split('.');

      formattedDate = arr1[0] + " " + arr2[0];

      var dateTime = DateFormat("yyyy-MM-dd HH:mm:ss").parse(formattedDate, true);
      var dateLocal = dateTime.toLocal();

      // print(dateLocal);

      _dateFormatted = dateLocal.toString();
    }
  }

  //=================Services==========================================================================

  //Create new transaction
  void createNewTransaction() async {
    //save form fields
    _formKey.currentState!.save();
    // print(_transaction.name);

    await widget._transactionService.createTransaction(transactionData).then(
      (value) {
        print(value);
        if (value!) {
          //if success
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return const CustomDialogBox(
                title: "Success!",
                descriptions: "Transaction Created Successfully!",
                text: "OK",
                route: "/home",
                arguments: {
                  "tabIndex": 0, //transaction tab
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
              title: "Exceptional Error!",
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

  //update transaction
  void updateTransaction() async {
    //save form fields
    _formKey.currentState!.save();
    // print(_account.name);

    await widget._transactionService
        .updateTransactionData(_selectedID, transactionData)
        .then(
      (value) {
        print(value);
        if (value!) {
          //if success
          _selectedID = "";
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return const CustomDialogBox(
                title: "Success!",
                descriptions: "Transaction Updated Successfully!",
                text: "OK",
                route: "/home",
                arguments: {
                  "tabIndex": 0, //trans tab
                },
                btnColor: "", //Error
              );
            },
          );
          //reset form
          _formKey.currentState!.reset();
        } else {
          _selectedID = "";
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

  void setCategoryTypeByID(List<Category> list, String id) {
    String categoryType = "";

    list.forEach((element) {
      if (element.cID == id) {
        categoryType = element.type;
      }
    });

    _transactionType = categoryType;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: dataLoading == true
          ? const DataLoadingIndicator()
          : Container(
              padding: const EdgeInsets.all(10),
              // color: Colors.amber,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    child: widget.formType == "Edit"
                        ? Text(
                            "Transaction Type : ${widget.transactionType}",
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: widget.transactionType == "Income"
                                  ? Colors.blue[900]
                                  : Colors.pink[900],
                            ),
                          )
                        : Text(
                            "Transaction Type : ${_transactionType ?? "None"}",
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: _transactionType == "Income"
                                  ? Colors.green[900]
                                  : Colors.red[900],
                            ),
                          ),
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const SizedBox(
                          height: 10,
                        ),

                        Stack(
                          children: <Widget>[
                            DateTimePicker(
                              type: DateTimePickerType.dateTimeSeparate,
                              initialValue: widget.formType == "Edit"
                                  ? _dateFormatted
                                  : _initialDateVal,
                              firstDate: DateTime(DateTime.now().year - 20),
                              lastDate: DateTime(DateTime.now().year + 20),
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                labelText: 'Date & Time',
                              ),
                              onChanged: (value) => print(value),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter Transaction Date and Time';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                transactionData = {
                                  "date": value.toString(),
                                  "type": _transactionType.toString(),
                                  "amount":
                                      transactionData['amount'].toString(),
                                  "description":
                                      transactionData['description'].toString(),
                                  "account": _selectedAccount.toString(),
                                  "category": _selectedCategory.toString()
                                };
                              },
                            )
                          ],
                        ),

                        const SizedBox(
                          height: 10,
                        ),

                        // ===============================================================
                        widget.formType == "Edit"
                            ? TextFormField(
                                style: const TextStyle(color: Colors.black),
                                initialValue: widget.transactionAccount,
                                maxLength: 15,
                                decoration: InputDecoration(
                                  // icon: Icon(Icons.disabled_by_default, color: Colors.red[900],),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  labelText: 'Account',
                                  labelStyle:
                                      const TextStyle(color: Colors.black),
                                ),
                                enabled: false,
                              )
                            : DropdownButtonFormField(
                                hint: const Text("Account"),
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                validator: (value) =>
                                    value == null ? "Select a Account" : null,
                                // dropdownColor: Colors.blueAccent,
                                // value: _selectedAccount,
                                onChanged: (String? newValue) {
                                  setState(() {
                                    // print(newValue);
                                    _selectedAccount = newValue!;
                                  });
                                },
                                items: allAccounts
                                    .map<DropdownMenuItem<String>>(
                                        (Account account) {
                                  return DropdownMenuItem<String>(
                                    value: account.accID,
                                    child: Text(account.name),
                                  );
                                }).toList(),
                              ),
                        const SizedBox(
                          height: 10,
                        ),

                        // ===============================================================
                        widget.formType == "Edit"
                            ? TextFormField(
                                style: const TextStyle(color: Colors.black),
                                initialValue: widget.transactionCategory,
                                maxLength: 15,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  labelText: 'Category',
                                  labelStyle:
                                      const TextStyle(color: Colors.black),
                                ),
                                enabled: false,
                              )
                            : DropdownButtonFormField(
                                hint: const Text("Category"),
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                validator: (value) =>
                                    value == null ? "Select a Category" : null,
                                // dropdownColor: Colors.blueAccent,
                                // value: _selectedCategory,
                                onChanged: (String? newValue) {
                                  setState(() {
                                    print(newValue);
                                    //set transaction type
                                    setCategoryTypeByID(
                                        allCategories, newValue!);
                                    //set new value
                                    _selectedCategory = newValue;
                                  });
                                },
                                items: allCategories
                                    .map<DropdownMenuItem<String>>(
                                        (Category category) {
                                  return DropdownMenuItem<String>(
                                    value: category.cID,
                                    child: Text(category.name),
                                  );
                                }).toList(),
                              ),
                        const SizedBox(
                          height: 10,
                        ),

                        // ===============================================================
                        // TextFormField(
                        //   enabled: false,
                        //   initialValue: _transactionType,
                        //   decoration: InputDecoration(
                        //     border: OutlineInputBorder(
                        //       borderRadius: BorderRadius.circular(10),
                        //     ),
                        //     labelText: 'Type',
                        //   ),
                        // ),
                        // DropdownButtonFormField(
                        //   hint: const Text("Type"),
                        //   decoration: InputDecoration(
                        //     border: OutlineInputBorder(
                        //       borderRadius: BorderRadius.circular(10),
                        //     ),
                        //   ),
                        //   // dropdownColor: Colors.blueAccent,
                        //   value: _transactionType,
                        //   onChanged: null,
                        //   items: <String>['Income', 'Expense']
                        //       .map<DropdownMenuItem<String>>((String value) {
                        //     return DropdownMenuItem<String>(
                        //       value: value,
                        //       child: Text(value),
                        //     );
                        //   }).toList(),
                        // ),

                        const SizedBox(
                          height: 10,
                        ),

                        // ===============================================================
                        widget.formType == "Edit"
                            ? TextFormField(
                                initialValue: widget.transactionAmount,
                                style: const TextStyle(color: Colors.black),
                                maxLength: 15,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  labelText: 'Amount',
                                  labelStyle:
                                      const TextStyle(color: Colors.black),
                                ),
                                enabled: false,
                              )
                            : TextFormField(
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
                                    } else if (double.parse(value) <= 0) {
                                      return 'Please enter amount grater than 0';
                                    } else if (!RegExp(r'^\d+\.?\d{0,2}$')
                                        .hasMatch(value)) {
                                      return 'Please enter amount to two decimal points';
                                    }
                                  } on Exception catch (_) {
                                    //non numeric values E.g: 0.0.0
                                    return 'Please enter valid Transaction Amount';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  transactionData = {
                                    "date": transactionData['date'].toString(),
                                    "type": _transactionType.toString(),
                                    "amount": value.toString(),
                                    "description":
                                        transactionData['description']
                                            .toString(),
                                    "account": _selectedAccount.toString(),
                                    "category": _selectedCategory.toString()
                                  };
                                },
                              ),
                        const SizedBox(
                          height: 10,
                        ),

                        // ===============================================================
                        TextFormField(
                          initialValue: widget.transactionDescription,
                          keyboardType: TextInputType.multiline,
                          textInputAction: TextInputAction.newline,
                          minLines: 1,
                          maxLines: 3,
                          maxLength: 40,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            labelText: 'Description',
                          ),
                          onSaved: (value) {
                            transactionData = {
                              "date": transactionData['date'].toString(),
                              "type": _transactionType.toString(),
                              "amount": transactionData['amount'].toString(),
                              "description": value.toString(),
                              "account": _selectedAccount.toString(),
                              "category": _selectedCategory.toString()
                            };
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),

                        // -------------------------------------------------------------------------
                        ElevatedButton(
                          onPressed: () {
                            // Validate returns true if the form is valid, or false otherwise.
                            if (_formKey.currentState!.validate()) {
                              if (widget.formType == "Edit") {
                                _selectedID = widget.transactionID;
                                updateTransaction();
                              } else {
                                //create new
                                createNewTransaction();
                              }
                              // If the form is valid, display a snackbar. In the real world,
                              // ScaffoldMessenger.of(context).showSnackBar(
                              //   const SnackBar(
                              //       content: Text('Processing Data...')),
                              // );
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
                            padding: MaterialStateProperty.all(
                                const EdgeInsets.all(15)),
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
