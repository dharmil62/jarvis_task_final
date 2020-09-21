import 'package:flutter/material.dart';
import 'package:jarvistaskfinal/src/ui/home_page.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Scaffold(
        body: UsersList(),
      ),
    );
  }
}