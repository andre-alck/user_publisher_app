import 'package:flutter/material.dart';
import 'package:p_user_publisher/models/user.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  Future<void> populate(
    User user,
  ) async {
    WidgetsFlutterBinding.ensureInitialized();

    final database = openDatabase(
      join(
        await getDatabasesPath(),
        'user_database.db',
      ),
      onCreate: (db, version) {
        db.execute(
          'CREATE TABLE user(id INTEGER PRIMARY KEY, name TEXT, age INTEGER)',
        );
      },
      version: 1,
    );

    final db = await database;

    await db.insert(
      'user',
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> updateUser(
    User user,
  ) async {
    WidgetsFlutterBinding.ensureInitialized();

    final database = openDatabase(
      join(
        await getDatabasesPath(),
        'user_database.db',
      ),
      version: 1,
    );

    final db = await database;

    await db.update(
      'user',
      user.toMap(),
      where: 'id=?',
      whereArgs: [
        user.id,
      ],
    );
  }

  Future<List<User>> listUsers() async {
    final database = openDatabase(
      join(
        await getDatabasesPath(),
        'user_database.db',
      ),
      version: 1,
    );

    final db = await database;

    final List<Map<String, dynamic>> maps = await db.query(
      'user',
    );

    return List.generate(
      maps.length,
      (i) {
        return User(
          id: maps[i]['id'],
          name: maps[i]['name'],
          age: maps[i]['age'],
        );
      },
    );
  }

  Future<void> deleteUserTable() async {
    final database = openDatabase(
      join(
        await getDatabasesPath(),
        'user_database.db',
      ),
      version: 1,
    );
    final db = await database;

    db.delete(
      'user',
    );
  }
}
