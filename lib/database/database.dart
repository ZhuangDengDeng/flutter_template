import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  DBProvider._();

  static final DBProvider db = DBProvider._();

  Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await initDB();
    return _database;
  }

  initDB() async {
    var dataBasePath = await getDatabasesPath();
    String path = join(dataBasePath, "demo.db");
    return await openDatabase(
      path,
      version: 1,
      onOpen: (db) {},
      onCreate: (Database db, int version) async {
        print("当前版本:$version");
        await db.execute("CREATE TABLE Demo ("
            "id INTEGER PRIMARY KEY AUTOINCREMENT,"
            "cotent TEXT,"
            ")");
      },
      onUpgrade: (Database db, int oldVersion, int newVersion) async {
        print("新版本:$newVersion");
        print("旧版本:$oldVersion");
      },
    );
  }
}
