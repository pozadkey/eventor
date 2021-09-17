import 'package:flutter/material.dart';

class Loader extends StatefulWidget {
  const Loader({ Key? key }) : super(key: key);

  @override
  _LoaderState createState() => _LoaderState();
}

class _LoaderState extends State<Loader> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            backgroundColor: Colors.green,
          )
        ],
      ) ,
    );
  }
}