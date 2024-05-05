// ignore_for_file: constant_identifier_names

import 'package:projectf/DataBase/flight_ticket.dart';
import 'package:projectf/DataBase/hotel_ticket.dart';
import 'package:projectf/DataBase/user.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DataBaseHandler {
  static Database? _db;
  static const String DATABASE = "mydata.db";
  static const int VERSION = 35;
//for user table
  static const String TABLE_USERS = "users";
  static const String ID = "id";
  static const String NAME = "name";
  static const String PASSWORD = "password";
  static const String FNAME = "fName";
  static const String LNAME = "lName";
  static const String PHONE_NUMBER = "phoneNumber";
//for hotel table
  static const String TABLE_HOTEL = "hotel";
  static const String GLOBALIDHOTEL = "globalidhotel";
  static const String PLACE = "place";
  static const String DESTINATION = "destination";
  static const String IMAGE = "image";
  static const String IDHOTEL = "idhotel";
  static const String NUM_OF_TICKETS = "numOfTickets";
  static const String PRICEHOTEL = "pricehotel";
  // for flight table
  static const String TABLE_FLIGHT = "flight";
  static const String IDFLIGHT = "idflight";
  static const String GLOBALIDFLIGHT = "globalidflight";
  static const String DATE = "date";
  static const String DEPARTURETIME = "departuretime";
  static const String SOURCE = "source";
  static const String DESTINATIONF = "destinationf";
  static const String SOURCECODE = "sourcecode";
  static const String DESTINATIONCODE = "destinationcode";
  static const String FLYINGTIME = "flyingtime";
  static const String PRICEFLIGHT = "priceflight";

  Future<Database?> get db async {
    if (_db == null) {
      _db = await initDb();
      return _db;
    } else {
      return _db;
    }
  }

  initDb() async {
    String path = join(await getDatabasesPath(), DATABASE);
    Database mydb = await openDatabase(path,
        version: VERSION, onCreate: _onCreate, onUpgrade: _onUpgrade);

    return mydb;
  }

  _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE $TABLE_USERS ($ID INTEGER PRIMARY KEY AUTOINCREMENT, $NAME TEXT, $PASSWORD TEXT, $FNAME TEXT, $LNAME TEXT, $PHONE_NUMBER TEXT);");

    await db.execute(
        "CREATE TABLE $TABLE_HOTEL ($GLOBALIDHOTEL INTEGER PRIMARY KEY AUTOINCREMENT, $IDHOTEL INTEGER, $PLACE TEXT , $DESTINATION TEXT , $IMAGE TEXT , $NUM_OF_TICKETS INTEGER, $PRICEHOTEL TEXT);");

    await db.execute(
        "CREATE TABLE $TABLE_FLIGHT ($GLOBALIDFLIGHT INTEGER PRIMARY KEY AUTOINCREMENT, $IDFLIGHT INTEGER, $SOURCE TEXT, $DESTINATIONF TEXT, $SOURCECODE TEXT, $DESTINATIONCODE TEXT, $DATE TEXT, $DEPARTURETIME TEXT, $FLYINGTIME TEXT, $PRICEFLIGHT TEXT);");
  }

  _onUpgrade(Database db, int oldVersion, int newVersion) async {
    await db.execute("DROP TABLE IF EXISTS $TABLE_USERS");
    await db.execute("DROP TABLE IF EXISTS $TABLE_HOTEL");
    await db.execute("DROP TABLE IF EXISTS $TABLE_FLIGHT");

    await _onCreate(db, newVersion);
  }

// -------------------------------flight methods--------------------------------------------

  Future<int> saveFlight(Flight flight) async {
    Database? dbClient = await db;
    int id = await dbClient!.insert(TABLE_FLIGHT, {
      'idflight': flight.id,
      'source': flight.source,
      'destinationf': flight.destination,
      'sourcecode': flight.sourceCode,
      'destinationcode': flight.destinationCode,
      'date': flight.date,
      'departuretime': flight.departureTime,
      'flyingtime': flight.flightDuration,
      'priceflight': flight.price
    });
    return id;
  }

  Future<List<Flight>> getFlightsForUser(userId) async {
    Database? dbClient = await db;
    List<Map<String, dynamic>> maps = await dbClient!.rawQuery(
        "SELECT * FROM $TABLE_FLIGHT WHERE $IDFLIGHT IN (SELECT $IDFLIGHT FROM $TABLE_USERS WHERE $ID = $userId)");

    List<Flight> flightList = [];
    if (maps.isNotEmpty) {
      for (int i = 0; i < maps.length; i++) {
        Map<String, dynamic> map = maps[i];
        Flight flight = Flight(
          id: map[GLOBALIDFLIGHT],
          idflight: map[IDFLIGHT],
          source: map[SOURCE],
          destination: map[DESTINATIONF],
          sourceCode: map[SOURCECODE],
          destinationCode: map[DESTINATIONCODE],
          date: map[DATE],
          departureTime: map[DEPARTURETIME],
          flightDuration: map[FLYINGTIME],
          price: map[PRICEFLIGHT],
        );
        flightList.add(flight);
      }
    }
    return flightList;
  }

  deleteFlight(int id) async {
    Database? dbClient = await db;
    return await dbClient!
        .delete(TABLE_FLIGHT, where: '$GLOBALIDFLIGHT = ?', whereArgs: [id]);
  }

  //-----------------------------------------------hotel methods--------------------------------------------
  Future<int> saveHotel(Hotel hotel) async {
    Database? dbClient = await db;
    int id = await dbClient!.insert(TABLE_HOTEL, {
      'idhotel': hotel.idhotel,
      'place': hotel.place,
      'destination': hotel.destination,
      'image': hotel.image,
      'numOfTickets': hotel.numOfTickets,
    });
    return id;
  }

  Future<List<Hotel>> getHotelsForUser(userId) async {
    Database? dbClient = await db;
    List<Map<String, dynamic>> maps = await dbClient!.rawQuery(
        "SELECT * FROM $TABLE_HOTEL WHERE $IDHOTEL IN (SELECT $ID FROM $TABLE_USERS WHERE $ID = $userId)");

    List<Hotel> hotelsList = [];
    if (maps.isNotEmpty) {
      for (int i = 0; i < maps.length; i++) {
        Map<String, dynamic> map = maps[i];
        Hotel hotel = Hotel(
          id: map[GLOBALIDHOTEL],
          idhotel: map[IDHOTEL],
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

  deleteHotel(int id) async {
    Database? dbClient = await db;
    return await dbClient!
        .delete(TABLE_HOTEL, where: '$GLOBALIDHOTEL = ?', whereArgs: [id]);
  }

// -------------------------------user Methods---------------------------------------------------------
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

  Future<int> deleteUser(String name) async {
    Database? dbClient = await db;
    int numOfRecords = await dbClient!
        .delete(TABLE_USERS, where: '$NAME = ?', whereArgs: [name]);
    return numOfRecords;
  }

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
