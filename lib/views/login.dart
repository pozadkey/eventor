import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(70),
          child: AppBar(
              backgroundColor: Colors.white, elevation: 0, title: Row())),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(15, 20, 15, 20),
            child: Icon(
              Icons.ac_unit,
              color: Colors.purple[900],
              size: 100,
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(15, 20, 15, 10),
            child: Form(
              child: TextFormField(
                decoration: InputDecoration(
                  fillColor: Colors.grey[50],
                  filled: true,
                  hintText: 'Username',
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
            padding: EdgeInsets.fromLTRB(15, 20, 15, 10),
            child: Form(
              child: TextFormField(
                decoration: InputDecoration(
                  fillColor: Colors.grey[50],
                  filled: true,
                  suffixIcon: Icon(Icons.remove_red_eye_rounded,
                      size: 15, color: Colors.purple[900]),
                  hintText: 'Password',
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
            padding: EdgeInsets.fromLTRB(15, 20, 15, 40),
            child: TextButton(
              child: Text(
                'LOGIN',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 16),
              ),
              onPressed: () {
                Navigator.of(context).popAndPushNamed('/dashboard');
              },
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0)),
                backgroundColor: Colors.purple[900],
                shadowColor: Colors.grey[900],
                minimumSize: Size(double.infinity, 50),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(15, 20, 15, 20),
            child: Column(
              children: [
                RichText(
                  text: TextSpan(children: [
                    TextSpan(
                      text: 'Don\'t have an account?',
                      style: TextStyle(
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w500,
                          fontSize: 16),
                    ),
                    TextSpan(
                        text: ' REGISTER',
                        style: TextStyle(
                            color: Colors.purple[900],
                            fontWeight: FontWeight.w500,
                            fontSize: 16),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => Navigator.of(context)
                              .popAndPushNamed('/register')),
                  ]),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
