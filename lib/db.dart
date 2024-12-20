import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Dbintial {
  static Database? _db;

  Future<Database?> get db async {
    if (_db == null) {
    _db=  await intialDB();
      return _db;
    } else {
      return _db;
    }
  }

  intialDB() async {
    String databasepath = await getDatabasesPath();
    String path = join(databasepath, "Diana.db");
    Database mydb = await openDatabase(path, onCreate: _onCreate,version: 6,onUpgrade: _onupgrade);
    return mydb;
  }
  _onupgrade(Database database,int oldvirsion,int newvirsion)async{
     await database.execute("ALTER TABLE notes ADD 'colornote' TEXT");
  }
  _onCreate(Database database, int virsion) async {
    await database.execute('''
   CREATE TABLE notes(
   id INTEGER PRIMARY KEY AUTOINCREMENT,
   note TEXT NOT NULL
   )
   ''');
  }
readData(String sql)async{

    Database? mydb=await db;
    List<Map> response=await mydb!.rawQuery(sql);
    return response;
}
  insertData(String sql)async{

    Database? mydb=await db;
    int response=await mydb!.rawInsert(sql);
    return response;
  }
  updateData(String sql)async{

    Database? mydb=await db;
    int response=await mydb!.rawUpdate(sql);
    return response;
  }
  deleteData(String sql)async{

    Database? mydb=await db;
    int response=await mydb!.rawDelete(sql);
    return response;
  }
  read(String table)async{

    Database? mydb=await db;
    List<Map> response=await mydb!.query(table);
    return response;
  }
  insert(String table,Map<String, Object?> values)async{

    Database? mydb=await db;
    int response=await mydb!.insert(table, values);
    return response;
  }
  update(String table,Map<String, Object?> values,String? where)async{

    Database? mydb=await db;
    int response=await mydb!.update(table, values,where:where );
    return response;
  }
  delete(String table,String? where)async{

    Database? mydb=await db;
    int response=await mydb!.delete(table,where:where );
    return response;
  }

}
