import 'package:flutter/material.dart';
import 'package:sqfliteproject/db.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
class EditNote extends StatefulWidget {
  final note;
  final title;
  final color;
  final id;

  const EditNote({Key? key, this.note, this.title, this.color, this.id})
      : super(key: key);

  @override
  State<EditNote> createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
  GlobalKey<FormState> formstate = new GlobalKey<FormState>();
  TextEditingController note = TextEditingController();
  TextEditingController title = TextEditingController();
  TextEditingController color = TextEditingController();
  Dbintial mydb = Dbintial();

  @override
  void initState() {
    note.text = widget.note??"";
    title.text = widget.title??"";
    color.text = widget.color??"";

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Edit Note"),
        ),
        body: Container(
          margin: EdgeInsets.all(10),
          child: ListView(
            children: [
              Form(
                  key: formstate,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: note,
                        decoration: InputDecoration(hintText: "note"),
                      ),
                      TextFormField(
                        controller: title,
                        decoration: InputDecoration(hintText: "title"),
                      ),
                      TextFormField(
                        controller: color,
                        decoration: InputDecoration(hintText: "color"),
                      ),
                      SizedBox(height: 30),
                      ElevatedButton(
                          onPressed: () async {
                            var res = await mydb!.updateData(
                                ''' UPDATE notes SET note="${note.text}",
                                     title="${title.text}",
                                     colornote="${color.text}"
                                     WHERE id=${widget.id}
                                     ''');

                            if (res > 0) {
                              Navigator.of(context).pushNamed("homepage");
                            }
                          else{AwesomeDialog(context:(context),title: "Error",dialogType:DialogType.error  );}
                          },
                          child: Text("Edit note"))
                    ],
                  ))
            ],
          ),
        ));
  }
}
