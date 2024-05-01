// ignore_for_file: constant_identifier_names

import 'package:projectf/DataBase/user.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DataBaseHandler {
  static Database? _db;
  static const String DATABASE = "mydata.db";
  static const int VERSION = 1;
  static const String TABLE_USERS = "users";
  static const String ID = "id";
  static const String NAME = "name";
  static const String PASSWORD = "password";
  static const String FNAME = "fName";
  static const String LNAME = "lName";

  Future<Database> get db async {
    if (_db == null) {
      String path = join(await getDatabasesPath(), DATABASE);
      _db = await openDatabase(path,
          version: VERSION, onCreate: _onCreate, onUpgrade: _onUpgrade);
    }
    return _db!;
  }

  _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE $TABLE_USERS ($ID INTEGER PRIMARY KEY AUTOINCREMENT, $NAME TEXT, $PASSWORD TEXT, $FNAME TEXT, $LNAME TEXT)");
  }

  _onUpgrade(Database db, int oldVersion, int newVersion) async {
    await db.execute("DROP TABLE IF EXISTS $TABLE_USERS");
    await _onCreate(db, newVersion);
  }

  Future<int> save(Users user) async {
    Database dbClient = await db;
    int id = await dbClient.insert(TABLE_USERS, {
      'id': user.id,
      'name': user.name,
      'password': user.password,
      'fName': user.fName,
      'lName': user.lName
    });
    return id;
  }

  Future<List<Users>> getUsers() async {
    Database dbClient = await db;
    Users users = Users();
    List<Map> maps = await dbClient.query(
      TABLE_USERS,
      columns: [ID, NAME, PASSWORD, FNAME, LNAME],
    );

    List<Users> usersList = [];
    if (maps.isNotEmpty) {
      for (int i = 0; i < maps.length; i++) {
        Map map = maps[i];
        Users user = Users(
            id: map[ID],
            name: map[NAME],
            password: map[PASSWORD],
            fName: map[FNAME],
            lName: map[LNAME]);
        usersList.add(user);
      }
    }
    if (maps.isEmpty) {
      users.id = 0;
    }
    return usersList;
  }

  Future<int> deleteUser(String name) async {
    Database dbClient = await db;
    int numOfRecords = await dbClient
        .delete(TABLE_USERS, where: '$NAME = ?', whereArgs: [name]);
    return numOfRecords;
  }

  Future<int> updateUser(Users user) async {
    Database dbClient = await db;
    int numOfRecords = await dbClient.update(
      TABLE_USERS,
      {
        'name': user.name,
        'password': user.password,
        'fName': user.fName,
        'lName': user.lName
      },
      where: '$NAME = ?',
      whereArgs: [user.name],
    );
    return numOfRecords;
  }
}
