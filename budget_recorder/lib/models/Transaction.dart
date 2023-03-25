import 'package:budget_recorder/models/Account.dart';
import 'package:budget_recorder/models/Category.dart';

class Transaction {
  String transactionID, description, type, date;
  double amount;
  Account account;
  Category category;

  Transaction(
    this.transactionID,
    this.date,
    this.type,
    this.amount,
    this.account,
    this.category,
    this.description,
  );

  String getAccountName() {
    return account.name;
  }

  String getCategoryName() {
    return category.name;
  }

  static Transaction fromMap(Map map) {
    return Transaction(
      map['_id'].toString(),
      map['date'].toString(),
      map['type'].toString(),
      double.parse(map['amount'].toString()),
      map['account'],
      map['category'],
      map['description'].toString(),
    );
  }

}
