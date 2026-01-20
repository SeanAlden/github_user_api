import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../../data/models/github_user.dart';

class FavoriteUserDatabase {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    final path = join(await getDatabasesPath(), 'favorite_users.db');
    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE favorites (
            id INTEGER PRIMARY KEY,
            username TEXT,
            avatarUrl TEXT,
            name TEXT,
            location TEXT,
            followers INTEGER
          )
        ''');
      },
    );
  }

  Future<void> insertUser(GithubUser user) async {
    final db = await database;
    await db.insert(
      'favorites',
      {
        'id': user.id,
        'username': user.username,
        'avatarUrl': user.avatarUrl,
        'name': user.name,
        'location': user.location,
        'followers': user.followers,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> deleteUser(int id) async {
    final db = await database;
    await db.delete('favorites', where: 'id = ?', whereArgs: [id]);
  }

  Future<bool> isFavorite(int id) async {
    final db = await database;
    final result =
        await db.query('favorites', where: 'id = ?', whereArgs: [id]);
    return result.isNotEmpty;
  }

  Future<List<GithubUser>> getFavorites() async {
    final db = await database;
    final result = await db.query('favorites');
    return result
        .map((e) => GithubUser(
              id: e['id'] as int,
              username: e['username'] as String,
              avatarUrl: e['avatarUrl'] as String,
              name: e['name'] as String?,
              location: e['location'] as String?,
              followers: e['followers'] as int?,
            ))
        .toList();
  }

  Future<List<GithubUser>> getFavoritesPaged({
    required int limit,
    required int offset,
  }) async {
    final db = await database;
    final result = await db.query(
      'favorites',
      limit: limit,
      offset: offset,
      orderBy: 'id DESC',
    );

    return result.map(GithubUser.fromDb).toList();
  }
}
