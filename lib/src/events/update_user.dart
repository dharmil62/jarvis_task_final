import 'package:jarvistaskfinal/src/models/users_model.dart';

import 'user_event.dart';

class UpdateUser extends UserEvent {
  UsersModel newUser;
  int userIndex;

  UpdateUser(int index, UsersModel user) {
    newUser = user;
    userIndex = index;
  }
}