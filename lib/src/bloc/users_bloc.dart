import 'package:jarvistaskfinal/src/providers/repository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:jarvistaskfinal/src/models/users_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jarvistaskfinal/src/events/add_user.dart';
import 'package:jarvistaskfinal/src/events/update_user.dart';
import 'package:jarvistaskfinal/src/events/delete_user.dart';
import 'package:jarvistaskfinal/src/events/set_user.dart';
import 'package:jarvistaskfinal/src/events/user_event.dart';

class UsersBloc extends Bloc<UserEvent, List<UsersModel>> {
  final _repository = Repository();
  final _usersFetcher = PublishSubject<UsersModel>();

  UsersBloc(List<UsersModel> initialState) : super(initialState);

  List<UsersModel> get initialState => List<UsersModel>();

  Observable<UsersModel> get allUsers => _usersFetcher.stream;

  fetchAllUsers() async {
    UsersModel usersModel = await _repository.fetchAllUsers();
    _usersFetcher.sink.add(usersModel);
  }

  dispose() {
    _usersFetcher.close();
  }

  @override
  Stream<List<UsersModel>> mapEventToState(UserEvent event) async* {
    if (event is SetUsers) {
      yield event.userList;
    } else if (event is AddUser) {
      List<UsersModel> newState = List.from(state);
      if (event.newUser != null) {
        newState.add(event.newUser);
      }
      yield newState;
    } else if (event is DeleteUser) {
      List<UsersModel> newState = List.from(state);
      newState.removeAt(event.userIndex);
      yield newState;
    } else if (event is UpdateUser) {
      List<UsersModel> newState = List.from(state);
      newState[event.userIndex] = event.newUser;
      yield newState;
    }
  }
}
final bloc = UsersBloc(List<UsersModel>());