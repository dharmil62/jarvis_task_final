
import 'dart:async';
import 'package:jarvistaskfinal/src/providers/users_api_provider.dart';
import 'package:jarvistaskfinal/src/models/users_model.dart';

class Repository {
  final usersApiProvider = UsersApiProvider();
  final usersApiSaver = UsersApiSaver();

  Future<UsersModel> fetchAllUsers() => usersApiProvider.fetchUsersList();
  Future<UsersModel> saveAllUsers() => usersApiSaver.saveUsersList();


}