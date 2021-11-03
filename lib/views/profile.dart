import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: AppBar(
          elevation: 1,
          title: Padding(
              padding: EdgeInsets.fromLTRB(15, 40, 15, 5),
              child: Center(
                child: Text(
                  'PROFILE DETAILS',
                  style: TextStyle(
                    color: Colors.purple[900],
                    fontWeight: FontWeight.w800,
                  ),
                ),
              )),
          centerTitle: true,
          backgroundColor: Colors.white,
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(15, 20, 15, 30),
            child: Center(
              child: IconButton(
                icon: Icon(Icons.face_rounded),
                color: Colors.purple[900],
                onPressed: () {},
                iconSize: 50,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.purple[900],
                  borderRadius: BorderRadius.all(
                    Radius.circular(25.0),
                  )),
              height: 260,
              child: Container(
                padding: EdgeInsets.fromLTRB(15, 30, 15, 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                      child: Text(
                        'Username',
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                      child: Text(
                        'John Doe',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                      child: Divider(
                        color: Colors.grey,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                      child: Text(
                        'Email',
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                      child: Text(
                        'johndoe@gmail.com',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(100, 30, 100, 100),
            child: TextButton(
              onPressed: () {
                Navigator.of(context).popAndPushNamed('/login');
              },
              child: Text(
                'LOGOUT',
                style: TextStyle(
                    color: Colors.white,
                    letterSpacing: 1.0,
                    fontSize: 16,
                    fontWeight: FontWeight.w700),
              ),
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0)),
                backgroundColor: Colors.purple[900],
                shadowColor: Colors.grey[900],
              ),
            ),
          )
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
}
