import 'package:flutter/material.dart';
import 'package:note_sql_app/sqldb.dart';

import 'HomePage.dart';

class EditNote extends StatefulWidget {
  final id;
  final note;
  final color;
  final title;
  const EditNote({Key? key, this.id, this.note, this.color, this.title}) : super(key: key);

  @override
  State<EditNote> createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
  GlobalKey<FormState> formstate = GlobalKey();
  TextEditingController note = TextEditingController();
  TextEditingController color = TextEditingController();
  TextEditingController title = TextEditingController();
  SqlDb sqlDb = SqlDb();
  @override
  void initState() {
    note.text=widget.note;
    color.text=widget.color;
    title.text=widget.title;
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit "),
      ),
      body: Container(
        padding: EdgeInsets.all(15),
        child: ListView(
          children: [
            Form(
              key: formstate,
              child: Column(
                children: [
                  TextFormField(
                    controller: title,
                    decoration: InputDecoration(
                      hintText: "Title",
                    ),
                  ),
                  TextFormField(
                    controller: note,
                    decoration: InputDecoration(
                      hintText: "Note",
                    ),
                  ),
                  TextFormField(
                    controller: color,
                    decoration: InputDecoration(
                      hintText: "Color",
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  MaterialButton(
                    color: Colors.blue,
                    onPressed: () async {
                     /*await sqlDb.db;
                      int respone = await sqlDb.updateData('''
                      UPDATE notes SET
                      note=  "${note.text}",
                      title= "${title.text}",
                      color= "${color.text}",
                      WHERE id= ${widget.id}
                      '''
                      );*/
                     await sqlDb.db;
                     int respone = await sqlDb.update(
                       "notes" ,
                      {
                        "note":"${note.text}",
                          "title":"${title.text}",
                        "color":"${color.text}"
                      },
                      "id= ${widget.id}"
                     );

                      if (respone > 0) {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => HomeApp()),
                                (route) => false);
                       }
                      print(respone);
                    },
                    textColor: Colors.white,
                    child: Text("Edit note"),
                  ),
                 /* MaterialButton(
                      color: Colors.blue,
                      onPressed: () async {
                        List<Map> response =
                        await sqlDb.readData('SELECT * FROM notes');
                        print(response);
                      }),*/
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
