import 'package:flutter/material.dart';
import 'sub_views/empty_list.dart';
import 'package:google_fonts/google_fonts.dart';

class TextList extends StatefulWidget {
  final List texts;

  const TextList({Key? key, required this.texts}) : super(key: key);

  @override
  _TextListState createState() => _TextListState();
}

class _TextListState extends State<TextList> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'My List',
            style: GoogleFonts.montserrat(
                textStyle: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.w600)),
          ),
          centerTitle: true,
          elevation: 0,
          leading: BackButton(
            color: Colors.white,
            onPressed: () {
              Navigator.pop(context, widget.texts);
            },
          ),
          backgroundColor: Colors.purple[900],
        ),
        body: ListView(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
              child: widget.texts.isEmpty
                  ? EmptyList()
                  : ListView.builder(
                      physics: ScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: widget.texts.length,
                      itemBuilder: (context, index) {
                        return Container(
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0)),
                            color: Colors.grey[50],
                            elevation: 0,
                            child: ListTile(
                              title: Text(
                                widget.texts[index],
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
                                      widget.texts.removeAt(index);
                                    });
                                  },
                                  color: Colors.red,
                                  icon: Icon(
                                    Icons.delete,
                                    size: 25,
                                  )),
                            ),
                          ),
                        );
                      }),
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
              currentIndex: 1,
              onTap: (value) {
                if (value == 0) 
                setState(() {
                  Navigator.pop(context, widget.texts);
                });
                if (value == 1) return null;
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
}
