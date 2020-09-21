
import 'package:jarvistaskfinal/src/models/users_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class DatabaseProvider {
  static const String TABLE_USER = "user";
  static const String COLUMN_ID = "id";
  static const String COLUMN_EMAIL = "email";
  static const String COLUMN_FIRST_NAME = "first_name";
  static const String COLUMN_LAST_NAME = "last_name";
  static const String COLUMN_AVATAR = "avatar";

  DatabaseProvider._();
  static final DatabaseProvider db = DatabaseProvider._();

  Database _database;

  Future<Database> get database async {
    print("database getter called");

    if (_database != null) {
      return _database;
    }

    _database = await createDatabase();

    return _database;
  }

  Future<Database> createDatabase() async {
    String dbPath = await getDatabasesPath();

    return await openDatabase(
      join(dbPath, 'userDB.db'),
      version: 1,
      onCreate: (Database database, int version) async {
        print("Creating user table");

        await database.execute(
          "CREATE TABLE $TABLE_USER ("
              "$COLUMN_ID INTEGER PRIMARY KEY,"
              "$COLUMN_EMAIL TEXT,"
              "$COLUMN_FIRST_NAME TEXT,"
              "$COLUMN_LAST_NAME TEXT,"
              "$COLUMN_AVATAR TEXT,"
              ")",
        );
      },
    );
  }

  Future<List<UsersModel>> getUsers() async {
    final db = await database;

    var users = await db
        .query(TABLE_USER, columns: [COLUMN_ID, COLUMN_EMAIL, COLUMN_FIRST_NAME, COLUMN_LAST_NAME, COLUMN_AVATAR]);

    List<UsersModel> userList = List<UsersModel>();

    users.forEach((currentUser) {
      UsersModel user = UsersModel.fromMap(currentUser);

      userList.add(user);
    });

    return userList;
  }

  Future<UsersModel> insert(UsersModel user) async {
    final db = await database;
    user.id = await db.insert(TABLE_USER, user.toMap());
    return user;
  }

  Future<int> delete(int id) async {
    final db = await database;

    return await db.delete(
      TABLE_USER,
      where: "id = ?",
      whereArgs: [id],
    );
  }

  Future<int> update(UsersModel user) async {
    final db = await database;

    return await db.update(
      TABLE_USER,
      user.toMap(),
      where: "id = ?",
      whereArgs: [user.id],
    );
  }
}