import 'dart:convert';
import 'package:eventor/views/sub_views/empty_list.dart';
import 'package:eventor/views/sub_views/success.dart';
import 'package:eventor/views/sub_views/errors.dart';
import 'package:eventor/views/text_list.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with RestorationMixin {
  final _formKey = GlobalKey<FormState>();
  double textSize = 20;
  String? scanTicket;
  List texts = [];
  RestorableTextEditingController _myTextController =
      RestorableTextEditingController();
  var code;
  bool _isLoading = true;
  final pages = [Home(), TextList(texts: [])];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(70),
          child: AppBar(
            elevation: 0,
            title: Container(
              padding: EdgeInsets.fromLTRB(15, 40, 15, 5),
              child: Text(
                'EVENTOR',
                style: GoogleFonts.montserrat(
                    textStyle: TextStyle(
                        color: Colors.purple[900],
                        fontSize: 25,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w700)),
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
                  controller: _myTextController.value,
                  onFieldSubmitted: (code) {
                    if (code.isEmpty) {
                      setState(() {});
                      return null;
                    } else {
                      setState(() {});
                      return null;
                    }
                  },
                  validator: (val) {
                    if (val!.isEmpty) {
                      return '';
                    } else {
                      code = val;
                      return null;
                    }
                  },
                  style: GoogleFonts.montserrat(
                      textStyle: TextStyle(
                          fontStyle: FontStyle.normal,
                          fontSize: 14,
                          color: Colors.grey[900],
                          fontWeight: FontWeight.w500)),
                  decoration: InputDecoration(
                    fillColor: Colors.grey[50],
                    filled: true,
                    labelText: 'Enter text',
                    labelStyle: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                            fontStyle: FontStyle.italic,
                            fontSize: 14,
                            color: Colors.grey[500],
                            fontWeight: FontWeight.w500)),
                    contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                            style: BorderStyle.solid, color: Colors.yellow)),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        style: BorderStyle.solid,
                        color: Colors.purple,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          style: BorderStyle.solid, color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          style: BorderStyle.solid, color: Colors.purple),
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
                                    onPressed: () async {
                                      if (_formKey.currentState!.validate()) {
                                        await _addText(code);
                                        texts.add(code);
                                      } else {
                                        await addBarcode();
                                        if (code == '') {
                                          setState(() {
                                            _isLoading = !_isLoading;
                                          });
                                          return null;
                                        } else {
                                          texts.add(code);
                                        }
                                      }
                                    },
                                    icon: Icon(Icons.add_box_rounded),
                                    iconSize: 60,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    'ADD TEXT',
                                    style: GoogleFonts.montserrat(
                                        textStyle: TextStyle(
                                            fontStyle: FontStyle.normal,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500)),
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
                                    onPressed: () async {
                                      if (_formKey.currentState!.validate()) {
                                        await _validateText(code);
                                        texts.add(code);
                                      } else {
                                        await scanBarcode();
                                        if (code.isEmpty) {
                                          setState(() {
                                            _isLoading = !_isLoading;
                                          });
                                          return null;
                                        } else {
                                          texts.add(code);
                                        }
                                      }
                                    },
                                    icon: Icon(Icons.camera_rounded),
                                    iconSize: 60,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    'SCAN TEXT',
                                    style: GoogleFonts.montserrat(
                                        textStyle: TextStyle(
                                            fontStyle: FontStyle.normal,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500)),
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
            Center(
                child: _isLoading
                    ? null
                    : CircularProgressIndicator(
                        color: Colors.purple[900],
                        backgroundColor: Colors.purple[500],
                      )),
            Padding(
              padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
              child: Text(
                'MY LIST',
                style: GoogleFonts.montserrat(
                    textStyle: TextStyle(
                        color: Colors.purple[900],
                        fontSize: 22,
                        fontWeight: FontWeight.w600)),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
              child: texts.isEmpty
                  ? EmptyList()
                  : ListView.builder(
                      physics: ScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: texts.length,
                      itemBuilder: (context, index) {
                        return Container(
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0)),
                            color: Colors.grey[50],
                            elevation: 0,
                            child: ListTile(
                              title: Text(
                                texts[index],
                                style: GoogleFonts.montserrat(
                                    textStyle: TextStyle(
                                        fontStyle: FontStyle.normal,
                                        fontSize: 14,
                                        color: Colors.grey[800],
                                        fontWeight: FontWeight.w500)),
                              ),
                              leading: Icon(
                                Icons.list_rounded,
                                color: Colors.purple[900],
                                size: 25,
                              ),
                              trailing: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      texts.removeAt(index);
                                    });
                                  },
                                  color: Colors.red,
                                  icon: Icon(
                                    Icons.delete_rounded,
                                    size: 25,
                                  )),
                            ),
                          ),
                        );
                      }),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(100, 10, 100, 100),
              child: Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => TextList(texts: texts)));
                    setState(() {
                      this.texts = texts;
                    });
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.search,
                        color: Colors.white,
                        size: 18,
                      ),
                      Text(
                        'VIEW MORE...',
                        style: GoogleFonts.montserrat(
                            textStyle: TextStyle(
                                fontStyle: FontStyle.normal,
                                color: Colors.white,
                                fontWeight: FontWeight.w500)),
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
          child: Padding(
            padding: EdgeInsets.fromLTRB(2, 0, 2, 8),
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              selectedItemColor: Colors.purple[900],
              unselectedItemColor: Colors.grey[500],
              selectedFontSize: 12,
              unselectedFontSize: 10,
              showUnselectedLabels: false,
              selectedLabelStyle: GoogleFonts.montserrat(
                  textStyle: TextStyle(
                      fontStyle: FontStyle.normal,
                      color: Colors.purple[900],
                      fontWeight: FontWeight.w500)),
              iconSize: 25,
              currentIndex: 0,
              onTap: (value) {
                if (value == 0) return null;
                if (value == 1)
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => TextList(texts: texts)));
                setState(() {
                  this.texts = texts;
                });
              },
              backgroundColor: Colors.white,
              elevation: 0,
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home_rounded),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.list_rounded),
                  label: 'List',
                ),
              ],
            ),
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
    _validateText(code);

    if (code == '-1') {
      setState(() {
        this.code = '';
      });
    } else {
      setState(() {});
    }
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
    _addText(code);

    if (code == '-1') {
      setState(() {
        this.code = '';
      });
    } else {
      setState(() {});
    }
  }

  _addText(code) async {
    setState(() {
      _isLoading = !_isLoading;
    });
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
            builder: (context) => Success(resText: response.body)),
      );
    } else if (response.body == 'Error! -1 already exists.') {
      return null;
    } else {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Error(resText: response.body)));
    }
    setState(() {
      _isLoading = !_isLoading;
    });
  }

  _validateText(code) async {
    setState(() {
      _isLoading = !_isLoading;
    });
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
    setState(() {
      _isLoading = !_isLoading;
    });
  }

  @override
  String? get restorationId => 'home';

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_myTextController, 'text');
  }
}
