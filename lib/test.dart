import 'package:flutter/material.dart';
import 'package:sqfliteproject/edit.dart';
import 'package:sqfliteproject/note.dart';

import 'db.dart';

class Test extends StatefulWidget {
  const Test({Key? key}) : super(key: key);

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  Dbintial myDB = new Dbintial();
  List<Map> notes = [];
  bool isLoading = true;

  Future readData() async {
    List<Map> response = await myDB!.readData('SELECT * FROM notes');
    isLoading = false;
    notes.addAll(response);
    if (this.mounted) {
      setState(() {});
    }

  }

  Future<int> delete(int id) async {
    int response = await myDB!.delete("notes","id=${id}");
    return response;
  }

  @override
  void initState() {
    readData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed("addnote");
            }),
        appBar: AppBar(
          title: Text("Sqflite"),
        ),
        body: isLoading == true
            ? Center(child: CircularProgressIndicator())
            : Container(
                child: ListView.builder(
                  itemCount: notes.length,
                  itemBuilder: (BuildContext context, int i) {
                    return Card(
                      child: ListTile(

                        title: Text("${notes[i]["title"]}"),
                        subtitle: Text("${notes[i]["note"]}"),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                                onPressed: () async {
                                  int res = await delete(notes[i]["id"]);
                                  setState(() {});
                                  print("deleeeeete");
                                  if (res > 0) {
                                    notes.removeWhere((element) =>
                                    element["id"] == notes[i]['id']);
                                    setState(() {});
                                  }
                                },
                                icon: Icon(Icons.delete),
                                color: Colors.red),
                            IconButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => EditNote(
                                      title: notes[i]["title"],
                                      color: notes[i]["colornote"],
                                      note: notes[i]["note"],
                                      id: notes[i]["id"],
                                    )));
                              },
                              icon: Icon(Icons.edit),
                              color: Colors.blue,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ));
  }
}
