import 'package:flutter/material.dart';
import 'package:note_sql_app/editnotes.dart';
import 'package:note_sql_app/sqldb.dart';
import 'package:sqflite/sqflite.dart';

class HomeApp extends StatefulWidget {
  const HomeApp({Key? key}) : super(key: key);

  @override
  State<HomeApp> createState() => _HomeAppState();
}

class _HomeAppState extends State<HomeApp> {
  SqlDb sqlDb = SqlDb();
  bool isloading = true;
  List notes = [];

  Future readData() async {
    Database? mydb = await sqlDb.db;
    List<Map> response = await sqlDb.read('notes');
    notes.addAll(response);
    isloading = false;
    if (this.mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    readData();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
      ),
      body: isloading == true
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              child: ListView(
                children: [
                  MaterialButton(
                    onPressed: () async {
                      await sqlDb.myDeleteDatabase();
                      print("delete database is done");
                    },
                    child: Text("delet database"),
                  ),
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: notes.length,
                    itemBuilder: (contect, i) {
                      return Card(
                          child: ListTile(
                           title: Text("${notes[i]['title']}"),
                            subtitle: Text("${notes[i]['note']}"),
                           trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children:[
                            IconButton(
                             onPressed: () async {
                              int response = await sqlDb.delete(
                                  'notes',
                                  'id= ${notes[i]['id']}'
                                  );
                               if (response > 0) {
                                notes.removeWhere((element) =>
                                element['id'] == notes[i]['id']);
                                setState(() {});
                               }
                             },
                              icon: Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                          ),
                              IconButton(
                                onPressed: ()  {
                                  Navigator.of(context).push(
                                      MaterialPageRoute(builder: (builder)=>EditNote(
                                    color:notes[i]['color'],
                                    title: notes[i]['title'],
                                    note: notes[i]['note'],
                                    id: notes[i]['id'],
                                  )));
                                  setState(() {});
                                },
                                icon: Icon(
                                  Icons.edit,
                                  color: Colors.blue,
                                ),
                              ),
                        ]),
                      ));
                    },
                  )
                ],
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed("addnote");
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
