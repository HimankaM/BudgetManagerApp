import 'dart:convert';
import 'package:budget_recorder/models/Category.dart';
import 'package:budget_recorder/services/ServiceConst.dart';
import 'package:http/http.dart';

class CategoryService {
  static const String endpoint = "$Backend_server_URI/api/categories/";

  const CategoryService();

  //Get all categories
  Future<List?> getAllCategories() async {
    try {
      List<Category> categoryList = [];
      Response response = await get(Uri.parse(endpoint));
      if (response.statusCode == 200) {
        var jsonData = response.body;
        var data = jsonDecode(jsonData);

        if (data["success"]) {
          var dataArr = data["categories"];
          dataArr.forEach((item) {
            categoryList.add(Category.fromMap(item));
          });
          print(categoryList);
          return categoryList;
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

  //Create new category
  Future<bool?> createCategory(Category categoryData) async {
    bool createdSuccess = false;
    try {
      print(categoryData.name);
      Response response = await post(
        Uri.parse(endpoint),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'name': categoryData.name,
          'type': categoryData.type,
          'description': categoryData.description,
        }),
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

  //delete category
  Future<bool?> deleteCategory(String id) async {
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

  //update category
  Future<bool?> updateCategory(Category categoryData) async {
    bool updateSuccess = false;
    try {
      print(categoryData.cID);
      Response response = await patch(
        Uri.parse(endpoint + categoryData.cID),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'name': categoryData.name,
          'description': categoryData.description,
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
