import 'package:flutter/material.dart';
import 'package:note_sql_app/sqldb.dart';


import 'HomePage.dart';

class AddNote extends StatefulWidget {
  const AddNote({Key? key}) : super(key: key);

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  GlobalKey<FormState> formstate = GlobalKey();
  TextEditingController note = TextEditingController();
  TextEditingController color = TextEditingController();
  TextEditingController title = TextEditingController();
  SqlDb sqlDb = SqlDb();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Note"),
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
                    controller: note,
                    decoration: InputDecoration(
                      hintText: "Note",
                    ),
                  ),
                  TextFormField(
                    controller: title,
                    decoration: InputDecoration(
                      hintText: "Title",
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
                      /*  int respone = await sqlDb.insertData('''
                      INSERT INTO notes ('note' ,'title', 'color' )
                      VALUES ('${note.text}' ,'${title.text}','${color.text}' )
                      ''');*/
                      int respone = await sqlDb.insert('notes',{
                        "note":"${note.text}",
                        "title":"${title.text}",
                        "color":"${color.text}"

                      });
                      if (respone > 0) {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => HomeApp()),
                                (route) => false);
                      }
                      print(respone);
                      },
                    textColor: Colors.white,
                    child: Text(" Add note"),
                  ),
                  MaterialButton(
                      color: Colors.blue,
                      onPressed: () async {
                        List<Map> response =
                            await sqlDb.read('notes');
                        print(response);
                      }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
