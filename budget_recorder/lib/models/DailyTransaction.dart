import 'package:budget_recorder/models/Transaction.dart';

import 'Date.dart';

class DailyTransaction {
  Date date;
  List<Transaction> transactions;

  DailyTransaction(this.date, this.transactions);

  String getTransactionDay() {
    return date.day;
  }

  String getTransactionMonthYear() {
    String day = "";
    day = date.month.padLeft(2, "0") + "-" + date.year;
    return day;
  }
}
