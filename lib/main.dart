import 'package:eventor/views/home.dart';
import 'package:eventor/views/text_list.dart';
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
        debugShowCheckedModeBanner: false,
        theme: new ThemeData(scaffoldBackgroundColor: Colors.white),
        title: 'Eventor',
        restorationScopeId: 'root',
        home: Home(),
        routes: <String, WidgetBuilder>{
          'home': (BuildContext context) => new Home(),
          'textlist': (BuildContext context) => new TextList(
                texts: [],
              ),
        });
  }
}
