
import 'package:flutter/material.dart';

import 'sqldb.dart';
class sqlHome extends StatefulWidget {
  const sqlHome({Key? key}) : super(key: key);

  @override
  State<sqlHome> createState() => _sqlHomeState();
}

class _sqlHomeState extends State<sqlHome> {
  SqlDb sqldb=SqlDb();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Column(
          children: [
            Center(
              child: MaterialButton(
                color: Colors.red,
                child: Text("insert data"),
                onPressed: ()async{
                  /*int response= await sqldb.insertData('INSERT INTO "notes" ("note") VALUES ("note two")');*/
                  int response= await sqldb.insert("notes",
                    {"note":"note two",}

                  );
                  print(response);
                },
              ),
            ),
            Center(
              child: MaterialButton(
                color: Colors.red,
                child: Text("Read Data"),
                onPressed: ()async{
                  List<Map> respone=await sqldb.read('notes');
                  print('$respone');
                },
              ),
            ),
            Center(
              child: MaterialButton(
                color: Colors.red,
                child: Text("delet Data"),
                onPressed: ()async{
             //     int respone=await sqldb.delettData('Delete  FROM "notes" WHERE id =5');
              //    print(respone);
                },
              ),
            ),

            Center(
              child: MaterialButton(
                color: Colors.red,
                child: Text("delet Data",style: TextStyle(color: Colors.white),),
                onPressed: ()async{
              //    int respone=await sqldb.updateData('UPDATE "notes" set "note"="kokoo" WHERE id =9');
                //  print(respone);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
