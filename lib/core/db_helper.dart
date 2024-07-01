import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  // Singleton instance of DBHelper
  static final DBHelper _instance = DBHelper._internal();
  static Database? _database;

  // Factory constructor to return the singleton instance
  factory DBHelper() {
    return _instance;
  }

  // Internal constructor for the singleton instance
  DBHelper._internal();

  // Getter for the database, initializes it if not already initialized
  Future<Database> get database async {
    if (_database != null) return _database!;

    // Initialize the database if it doesn't exist
    _database = await _initDatabase();
    return _database!;
  }

  // Initialize the database
  Future<Database> _initDatabase() async {
    // Get the path to the database directory
    final databasePath = await getDatabasesPath();
    // Set the path to the database file
    final path = join(databasePath, 'aniverse.db');

    // Open the database and set up the onCreate callback
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  // Callback to create the database schema
  Future<void> _onCreate(Database db, int version) async {
    // Create the 'users' table
    await db.execute('''
      CREATE TABLE users(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        username TEXT NOT NULL UNIQUE,
        password TEXT NOT NULL
      )
    ''');
  }

  // Register a new user in the database
  Future<int> registerUser(String username, String password) async {
    final db = await database;
    // Insert the username and password into the 'users' table
    return await db.insert('users', {
      'username': username,
      'password': password,
    });
  }

  // Log in a user by checking the username and password
  Future<Map<String, dynamic>?> loginUser(String username, String password) async {
    final db = await database;
    // Query the 'users' table for a matching username and password
    final result = await db.query(
      'users',
      where: 'username = ? AND password = ?',
      whereArgs: [username, password],
    );

    // Return the first matching user if found
    if (result.isNotEmpty) {
      return result.first;
    }
    // Return null if no matching user is found
    return null;
  }

  // Check if a username is already taken
  Future<bool> isUsernameTaken(String username) async {
    final db = await database;
    // Query the 'users' table for a matching username
    final result = await db.query(
      'users',
      where: 'username = ?',
      whereArgs: [username],
    );
    // Return true if the username is found, false otherwise
    return result.isNotEmpty;
  }
}
