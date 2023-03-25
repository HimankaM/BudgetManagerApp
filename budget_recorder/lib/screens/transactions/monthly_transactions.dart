import 'package:budget_recorder/data/currency_data.dart';
import 'package:budget_recorder/models/DailyTransaction.dart';
import 'package:budget_recorder/models/Transaction.dart';
import 'package:budget_recorder/providers/ThemeProvider.dart';
import 'package:budget_recorder/services/TransactionServices.dart';
import 'package:budget_recorder/widgets/loaders/dataLoadingIndicator.dart';
import 'package:budget_recorder/widgets/loaders/noData.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

//
// Transactions monthly
//

class MonthlyTransactions extends StatefulWidget {
  final TransactionService _transactionService;
  const MonthlyTransactions({
    Key? key,
    String? currData,
  })  : _transactionService = const TransactionService(),
        super(key: key);

  @override
  State<MonthlyTransactions> createState() => _MonthlyTransactionsState();
}

class _MonthlyTransactionsState extends State<MonthlyTransactions> {
  DateTime selectedDate = DateTime.now();
  bool dataLoading = true;
  List<DailyTransaction> allMonthlyTransactions = [];
  double totalAmount = 0;
  double totalIncome = 0;
  double totalExpense = 0;

  // get all transactions monthly
  void getMonthlyTransactions(DateTime date) async {
    String day = date.toString();
    List dateList = day.split("-");
    String month = dateList[1];
    String year = dateList[0];
    // print(monthDate);
    await widget._transactionService
        .getAllMonthlyTransactions(year)
        .then((value) {
      setState(
        () {
          dataLoading = false;
          // print(value);
          allMonthlyTransactions = value!.cast<DailyTransaction>();
        },
      );
      //calculate totals
      getTotalTransactionAmount(allMonthlyTransactions);
    }).onError((error, stackTrace) {
      print(error);
    });
  }

  //calculate total of the month
  double getTotalMonthly(List<Transaction> transList, String type) {
    double tExpense = 0;
    double tIncome = 0;
    double amount = 0;
    double total = 0;

    //monthly transactions
    transList.forEach((item) {
      amount = item.amount;
      if (item.type == "Expense") {
        tExpense += amount;
      } else {
        tIncome += amount;
      }
    });
    total = tIncome - tExpense;

    double val = 0;
    switch (type) {
      case "Income":
        val = tIncome;
        break;
      case "Expense":
        val = tExpense;
        break;
      case "Total":
        val = total;
        break;
      default:
        val = 0;
    }
    return val;
  }

  //calculate total of the year
  void getTotalTransactionAmount(List<DailyTransaction> list) {
    double tExpense = 0;
    double tIncome = 0;
    double amount = 0;
    double total = 0;

    //monthly transactions
    list.forEach((dTrans) {
      List<Transaction> transList = dTrans.transactions;
      //transaction
      transList.forEach((item) {
        amount = item.amount;
        if (item.type == "Expense") {
          tExpense += amount;
        } else {
          tIncome += amount;
        }
      });
    });
    total = tIncome - tExpense;
    setState(() {
      totalAmount = total;
      totalIncome = tIncome;
      totalExpense = tExpense;
    });
  }

  @override
  void initState() {
    super.initState();
    //get all transactions monthly
    getMonthlyTransactions(selectedDate);
  }

