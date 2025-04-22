import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/story_model.dart';

class DBHelper {
  static final DBHelper _instance = DBHelper._internal();
  factory DBHelper() => _instance;
  DBHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    return _database ??= await _initDB();
  }

  Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'stories.db');

    await deleteDatabase(path);

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute('''
          CREATE TABLE stories(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT,
            imageUrl TEXT,
            author TEXT,
            genre TEXT,
            content TEXT
          )
        ''');
      },
    );
  }

  Future<int> insertStory(Story story) async {
    final db = await database;
    return await db.insert('stories', story.toMap());
  }

  Future<List<Story>> getStories() async {
    final db = await database;
    final maps = await db.query('stories');
    return maps.map((map) => Story.fromMap(map)).toList();
  }

  Future<int> updateStory(Story story) async {
    final db = await database;
    return await db.update('stories', story.toMap(),
        where: 'id = ?', whereArgs: [story.id]);
  }

  Future<int> deleteStory(int id) async {
    final db = await database;
    return await db.delete('stories', where: 'id = ?', whereArgs: [id]);
  }
}
