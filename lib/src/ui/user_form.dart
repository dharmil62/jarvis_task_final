import 'package:jarvistaskfinal/src/bloc/users_bloc.dart';
import 'package:jarvistaskfinal/src/providers/db_provider.dart';
import 'package:jarvistaskfinal/src/events/add_user.dart';
import 'package:jarvistaskfinal/src/events/update_user.dart';
import 'package:jarvistaskfinal/src/models/users_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserForm extends StatefulWidget {
  final UsersModel user;
  final int userIndex;

  UserForm({this.user, this.userIndex});

  @override
  State<StatefulWidget> createState() {
    return UserFormState();
  }
}

class UserFormState extends State<UserForm> {
  int _id;
  String _email;
  String _first_name;
  String _last_name;
  String _avatar;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildId() {
    return TextFormField(
      initialValue: _id.toString(),
      decoration: InputDecoration(labelText: 'Enter Id'),
      maxLength: 15,
      style: TextStyle(fontSize: 28),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Id is Required';
        }

        return null;
      },
      onSaved: (String value) {
        _id = int.parse(value);
      },
    );
  }

  Widget _buildEmail() {
    return TextFormField(
      initialValue: _email.toString(),
      decoration: InputDecoration(labelText: 'Enter Email Id'),
      maxLength: 15,
      style: TextStyle(fontSize: 28),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Email Id is Required';
        }

        return null;
      },
      onSaved: (String value) {
        _email = value;
      },
    );
  }

  Widget _buildFirstName() {
    return TextFormField(
      initialValue: _first_name.toString(),
      decoration: InputDecoration(labelText: 'Enter First Name'),
      maxLength: 15,
      style: TextStyle(fontSize: 28),
      validator: (String value) {
        if (value.isEmpty) {
          return 'First Name is Required';
        }

        return null;
      },
      onSaved: (String value) {
        _first_name = value;
      },
    );
  }

  Widget _buildLastName() {
    return TextFormField(
      initialValue: _last_name.toString(),
      decoration: InputDecoration(labelText: 'Enter Last Name'),
      maxLength: 15,
      style: TextStyle(fontSize: 28),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Last Name is Required';
        }

        return null;
      },
      onSaved: (String value) {
        _last_name = value;
      },
    );
  }

  Widget _buildAvatar() {
    return TextFormField(
      initialValue: _avatar.toString(),
      decoration: InputDecoration(labelText: 'Enter Avatar link'),
      maxLength: 15,
      style: TextStyle(fontSize: 28),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Avatar link is Required';
        }

        return null;
      },
      onSaved: (String value) {
        _avatar = value;
      },
    );
  }

  @override
  void initState() {
    super.initState();
    if (widget.user != null) {
      _id = widget.user.id;
      _email = widget.user.email;
      _first_name = widget.user.first_name;
      _last_name = widget.user.last_name;
      _avatar = widget.user.avatar;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("User Form")),
      body: Container(
        margin: EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _buildId(),
              _buildEmail(),
              _buildFirstName(),
              _buildLastName(),
              _buildAvatar(),
              SizedBox(height: 16),
              widget.user == null
                  ? RaisedButton(
                child: Text(
                  'Submit',
                  style: TextStyle(color: Colors.blue, fontSize: 16),
                ),
                onPressed: () {
                  if (!_formKey.currentState.validate()) {
                    return;
                  }

                  _formKey.currentState.save();

                  UsersModel user = UsersModel(
                    id: _id,
                    email: _email,
                    first_name: _first_name,
                    last_name: _last_name,
                    avatar: _avatar,
                  );

                  DatabaseProvider.db.insert(user).then(
                        (storedUser) => BlocProvider.of<UsersBloc>(context).add(
                      AddUser(storedUser),
                    ),
                  );

                  Navigator.pop(context);
                },
              )
                  : Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  RaisedButton(
                    child: Text(
                      "Update",
                      style: TextStyle(color: Colors.blue, fontSize: 16),
                    ),
                    onPressed: () {
                      if (!_formKey.currentState.validate()) {
                        print("form");
                        return;
                      }

                      _formKey.currentState.save();

                      UsersModel user = UsersModel(
                        id: _id,
                        email: _email,
                        first_name: _first_name,
                        last_name: _last_name,
                        avatar: _avatar,
                      );

                      DatabaseProvider.db.update(widget.user).then(
                            (storedFood) => BlocProvider.of<UsersBloc>(context).add(
                          UpdateUser(widget.userIndex, user),
                        ),
                      );

                      Navigator.pop(context);
                    },
                  ),
                  RaisedButton(
                    child: Text(
                      "Cancel",
                      style: TextStyle(color: Colors.red, fontSize: 16),
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}