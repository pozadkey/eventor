import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:eventor/views/success.dart';
import 'package:eventor/views/errors.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _formKey = GlobalKey<FormState>();
  double textSize = 20;
  String? scanTicket;

  var code;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('EVENTOR',
            style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                letterSpacing: 2.0,
                height: 1.5,
                fontWeight: FontWeight.w700)),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        validator: (val) {
                          if (val!.isEmpty) {
                            return '';
                          } else {
                            code = val;
                            return null;
                          }
                        },
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          fillColor: Colors.grey[850],
                          filled: true,
                          hintText: 'ENTER CODE',
                          hintStyle: TextStyle(
                              color: Colors.white, letterSpacing: 1.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 2.0)),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.lightBlue, width: 2.0),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 2.0)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Card(
                        color: Colors.grey[850],
                        shadowColor: Colors.grey,
                        child: Container(
                            padding: EdgeInsets.all(10),
                            width: 150,
                            height: 150,
                            child: Column(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      addTicket(code);
                                    }
                                  },
                                  color: Colors.lightBlue,
                                  icon: Icon(Icons.add_circle),
                                  iconSize: 80,
                                ),
                                SizedBox(
                                  height: 3,
                                ),
                                Text(
                                  'ADD TICKET',
                                  style: TextStyle(
                                      color: Colors.white,
                                      letterSpacing: 1.0,
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                            ))),
                    SizedBox(
                      width: 15,
                    ),
                    Card(
                        color: Colors.grey[850],
                        shadowColor: Colors.grey,
                        child: Container(
                            padding: EdgeInsets.all(10),
                            width: 150,
                            height: 150,
                            child: Column(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      validateTicket(code);
                                    } else {
                                      scanBarcode();
                                    }
                                  },
                                  color: Colors.lightBlue,
                                  icon: Icon(Icons.camera_rounded),
                                  iconSize: 80,
                                ),
                                SizedBox(
                                  height: 3,
                                ),
                                Text(
                                  'SCAN TICKET',
                                  style: TextStyle(
                                      color: Colors.white,
                                      letterSpacing: 1.0,
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                            ))),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
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

  addTicket(code) async {
    //var url = 'http://10.0.2.2:8000/add';
    var url = 'https://eventor-back.herokuapp.com/add';
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
    var url = 'https://eventor-back.herokuapp.com/validate';
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