  Future<void> _openYearPicker({
    required BuildContext context,
  }) async {
    final selected = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Select Year"),
          content: SizedBox(
            width: 300,
            height: 300,
            child: YearPicker(
              firstDate: DateTime(DateTime.now().year - 100, 1),
              lastDate: DateTime(DateTime.now().year + 100, 1),
              initialDate: DateTime.now(),
              selectedDate: selectedDate,
              onChanged: (DateTime dateTime) {
                setState(() {
                  selectedDate = dateTime;
                });
                //load monthly transactions
                getMonthlyTransactions(dateTime);
                // close the dialog when year is selected.
                Navigator.pop(context);
              },
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<ThemeProvider>(context);
    String appCurrencyName = themeChange.appCurrency;
    String appCurrencyLabel = getLabelByName(appCurrencyName);

    return Scaffold(
      body: Column(
        children: [
          // Current date time header
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //=====================================================================
              Padding(
                padding: const EdgeInsets.all(15),
                child: GestureDetector(
                  onTap: () {
                    _openYearPicker(context: context);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: Colors.amberAccent,
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black,
                          blurRadius: 2.0,
                          spreadRadius: 0.0,
                          offset: Offset(
                              2.0, 2.0), // shadow direction: bottom right
                        )
                      ],
                    ),
                    child: Row(
                      children: [
                        Text(
                          'Year - ${selectedDate.year}',
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 25,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Icon(
                          Icons.calendar_today,
                          size: 24.0,
                          semanticLabel: 'Select Year',
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          dataLoading == true
              ? const DataLoadingIndicator()
              : Expanded(
                  child: //body scroll view
                      SingleChildScrollView(
                    child: allMonthlyTransactions.isNotEmpty
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // Header Summery Section
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: Column(
                                      children: [
                                        const Text(
                                          "Income",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 18,
                                          ),
                                        ),
                                        Text(
                                          "$appCurrencyLabel $totalIncome",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                            color: Colors.green[900],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: Column(
                                      children: [
                                        const Text(
                                          "Expenses",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 18,
                                          ),
                                        ),
                                        Text(
                                          "$appCurrencyLabel $totalExpense",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                            color: Colors.red[900],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: Column(
                                      children: [
                                        const Text(
                                          "Total",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 18,
                                          ),
                                        ),
                                        Text(
                                          "$appCurrencyLabel $totalAmount",
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const Divider(
                                thickness: 1,
                                color: Colors.black12,
                              ),
                              // monthly Expense Cards
                              // ========================================================================================
                              Column(
                                children: allMonthlyTransactions
                                    .map(
                                      (transaction) => Padding(
                                        padding: const EdgeInsets.all(5),
                                        child: Card(
                                          elevation: 6,
                                          child: Container(
                                            width: double.infinity,
                                            margin: const EdgeInsets.all(15),
                                            child: Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Column(
                                                      children: [
                                                        // month
                                                        Text(
                                                          DateFormat('MMMM')
                                                              .format(
                                                            DateTime(
                                                              0,
                                                              int.parse(
                                                                  transaction
                                                                      .date
                                                                      .month),
                                                            ),
                                                          ),
                                                          style:
                                                              const TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 22,
                                                          ),
                                                        ),
                                                        //year
                                                        Text(
                                                          transaction.date.year,
                                                          style:
                                                              const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 18,
                                                                  color: Colors
                                                                      .black45),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                const Divider(
                                                  thickness: 1,
                                                  color: Colors.black12,
                                                ),
                                                //==================================================================
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    // Income
                                                    Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        // type
                                                        const Text(
                                                          "Income",
                                                          style: TextStyle(
                                                            fontSize: 18,
                                                          ),
                                                        ),
                                                        // total
                                                        Text(
                                                          "$appCurrencyLabel ${getTotalMonthly(transaction.transactions, "Income")}",
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 18,
                                                            color: Colors
                                                                .green[900],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    //Expenses
                                                    Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        // type
                                                        const Text(
                                                          "Expense",
                                                          style: TextStyle(
                                                            fontSize: 18,
                                                          ),
                                                        ),
                                                        // total
                                                        Text(
                                                          "$appCurrencyLabel ${getTotalMonthly(transaction.transactions, "Expense")}",
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 18,
                                                            color:
                                                                Colors.red[900],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    // total
                                                    Column(
                                                      children: [
                                                        const Text(
                                                          "Total",
                                                          style: TextStyle(
                                                            fontSize: 18,
                                                          ),
                                                        ),
                                                        Text(
                                                          "$appCurrencyLabel ${getTotalMonthly(transaction.transactions, "Total")}",
                                                          style:
                                                              const TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 18,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                    .toList(),
                              ),

                              // ========================================================================================
                            ],
                          )
                        : const NoData(),
                  ),
                ),
        ],
      ),
    );
  }
}
