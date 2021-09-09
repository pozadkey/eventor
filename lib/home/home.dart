import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  double textSize = 20;
  String? scanTicket;

  var code;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Eventor',
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
                child: Column(
                  children: [
                    TextFormField(
                      style: TextStyle(color: Colors.white),
                      onChanged: (value) {
                        code = value;
                      },
                      decoration: InputDecoration(
                        fillColor: Colors.grey[850],
                        filled: true,
                        hintText: 'ENTER CODE',
                        hintStyle:
                            TextStyle(color: Colors.white, letterSpacing: 1.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            borderSide:
                                BorderSide(color: Colors.grey, width: 2.0)),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.orange, width: 2.0),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                    ),
                  ],
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
                                    print(code);
                                    addTicket(code);
                                  },
                                  color: Colors.orange,
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
                                    code == null
                                        ? scanBarcode()
                                        : validateTicket(code);
                                  },
                                  color: Colors.orange,
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
              Text(
                scanTicket == null ? '' : 'CODE: $scanTicket',
                style: TextStyle(color: Colors.white),
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
  }
}

addTicket(code) async {
  //var url = 'http://10.0.2.2:8000/add';
  var url = 'http://172.20.10.8/add';
  final response = await http.post(
    Uri.parse(url),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'code': code,
    }),
  );
  print(response.body);
  //if (response.statusCode == 201) {
  //} else {
  //throw Exception('Failed to add ticket code');
  //}
}

validateTicket(code) async {
  var url = 'http://172.20.10.8/validate';
  final response = await http.post(
    Uri.parse(url),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'code': code,
    }),
  );
  print(response.body);
  //if (response.statusCode == 201) {
  //} else {
  //throw Exception('Failed to add ticket code');
  //}
}
