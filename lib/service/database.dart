import 'package:flutter/material.dart';
import 'package:p_user_publisher/models/user.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Database {
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
}
