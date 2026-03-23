import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/post.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('posts_manager.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    try {
      final dbPath = await getDatabasesPath();
      final path = join(dbPath, filePath);

      return await openDatabase(path, version: 1, onCreate: _createDB);
    } catch (e) {
      throw Exception('Failed to initialize database: $e');
    }
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE posts (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        content TEXT NOT NULL,
        author TEXT NOT NULL,
        createdAt TEXT NOT NULL
      )
    ''');
  }

  Future<List<Post>> getAllPosts() async {
    try {
      final db = await database;
      final result = await db.query('posts', orderBy: 'id DESC');
      return result.map((map) => Post.fromMap(map)).toList();
    } catch (e) {
      throw Exception('Failed to load posts: $e');
    }
  }

  Future<Post?> getPostById(int id) async {
    try {
      final db = await database;
      final result = await db.query('posts', where: 'id = ?', whereArgs: [id]);

      if (result.isNotEmpty) {
        return Post.fromMap(result.first);
      }
      return null;
    } catch (e) {
      throw Exception('Failed to fetch post details: $e');
    }
  }

  Future<int> insertPost(Post post) async {
    try {
      final db = await database;
      return await db.insert('posts', post.toMap());
    } catch (e) {
      throw Exception('Insert failed: $e');
    }
  }

  Future<int> updatePost(Post post) async {
    try {
      final db = await database;

      if (post.id == null) {
        throw Exception('Cannot update a post without an ID');
      }

      return await db.update(
        'posts',
        post.toMap(),
        where: 'id = ?',
        whereArgs: [post.id],
      );
    } catch (e) {
      throw Exception('Update failed: $e');
    }
  }

  Future<int> deletePost(int id) async {
    try {
      final db = await database;
      return await db.delete('posts', where: 'id = ?', whereArgs: [id]);
    } catch (e) {
      throw Exception('Delete failed: $e');
    }
  }

  Future close() async {
    final db = await database;
    db.close();
  }
}
