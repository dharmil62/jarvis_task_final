import 'user_event.dart';

class DeleteUser extends UserEvent {
  int userIndex;

  DeleteUser(int index) {
    userIndex = index;
  }
}