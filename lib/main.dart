import 'package:flutter/material.dart';
import 'package:p_user_publisher/models/user.dart';
import 'package:p_user_publisher/service/amqp_controller_service.dart';
import 'package:p_user_publisher/service/database_service.dart';

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
    final database = DatabaseService();
    final user = User(
      age: 19,
      name: 'André',
    );
    final amqpControllerService = AMQPControllerService();

    return MaterialApp(
      title: 'User Publisher',
      home: Scaffold(
        appBar: AppBar(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            database.populate(
              user,
            );
            amqpControllerService.send(
              user,
            );
          },
        ),
      ),
    );
  }
}
