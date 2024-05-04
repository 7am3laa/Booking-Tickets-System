// ignore_for_file: constant_identifier_names

import 'package:projectf/DataBase/hotel_ticket.dart';
import 'package:projectf/DataBase/user.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

// Define database handler class
class DataBaseHandler {
  static Database? _db;
  static const String DATABASE = "mydata.db";
  static const int VERSION = 21;

  // Define users table fields
  static const String TABLE_USERS = "users";
  static const String ID = "id";
  static const String NAME = "name";
  static const String PASSWORD = "password";
  static const String FNAME = "fName";
  static const String LNAME = "lName";
  static const String PHONE_NUMBER = "phoneNumber";

  // Define hotel table fields
  static const String TABLE_HOTEL = "hotel";
  static const String PLACE = "place";
  static const String DESTINATION = "destination";
  static const String IMAGE = "image";
  static const String IDHOTEL = "id";
  static const String NUM_OF_TICKETS = "numOfTickets"; // Changed from "1"

  // Method to get database instance
  Future<Database?> get db async {
    if (_db == null) {
      _db = await initDb();
      return _db;
    } else {
      return _db;
    }
  }

  // Initialize database
  initDb() async {
    String path = join(await getDatabasesPath(), DATABASE);
    Database mydb = await openDatabase(path,
        version: VERSION, onCreate: _onCreate, onUpgrade: _onUpgrade);

    return mydb;
  }

  // Create tables on database creation
  _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE $TABLE_USERS ($ID INTEGER PRIMARY KEY AUTOINCREMENT, $NAME TEXT, $PASSWORD TEXT, $FNAME TEXT, $LNAME TEXT, $PHONE_NUMBER TEXT);");

    await db.execute(
        "CREATE TABLE $TABLE_HOTEL ($IDHOTEL INTEGER PRIMARY KEY AUTOINCREMENT, $PLACE TEXT , $DESTINATION TEXT , $IMAGE TEXT , $NUM_OF_TICKETS INTEGER);");
  }

  // Upgrade database tables
  _onUpgrade(Database db, int oldVersion, int newVersion) async {
    await db.execute("DROP TABLE IF EXISTS $TABLE_USERS");
    await db.execute("DROP TABLE IF EXISTS $TABLE_HOTEL");
    await _onCreate(db, newVersion);
  }

  // Insert data into database
  insertData(String sql) async {
    Database? dbClient = await db;
    int response = await dbClient!.rawInsert(sql);

    return response;
  }

  // Update data in database
  updateData(String sql) async {
    Database? dbClient = await db;
    int response = await dbClient!.rawInsert(sql);

    return response;
  }

  // Delete data from database
  deleteData(String sql) async {
    Database? dbClient = await db;
    int response = await dbClient!.rawInsert(sql);

    return response;
  }

  Future<List<Hotel>> getHotelsForUser() async {
    Database? dbClient = await db;
    List<Map<String, dynamic>> maps =
        await dbClient!.rawQuery("SELECT * FROM $TABLE_HOTEL WHERE $ID ");

    List<Hotel> hotelsList = [];
    if (maps.isNotEmpty) {
      for (int i = 0; i < maps.length; i++) {
        Map<String, dynamic> map = maps[i];
        Hotel hotel = Hotel(
          id: map[IDHOTEL],
          place: map[PLACE],
          destination: map[DESTINATION],
          image: map[IMAGE],
          numOfTickets: map[NUM_OF_TICKETS],
        );
        hotelsList.add(hotel);
      }
    }
    return hotelsList;
  }

  // Delete a hotel from the database
  deleteHotel(int id) async {
    Database? dbClient = await db;
    return await dbClient!
        .delete(TABLE_HOTEL, where: '$IDHOTEL = ?', whereArgs: [id]);
  }

  // Save user data to the database
  Future<int> save(Users user) async {
    Database? dbClient = await db;
    int id = await dbClient!.insert(TABLE_USERS, {
      'id': user.id,
      'name': user.name,
      'password': user.password,
      'fName': user.fName,
      'lName': user.lName,
      'phoneNumber': user.phoneNumber,
    });
    return id;
  }

  // Retrieve users from the database
  Future<List<Users>> getUsers() async {
    Database? dbClient = await db;
    Users users = Users();
    List<Map> maps = await dbClient!.query(
      TABLE_USERS,
      columns: [
        ID,
        NAME,
        PASSWORD,
        FNAME,
        LNAME,
        PHONE_NUMBER,
      ],
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
          lName: map[LNAME],
          phoneNumber: map[PHONE_NUMBER],
        );
        usersList.add(user);
      }
    }
    if (maps.isEmpty) {
      users.id = 0;
    }
    return usersList;
  }

  // Delete a user from the database
  Future<int> deleteUser(String name) async {
    Database? dbClient = await db;
    int numOfRecords = await dbClient!
        .delete(TABLE_USERS, where: '$NAME = ?', whereArgs: [name]);
    return numOfRecords;
  }

  // Update user data in the database
  Future<int> updateUser(Users user) async {
    Database? dbClient = await db;
    int numOfRecords = await dbClient!.update(
      TABLE_USERS,
      {
        'name': user.name,
        'password': user.password,
        'fName': user.fName,
        'lName': user.lName,
        'phoneNumber': user.phoneNumber,
      },
      where: '$NAME = ?',
      whereArgs: [user.name],
    );
    return numOfRecords;
  }
}
