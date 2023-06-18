import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqlDb {
  static Database? _db;

  Future<Database?> get db async {
    if (_db == null) {
      _db = await intailDb();
    } else {
      return _db;
    }
  }

  intailDb() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'saed.db');
    Database mydb = await openDatabase(path, onCreate: _onCreate,version: 18,onUpgrade: _onUpgrade);
    return mydb;
  }
  _onUpgrade(Database db,int oldVersion,int newVersion)async{
   //  await db.execute('ALTER TABLE "notes" ADD COLUMN "color" TEXT');
    print("upgrade--------------------------------");
  }
  _onCreate(Database db, int version) async {

   db.execute('''
     CREATE TABLE "notes" (
     "id" INTEGER  NOT NULL PRIMARY KEY AUTOINCREMENT, 
     "title" TEXT NOT NULL,
     "color" TEXT NOT NULL,  
     "note" TEXT NOT NULL
     )
    ''');

    print('Creat DATABASE====== ============');
  }

  /*readData(String sql) async {
    //select
    Database? mydb = await db;
    List<Map> response = await mydb!.rawQuery(sql);
    return response;
  }

//insert
  insertData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawInsert(sql);
    return response;
  }
  //delet
  delettData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawDelete(sql);
    return response;
  }
  //update
  updateData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawUpdate(sql);
    return response;
  }

 myDeleteDatabase() async{
   String databasePath = await getDatabasesPath();
   String path = join(databasePath, 'saed.db');
   await deleteDatabase(path);
}*/
  read(String  table) async {
    //select
    Database? mydb = await db;
    List<Map> response = await mydb!.query(table);
    return response;
  }

//insert
  insert(String table,Map<String,Object?> value) async {
    Database? mydb = await db;
    int response = await mydb!.insert(table,value);
    return response;
  }
  //delet
  delete(String table,String ?where) async {
    Database? mydb = await db;
    int response = await mydb!.delete(table,where: where);
    return response;
  }
  //update
  update(String table,Map<String,Object?> value,String? where) async {
    Database? mydb = await db;
    int response = await mydb!.update(table,value,where: where);
    return response;
  }

  myDeleteDatabase() async{
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'saed.db');
    await deleteDatabase(path);
  }
}
