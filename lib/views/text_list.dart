import 'package:flutter/material.dart';
import 'sub_views/empty_list.dart';

class TextList extends StatefulWidget {
  final List<dynamic> texts;

  const TextList({Key? key, required this.texts}) : super(key: key);

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
              Navigator.pop(context);
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
                              title: Text(widget.texts[index]),
                              leading: Icon(
                                Icons.add,
                                color: Colors.grey[500],
                                size: 30,
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
                                    size: 30,
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
                          Navigator.of(context).popAndPushNamed('/home');
                        },
                        icon: Icon(Icons.home_rounded),
                        iconSize: 30,
                        color: Colors.grey[500],
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TextList(
                                        texts: texts,
                                      )));
                        },
                        icon: Icon(Icons.list_rounded),
                        iconSize: 30,
                        color: Colors.grey[500],
                      ),
                    ],
                  ),
                ),
              )),
        ),
      ),
    );
  }
}
