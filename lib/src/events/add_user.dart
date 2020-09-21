import 'package:jarvistaskfinal/src/models/users_model.dart';

import 'user_event.dart';

class AddUser extends UserEvent {
  UsersModel newUser;

  AddUser(UsersModel user) {
    newUser = user;
  }
}