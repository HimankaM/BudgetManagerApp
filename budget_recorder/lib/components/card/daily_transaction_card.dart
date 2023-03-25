import 'package:budget_recorder/models/DailyTransaction.dart';
import 'package:budget_recorder/models/Transaction.dart';
import 'package:budget_recorder/services/TransactionServices.dart';
import 'package:budget_recorder/widgets/dialogbox/custom_dialogbox.dart';
import 'package:flutter/material.dart';

//
// DailyTransactionCard
//

class DailyTransactionCard extends StatefulWidget {
  final String appCurrencyLabel;
  final List<DailyTransaction> transactionsList;
  final TransactionService _transactionService;
  final Function callBackFunction;
  const DailyTransactionCard({
    Key? key,
    required this.appCurrencyLabel,
    required this.transactionsList,
    required this.callBackFunction,
  })  : _transactionService = const TransactionService(),
        super(key: key);

  @override
  State<DailyTransactionCard> createState() => _DailyTransactionCardState();
}

class _DailyTransactionCardState extends State<DailyTransactionCard> {
  double getTotalTransactionAmount(List<Transaction> list) {
    double totalExpense = 0;
    double totalIncome = 0;
    double amount = 0;
    double total = 0;
    list.forEach((item) {
      // print(item);
      amount = item.amount;
      if (item.type == "Expense") {
        totalExpense += amount;
      } else {
        totalIncome += amount;
      }
    });
    total = totalIncome - totalExpense;
    return total;
  }

  // deleteTransaction
  void deleteTransaction(Transaction transaction) async {
    await widget._transactionService
        .deleteTransaction(transaction)
        .then((value) {
      setState(
        () {
          if (value!) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return const CustomDialogBox(
                  title: "Success!",
                  descriptions: "Deleted Successfully!",
                  text: "OK",
                  route: "/home",
                  arguments: {
                    "tabIndex": 0, //transactions tab
                  },
                  btnColor: "", //Error
                );
              },
            ).then((value) => widget.callBackFunction(value));
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
      );
    }).onError(
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

  Widget getTransactionWidgets(List<Transaction> transaction) {
    return Column(
      children: transaction
          .map(
            (item) => GestureDetector(
              onTap: () => showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text(
                    'Transaction',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  content: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        // date
                        Container(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Date",
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                              Text(
                                item.date.split("T")[0],
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Type
                        Container(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Type",
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                              Text(
                                item.type,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: item.type == "Expense"
                                      ? Colors.red[900]
                                      : Colors.green[900],
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Account
                        Container(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Account",
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                              Text(
                                item.getAccountName(),
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Category
                        Container(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Category",
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                              Text(
                                item.getCategoryName(),
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Amount
                        Container(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Amount",
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                              Text(
                                item.amount.toString(),
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Description
                        Container(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text(
                                "Description",
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, bottom: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                item.description,
                                style: const TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pushNamed(
                          context, "/transaction/manage",
                          arguments: {
                            "id": item.transactionID,
                            "date": item.date,
                            "type": item.type,
                            "amount": item.amount,
                            "description": item.description,
                            "account": item.account.name,
                            "category": item.category.name
                          }).then((object) {
                        widget.callBackFunction(object);
                      }),
                      child: Text(
                        'Edit',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.green[900],
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        //close dialog
                        Navigator.pop(context, "Cancel");
                        //delete transaction
                        deleteTransaction(item);
                      },
                      child: Text(
                        'Delete',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.red[900],
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context, "Cancel"),
                      child: const Text(
                        'Cancel',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              child: Column(
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // account
                      Text(
                        item.getAccountName(),
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      // category
                      Text(
                        item.getCategoryName(),
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        "${widget.appCurrencyLabel} ${item.amount.toString()}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: item.type == "Expense"
                              ? Colors.red[900]
                              : Colors.green[900],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }

  Widget getMainTransactionWidgets(
      List<DailyTransaction> dailyTransactionsList) {
    return Column(
      children: dailyTransactionsList
          .map(
            (transaction) => Card(
              elevation: 6,
              child: Container(
                width: double.infinity,
                margin: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            // date
                            Text(
                              "Day-${transaction.getTransactionDay().padLeft(2, "0")}",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                              ),
                            ),
                            // month & year
                            Text(
                              transaction
                                  .getTransactionMonthYear()
                                  .padLeft(2, "0"),
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.black45),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            // date
                            const Text(
                              "Total",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            // total
                            Text(
                              "${widget.appCurrencyLabel} ${getTotalTransactionAmount(transaction.transactions)}",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const Divider(
                      thickness: 1,
                      color: Colors.black12,
                    ),
                    // transaction cards
                    getTransactionWidgets(transaction.transactions),
                  ],
                ),
              ),
            ),
          )
          .toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return getMainTransactionWidgets(widget.transactionsList);
  }
}
