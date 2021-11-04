import 'package:flutter/material.dart';

class Error extends StatefulWidget {
  final String resText;

  Error({Key? key, required this.resText}) : super(key: key);

  @override
  _ErrorState createState() => _ErrorState();
}

class _ErrorState extends State<Error> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: BackButton(color: Colors.red),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.fromLTRB(15, 0, 15, 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Icon(
                  Icons.cancel_rounded,
                  color: Colors.red,
                  size: 200,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(25, 0, 25, 20),
                  child: Text(widget.resText,
                      style: TextStyle(
                          color: Colors.grey[900],
                          fontSize: 16,
                          letterSpacing: 1.0,
                          height: 1.5,
                          fontWeight: FontWeight.w700)),
                ),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(
                  'Go back',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
                style: TextButton.styleFrom(
                    minimumSize: Size(double.infinity, 50),
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0))),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
