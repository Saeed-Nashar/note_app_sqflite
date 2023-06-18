import 'package:flutter/material.dart';
import 'package:note_sql_app/addnote.dart';

import 'HomePage.dart';

void main (){
  runApp(const Home());
}
class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeApp(),
      routes: {
        "addnote":(context)=> AddNote(),
      },
    );
  }
}


