import 'package:flutter/material.dart';
import 'package:sqfliteproject/db.dart';

class Note extends StatefulWidget {
  const Note({Key? key}) : super(key: key);

  @override
  State<Note> createState() => _NoteState();
}

class _NoteState extends State<Note> {
  GlobalKey<FormState> formstate=new GlobalKey<FormState>();
  TextEditingController note=TextEditingController();
  TextEditingController title=TextEditingController();
  TextEditingController color=TextEditingController();
  Dbintial mydb=Dbintial();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Note"),),
      body:Container(
        margin: EdgeInsets.all(10),
        child: ListView(
        children: [
          Form(
            key: formstate,
              child: Column(children: [
                TextFormField(

                  controller: note,
                decoration: InputDecoration(
                  hintText: "note"
                ),),
                TextFormField(controller: title,
                  validator:(val){

                  } ,
                  decoration: InputDecoration(
                      hintText: "title"
                  ),),
                TextFormField(controller: color,
                  decoration: InputDecoration(
                      hintText: "color"
                  ),),
               SizedBox(height: 30),
                ElevatedButton(
                    onPressed: ()async{

                  var res=  await mydb!.insertData('''INSERT INTO notes (note,title,colornote)
                    VALUES ("${note.text}","${title.text}","${color.text}")''');
                    print(res);
                    if(res>0){ Navigator.of(context).pushNamed("homepage");}


                }, child:Text("Add note"))
              ],))
        ],
      ),)
    );
  }
}
