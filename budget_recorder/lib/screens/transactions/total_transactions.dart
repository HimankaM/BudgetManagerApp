import 'package:budget_recorder/data/currency_data.dart';
import 'package:budget_recorder/providers/ThemeProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//
// summary transactions
//

class TotalTransactions extends StatefulWidget {
  const TotalTransactions({Key? key}) : super(key: key);

  @override
  State<TotalTransactions> createState() => _TotalTransactionsState();
}

class _TotalTransactionsState extends State<TotalTransactions> {
  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<ThemeProvider>(context);
    String appCurrencyName = themeChange.appCurrency;
    String appCurrencyLabel = getLabelByName(appCurrencyName);

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: //body scroll view
                SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Header Summery Section
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                              "$appCurrencyLabel 1000000.00",
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
                              "$appCurrencyLabel 1000000.00",
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
                              "$appCurrencyLabel 1000000.00",
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
                  // Daily Expense Cards
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: Card(
                      elevation: 6,
                      child: Container(
                        width: double.infinity,
                        margin: const EdgeInsets.all(15),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  children: const [
                                    // month
                                    Text(
                                      "Income Summary",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 22,
                                      ),
                                    ),
                                    //year
                                    Text(
                                      "Total Income vs Categories",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                          color: Colors.black45),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const Divider(
                              thickness: 1,
                              color: Colors.black12,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
