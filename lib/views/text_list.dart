import 'package:flutter/material.dart';

import 'empty_list.dart';

class TextList extends StatefulWidget {
  const TextList({Key? key}) : super(key: key);

  @override
  _TextListState createState() => _TextListState();
}

class _TextListState extends State<TextList> {
  List texts = [];
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('My List'),
          centerTitle: true,
          elevation: 0,
          leading: BackButton(
            color: Colors.purple[900],
            onPressed: () {
              Navigator.of(context).popAndPushNamed('/dashboard');
            },
          ),
          backgroundColor: Colors.white,
          bottom: TabBar(
            labelColor: Colors.grey,
            tabs: [
              Tab(
                text: 'Added Text',
                icon: Icon(
                  Icons.add_box_rounded,
                  color: Colors.purple[900],
                  size: 30,
                ),
              ),
              Tab(
                text: 'Scanned Text',
                icon: Icon(
                  Icons.camera_rounded,
                  color: Colors.purple[900],
                  size: 30,
                ),
              )
            ],
          ),
        ),
        body: ListView(
          children: [
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
                              title: Text(texts[index]),
                              leading: Icon(
                                Icons.add,
                                color: Colors.grey[500],
                                size: 30,
                              ),
                              trailing: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      texts.removeAt(index);
                                    });
                                  },
                                  color: Colors.red,
                                  icon: Icon(
                                    Icons.delete,
                                    size: 30,
                                  )),
                            ),
                          ),
                        );
                      }),
            ),
          ],
        ),
      ),
    );
  }
}
