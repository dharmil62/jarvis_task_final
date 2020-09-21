import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jarvistaskfinal/src/bloc/users_bloc.dart';
import 'package:jarvistaskfinal/src/events/delete_user.dart';
import 'package:jarvistaskfinal/src/events/set_user.dart';
import 'package:jarvistaskfinal/src/models/users_model.dart';
import 'package:jarvistaskfinal/src/ui/user_form.dart';
import 'package:sqflite/sqflite.dart';
import '../bloc/users_bloc.dart';
import 'package:jarvistaskfinal/src/providers/db_provider.dart';

class UsersList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),home: new MyUsersList(title: "USERS"),
    );
  }
}

class MyUsersList extends StatefulWidget {
  MyUsersList({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyUsersListState createState() => new _MyUsersListState();
}

class _MyUsersListState extends State<MyUsersList> {

  void initState(){
    super.initState();
    DatabaseProvider.db.getUsers().then(
        (userList){
          BlocProvider.of<UsersBloc>(context).add(SetUsers(userList));
        },
    );
  }

  showUserDialog(BuildContext context, UsersModel user, int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(user.first_name),
        content: Text("ID ${user.id}"),
        actions: <Widget>[
          FlatButton(
            onPressed: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => UserForm(user: user, userIndex: index),
              ),
            ),
            child: Text("Update"),
          ),
          FlatButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    bloc.fetchAllUsers();
    return new Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        title: Text('USERS'),
      ),



      floatingActionButton: new FloatingActionButton(
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => UserForm()),),
        backgroundColor: Colors.blue,
        //if you set mini to true then it will make your floating button small
        mini: false,
        child: new Icon(Icons.add),
      ),

      body: Container(
         child: StreamBuilder(
            stream: bloc.allUsers,
            builder: (context, AsyncSnapshot<UsersModel> snapshot) {
              if (snapshot.hasData) {
                return buildList(snapshot);
              }
              else if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              }
              return Center(child: CircularProgressIndicator());
            },
          ),

      ),

    );
  }

  Widget buildList(AsyncSnapshot<UsersModel> snapshot) {
    return ListView.builder(
        itemCount: snapshot.data.data.length,
        itemBuilder: (BuildContext context, int index) {
          final item  = snapshot.data.data[index];
          return Dismissible(
            key: UniqueKey(),

            background: Container(color: Colors.red,),

            child: new Container(
                height: 85,
                child: Row(children: <Widget>[
                  Image.network(snapshot.data.data[index].avatar),
                  Expanded(
                    child: Column (
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(snapshot.data.data[index].first_name+' '+snapshot.data.data[index].last_name,
                            textAlign: TextAlign.center),
                        Text(snapshot.data.data[index].email),
                      ],),),
                ],)
            ),
            onDismissed: (direction) async {
              DatabaseProvider.db.delete(item.id).then((_) {
                BlocProvider.of<UsersBloc>(context).add(
                  DeleteUser(index),
                );
                Navigator.pop(context);
              });
            },
          );
        });
  }
}