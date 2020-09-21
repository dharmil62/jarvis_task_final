import 'package:jarvistaskfinal/src/models/users_model.dart';

import 'user_event.dart';

class SetUsers extends UserEvent {
  List<UsersModel> userList;

  SetUsers(List<UsersModel> users) {
    userList = users;
  }
}