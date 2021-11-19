import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Success extends StatefulWidget {
  final String resText;

  Success({Key? key, required this.resText}) : super(key: key);

  @override
  _SuccessState createState() => _SuccessState();
}

class _SuccessState extends State<Success> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: BackButton(color: Colors.purple[900]),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.fromLTRB(15, 0, 15, 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Icon(
                  Icons.check_box_rounded,
                  color: Colors.purple[900],
                  size: 200,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 20),
                  child: Text(widget.resText,
                      style: GoogleFonts.montserrat(
                          textStyle: TextStyle(
                              fontStyle: FontStyle.italic,
                              fontSize: 16,
                              letterSpacing: 0.5,
                              color: Colors.purple[900],
                              fontWeight: FontWeight.w500))),
                ),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(
                  'Done',
                  style: GoogleFonts.montserrat(
                      textStyle: TextStyle(
                          fontStyle: FontStyle.normal,
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.w500)),
                ),
                style: TextButton.styleFrom(
                    minimumSize: Size(double.infinity, 50),
                    backgroundColor: Colors.purple[900],
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
