import 'dart:convert';

import 'package:eventor/model/detail.dart';
import 'package:eventor/views/success.dart';
import 'package:eventor/views/errors.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class Demo extends StatefulWidget {
  const Demo({Key? key}) : super(key: key);

  @override
  _DemoState createState() => _DemoState();
}

class _DemoState extends State<Demo> {
  final _formKey = GlobalKey<FormState>();
  double textSize = 20;
  String? scanTicket;

  var code;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: AppBar(
          elevation: 0,
          title: Container(
            padding: EdgeInsets.fromLTRB(15, 40, 15, 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Hi John',
                  style: TextStyle(
                      color: Colors.purple[900],
                      fontSize: 18,
                      height: 1.5,
                      fontWeight: FontWeight.w700),
                ),
                IconButton(
                  icon: Icon(Icons.face_rounded),
                  color: Colors.purple[900],
                  onPressed: () {
                    Navigator.of(context).popAndPushNamed('/profile');
                  },
                ),
              ],
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(15, 30, 15, 10),
            child: Form(
              key: _formKey,
              child: TextFormField(
                validator: (val) {
                  if (val!.isEmpty) {
                    return '';
                  } else {
                    code = val;
                    return null;
                  }
                },
                decoration: InputDecoration(
                  fillColor: Colors.grey[50],
                  filled: true,
                  hintText: 'Enter code',
                  contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          style: BorderStyle.none, color: Colors.white)),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        style: BorderStyle.none, color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
            child: Container(
              padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
              decoration: BoxDecoration(
                  color: Colors.purple[900],
                  borderRadius: BorderRadius.all(
                    Radius.circular(20.0),
                  )),
              height: 180,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Flexible(
                      child: Card(
                        color: Colors.purple[900],
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50.0)),
                        child: Container(
                            width: 150,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      addTicket(code);
                                    } else {
                                      addBarcode();
                                    }
                                  },
                                  icon: Icon(Icons.add_box_rounded),
                                  iconSize: 60,
                                  color: Colors.white,
                                ),
                                Text(
                                  'ADD TEXT',
                                  style: TextStyle(
                                      color: Colors.white,
                                      letterSpacing: 1.0,
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                            )),
                      ),
                    ),
                  ),
                  Container(
                    child: Flexible(
                      child: Card(
                        color: Colors.purple[900],
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50.0)),
                        child: Container(
                            width: 150,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      validateTicket(code);
                                    } else {
                                      scanBarcode();
                                    }
                                  },
                                  icon: Icon(Icons.camera_rounded),
                                  iconSize: 60,
                                  color: Colors.white,
                                ),
                                Text(
                                  'SCAN TEXT',
                                  style: TextStyle(
                                      color: Colors.white,
                                      letterSpacing: 1.0,
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                            )),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
            child: Text(
              'MY LIST',
              style: TextStyle(
                  color: Colors.purple[900],
                  fontSize: 25,
                  fontWeight: FontWeight.w700),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
            child: ListView.builder(
                physics: ScrollPhysics(),
                shrinkWrap: true,
                itemCount: 8,
                itemBuilder: (context, index) {
                  Detail detail = detailList[index];
                  return Container(
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0)),
                      color: Colors.grey[50],
                      elevation: 0,
                      child: ListTile(
                        title: Text(detail.text),
                        leading: Icon(
                          Icons.add,
                          color: Colors.grey[500],
                          size: 30,
                        ),
                        trailing: Icon(
                          Icons.check_box_rounded,
                          color: Colors.grey[500],
                          size: 30,
                        ),
                      ),
                    ),
                  );
                }),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(100, 10, 100, 100),
            child: Center(
              child: TextButton(
                onPressed: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                    Text(
                      'VIEW MORE...',
                      style: TextStyle(
                          color: Colors.white,
                          letterSpacing: 1.0,
                          fontSize: 14,
                          fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0)),
                  backgroundColor: Colors.purple[900],
                  shadowColor: Colors.grey[900],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: BottomAppBar(
            elevation: 0,
            child: Container(
              height: 60,
              child: Padding(
                padding: EdgeInsets.fromLTRB(2, 0, 2, 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).popAndPushNamed('/dashboard');
                      },
                      icon: Icon(Icons.home_rounded),
                      iconSize: 30,
                      color: Colors.purple[900],
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.list_rounded),
                      iconSize: 30,
                      color: Colors.purple[900],
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).popAndPushNamed('/profile');
                      },
                      icon: Icon(Icons.face_rounded),
                      iconSize: 30,
                      color: Colors.purple[900],
                    ),
                  ],
                ),
              ),
            )),
      ),
    );
  }

  Future scanBarcode() async {
    String scanTicket;

    try {
      scanTicket = await FlutterBarcodeScanner.scanBarcode(
          '#000000', 'Cancel', true, ScanMode.QR);
    } on PlatformException {
      scanTicket = 'Something went wrong.';
    }
    if (!mounted) return;

    setState(() => this.scanTicket = scanTicket);
    setState(() {
      this.code = scanTicket;
    });
    validateTicket(code);
    setState(() {
      this.code = null;
    });
  }

  Future addBarcode() async {
    String scanTicket;

    try {
      scanTicket = await FlutterBarcodeScanner.scanBarcode(
          '#000000', 'Cancel', true, ScanMode.QR);
    } on PlatformException {
      scanTicket = 'Something went wrong.';
    }
    if (!mounted) return;

    setState(() => this.scanTicket = scanTicket);
    setState(() {
      this.code = scanTicket;
    });
    addTicket(code);
    setState(() {
      this.code = null;
    });
  }

  addTicket(code) async {
    //var url = 'http://10.0.2.2:8000/add';
    var url = 'http://172.20.10.8:3000/add';
    final response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'code': code,
      }),
    );

    if (response.statusCode == 201) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Success(resText: response.body)));
    } else {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Error(resText: response.body)));
    }
  }

  validateTicket(code) async {
    var url = 'http://172.20.10.8:3000/validate';
    final response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'code': code,
      }),
    );

    if (response.statusCode == 201) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Success(resText: response.body)));
    } else if (response.body == 'Sorry, -1 has been used.') {
      return null;
    } else {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Error(resText: response.body)));
    }
  }
}
