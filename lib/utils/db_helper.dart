import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  // Singleton instance of the database
  static Future<Database> database() async {
    final dbPath = await getDatabasesPath();
    return openDatabase(
      join(dbPath, 'sports_data.db'), // Combined database name
      onCreate: (db, version) async {
        // Create table for player scores
        await db.execute(
          'CREATE TABLE scores(id INTEGER PRIMARY KEY, playerId TEXT, score INTEGER, date TEXT)',
        );

        // Create table for stadium images
        await db.execute(
          'CREATE TABLE images(id INTEGER PRIMARY KEY, path TEXT, date TEXT)',
        );
      },
      version: 1,
    );
  }

  // Methods for handling player scores
  static Future<void> insertScore(
      String playerId, int score, String date) async {
    final db = await DBHelper.database();
    await db.insert(
      'scores',
      {'playerId': playerId, 'score': score, 'date': date},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<Map<String, dynamic>>> getScores() async {
    final db = await DBHelper.database();
    return db.query('scores');
  }

  // Methods for handling stadium images
  static Future<void> insertImage(String path, String date) async {
    final db = await DBHelper.database();
    await db.insert(
      'images',
      {'path': path, 'date': date},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<Map<String, dynamic>>> getImages({String? date}) async {
    final db = await DBHelper.database();
    if (date != null) {
      return db.query('images', where: 'date = ?', whereArgs: [date]);
    } else {
      return db.query('images');
    }
  }
}
