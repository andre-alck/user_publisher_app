import 'package:flutter/material.dart';
import 'package:p_user_publisher/pages/list_page.dart';

import '../models/user.dart';
import '../service/amqp_controller_service.dart';
import '../service/database_service.dart';

class Home extends StatelessWidget {
  const Home({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(
    BuildContext context,
  ) {
    const String rk = 'rk';

    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.yellow[200],
        appBar: AppBar(),
        body: FutureBuilder(
          builder: (
            context,
            snapshot,
          ) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                DatabaseService().updateUser(
                  User(
                    id: 2,
                    age: 30,
                    name: 'Jackeline',
                  ),
                );

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (
                      context,
                    ) =>
                        const ListPage(),
                  ),
                );
              }
            }

            return const Center(
              child: CircularProgressIndicator(),
            );
          },
          future: AMQPControllerService().receive(
            rk,
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          label: const Icon(
            Icons.send_to_mobile,
          ),
          onPressed: () {
            DatabaseService().populate(
              User(
                id: 1,
                name: 'André',
              ),
            );
            DatabaseService().populate(
              User(
                id: 2,
                name: 'NomeErrado',
              ),
            );
            AMQPControllerService().send(
              rk,
            );
          },
        ),
      ),
    );
  }
}
