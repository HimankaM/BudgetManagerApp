import 'dart:convert';
import 'package:budget_recorder/models/Account.dart';
import 'package:budget_recorder/models/Category.dart';
import 'package:budget_recorder/models/DailyTransaction.dart';
import 'package:budget_recorder/models/Date.dart';
import 'package:budget_recorder/models/Transaction.dart';
import 'package:budget_recorder/services/ServiceConst.dart';
import 'package:http/http.dart';

class TransactionService {
  static const String endpoint = "$Backend_server_URI/api/transactions";

  const TransactionService();

  //get all daily transactions
  //Month and Year format -> "02-2022"
  Future<List?> getAllDailyTransactions(String monthYear) async {
    try {
      List<DailyTransaction> listDailyTransactions = [];
      Response response = await get(Uri.parse("$endpoint/day/$monthYear"));
      if (response.statusCode == 200) {
        var jsonData = response.body;
        var data = jsonDecode(jsonData);

        if (data["success"]) {
          var dataArr = data["transactions"];
          dataArr.forEach((item) {
            List<Transaction> listTransactions = [];
            var transactionsArr = item["transactions"];
            transactionsArr.forEach((jsonTransaction) {
              // print(jsonTransaction);
              jsonTransaction["account"] =
                  Account.fromMap(jsonTransaction["account"]);
              jsonTransaction["category"] =
                  Category.fromMap(jsonTransaction["category"]);
              listTransactions.add(Transaction.fromMap(jsonTransaction));
            });
            // print(listTransactions);
            DailyTransaction dailyTransaction =
                DailyTransaction(Date.fromMap(item["_id"]), listTransactions);
            listDailyTransactions.add(dailyTransaction);
          });
          // print(listDailyTransactions);
          return listDailyTransactions;
        } else {
          return Future.error('Error 1!');
        }
      } else {
        return Future.error('Error 2!');
      }
    } catch (e) {
      print(e);
      return Future.error('Execeptional Error !');
    }
  }

  //get all monthly transactions
  //Month and Year format -> "2022"
  Future<List?> getAllMonthlyTransactions(String year) async {
    try {
      List<DailyTransaction> listDailyTransactions = [];
      Response response = await get(Uri.parse("$endpoint/month/$year"));
      if (response.statusCode == 200) {
        var jsonData = response.body;
        var data = jsonDecode(jsonData);

        if (data["success"]) {
          var dataArr = data["transactions"];
          dataArr.forEach((item) {
            List<Transaction> listTransactions = [];
            var transactionsArr = item["transactions"];
            transactionsArr.forEach((jsonTransaction) {
              // print(jsonTransaction);
              jsonTransaction["account"] =
                  Account.fromMap(jsonTransaction["account"]);
              jsonTransaction["category"] =
                  Category.fromMap(jsonTransaction["category"]);
              listTransactions.add(Transaction.fromMap(jsonTransaction));
            });
            // print(listTransactions);
            DailyTransaction dailyTransaction =
                DailyTransaction(Date.fromMap(item["_id"]), listTransactions);
            listDailyTransactions.add(dailyTransaction);
          });
          // print(listDailyTransactions);
          return listDailyTransactions;
        } else {
          return Future.error('Error 1!');
        }
      } else {
        return Future.error('Error 2!');
      }
    } catch (e) {
      print(e);
      return Future.error('Execeptional Error !');
    }
  }

  //Create new transaction
  Future<bool?> createTransaction(var transaction) async {
    bool createdSuccess = false;

    String formattedDate = "";
    String date = transaction["date"];

    var arr = date.split(' ');
    var arr2 = arr[1].split('.');

    formattedDate = arr[0] + "T" + arr2[0];
    print(formattedDate);

    var formData1 = <String, dynamic>{
      "date": formattedDate,
      "type": transaction["type"],
      "amount": transaction["amount"],
      "description": transaction["description"],
      "account": transaction["account"],
      "category": transaction["category"]
    };
    var formData2 = <String, dynamic>{
      "date": formattedDate,
      "type": transaction["type"],
      "amount": transaction["amount"],
      "account": transaction["account"],
      "category": transaction["category"]
    };

    try {
      Response response = await post(
        Uri.parse(endpoint),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          transaction["description"] == null ? formData2 : formData1,
        ),
      );
      if (response.statusCode == 201) {
        var jsonData = response.body;
        var data = jsonDecode(jsonData);

        if (data["success"]) {
          createdSuccess = true;
          return createdSuccess;
        } else {
          return Future.error('Error 1!');
        }
      } else {
        return Future.error('Error 2!');
      }
    } catch (e) {
      print(e);
      return Future.error('Exceptional Error!');
    }
  }

  //delete transaction
  Future<bool?> deleteTransaction(Transaction transaction) async {
    bool deleteSuccess = false;
    try {
      String id = transaction.transactionID;
      var formData = {
        "type": transaction.type,
        "amount": transaction.amount,
        "account": transaction.account.accID,
      };
      print(formData);
      Response response = await post(
        Uri.parse(endpoint + '/delete/' + id),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(formData),
      );
      if (response.statusCode == 200) {
        var jsonData = response.body;
        var data = jsonDecode(jsonData);

        if (data["success"]) {
          deleteSuccess = true;
          return deleteSuccess;
        } else {
          return Future.error('Error 1!');
        }
      } else {
        return Future.error('Error 2!');
      }
    } catch (e) {
      print(e);
      return Future.error('Exceptional Error!');
    }
  }

  //update transaction
  Future<bool?> updateTransactionData(String id, var transData) async {
    bool updateSuccess = false;
    String formattedDate = "";
    String date = transData["date"];

    var arr = date.split(' ');
    var arr2 = arr[1].split('.');

    formattedDate = arr[0] + "T" + arr2[0] + ":00";

    var formData = {
      'date': formattedDate,
      'description': transData["description"],
    };

    print(formattedDate);

    try {
      Response response = await patch(
        Uri.parse(endpoint + "/" + id),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(formData),
      );
      print(response.statusCode);
      if (response.statusCode == 200) {
        var jsonData = response.body;
        var data = jsonDecode(jsonData);

        if (data["success"]) {
          updateSuccess = true;
          return updateSuccess;
        } else {
          return Future.error('Error! 1');
        }
      } else {
        return Future.error('Error! 2');
      }
    } catch (e) {
      print(e);
      return Future.error('Exceptional Error!');
    }
  }
}
