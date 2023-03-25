import 'dart:convert';
import 'package:budget_recorder/models/Account.dart';
import 'package:budget_recorder/services/ServiceConst.dart';
import 'package:http/http.dart';

class AccountService {
  static const String endpoint = "$Backend_server_URI/api/accounts/";

  const AccountService();

  Future<List?> getAllAccounts() async {
    //get all accounts
    try {
      List<Account> accountList = [];
      Response response = await get(Uri.parse(endpoint));
      if (response.statusCode == 200) {
        var jsonData = response.body;
        var data = jsonDecode(jsonData);

        if (data["success"]) {
          var dataArr = data["accounts"];
          dataArr.forEach((item) {
            accountList.add(Account.fromMap(item));
          });
          print(accountList);
          return accountList;
        } else {
          return Future.error('Error!');
        }
      } else {
        return Future.error('Error!');
      }
    } catch (e) {
      print(e);
      return Future.error('Error!');
    }
  }

  //Create new account
  Future<bool?> createAccount(Account accountData) async {
    bool createdSuccess = false;
    var formData = <String, dynamic>{
      'name': accountData.name,
      'amount': accountData.amount,
      'description': accountData.description,
    };

    try {
      print(accountData.name);
      Response response = await post(
        Uri.parse(endpoint),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(formData),
      );
      if (response.statusCode == 201) {
        var jsonData = response.body;
        var data = jsonDecode(jsonData);

        if (data["success"]) {
          createdSuccess = true;
          return createdSuccess;
        } else {
          return Future.error('Error!');
        }
      } else {
        return Future.error('Error!');
      }
    } catch (e) {
      print(e);
      return Future.error('Error!');
    }
  }

  //delete account
  Future<bool?> deleteAccount(String id) async {
    bool deleteSuccess = false;
    try {
      print(id);
      Response response = await delete(
        Uri.parse(endpoint + id),
      );
      if (response.statusCode == 200) {
        var jsonData = response.body;
        var data = jsonDecode(jsonData);

        if (data["success"]) {
          deleteSuccess = true;
          return deleteSuccess;
        } else {
          return Future.error('Error!');
        }
      } else {
        return Future.error('Error!');
      }
    } catch (e) {
      print(e);
      return Future.error('Error!');
    }
  }

  //update account
  Future<bool?> updateAccount(Account accountData) async {
    bool updateSuccess = false;
    try {
      print(accountData.accID);
      Response response = await patch(
        Uri.parse(endpoint + accountData.accID),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'name': accountData.name,
          'description': accountData.description,
        }),
      );
      if (response.statusCode == 200) {
        var jsonData = response.body;
        var data = jsonDecode(jsonData);

        if (data["success"]) {
          updateSuccess = true;
          return updateSuccess;
        } else {
          return Future.error('Error!');
        }
      } else {
        return Future.error('Error!');
      }
    } catch (e) {
      print(e);
      return Future.error('Error!');
    }
  }
  
}
