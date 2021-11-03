import 'package:eventor/views/home.dart';
import 'package:eventor/views/login.dart';
import 'package:eventor/views/profile.dart';
import 'package:eventor/views/register.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: new ThemeData(scaffoldBackgroundColor: Colors.white),
        home: Home(),
        routes: <String, WidgetBuilder>{
          '/login': (BuildContext context) => new Login(),
          '/register': (BuildContext context) => new Register(),
          '/logout': (BuildContext context) => new Register(),
          '/dashboard': (BuildContext context) => new Home(),
          '/profile': (BuildContext context) => new Profile(),
        });
  }
}
