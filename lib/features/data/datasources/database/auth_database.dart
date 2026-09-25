import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';

class AuthDatabase {
  static Future<Database> open() async {
    final directory = await getDatabasesPath();

    return openDatabase(
      p.join(directory, 'auth.db'),
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE users (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            email TEXT NOT NULL UNIQUE,
            password_hash TEXT NOT NULL
          )
          '''
        );
      }
    );
  }
}