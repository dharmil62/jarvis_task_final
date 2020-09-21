import 'dart:async';
import 'package:dio/dio.dart';
import 'package:http/http.dart' show Client;
import 'dart:convert';
import 'package:jarvistaskfinal/src/models/users_model.dart';
import 'package:jarvistaskfinal/src/providers/db_provider.dart';

class UsersApiSaver {
  Future<UsersModel> saveUsersList() async {
    var url = "https://reqres.in/api/users?page=1";
    Response response = await Dio().get(url);

    return (response.data).map((user) {
      DatabaseProvider.db.insert(UsersModel.fromJson(user));
    });
  }
}
class UsersApiProvider {
  Client client = Client();
  final _baseUrl = "https://reqres.in/api/users?page=1";

  Future<UsersModel> fetchUsersList() async {
    final response = await client.get("$_baseUrl");
    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      return UsersModel.fromJson(json.decode(response.body));
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }
}