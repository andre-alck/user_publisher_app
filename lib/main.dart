import 'package:flutter/material.dart';
import 'package:p_user_publisher/models/user.dart';
import 'package:p_user_publisher/service/database.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    final database = Database();
    final user = User(
      age: 19,
      name: 'André',
    );
    return MaterialApp(
      title: 'User Publisher',
      home: Scaffold(
        appBar: AppBar(),
        floatingActionButton: FloatingActionButton(
          onPressed: () => database.populate(
            user,
          ),
        ),
      ),
    );
  }
}
