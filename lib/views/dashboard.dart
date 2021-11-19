import 'package:eventor/views/home.dart';
import 'package:eventor/views/text_list.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Dashboard extends StatefulWidget {
  final List texts;
  const Dashboard({Key? key, required this.texts}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final pages = [Home(), TextList(texts: [])];
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: pages,
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
            currentIndex: 1,
            onTap: (value) {
              if (value == 0)
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => Home()));
              if (value == 1)
                Future(() {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TextList(
                                texts: [],
                              )));
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
    );
  }
}
