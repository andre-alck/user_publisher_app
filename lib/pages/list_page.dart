import 'package:flutter/material.dart';
import 'package:p_user_publisher/service/database_service.dart';

class ListPage extends StatelessWidget {
  const ListPage({
    super.key,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      backgroundColor: Colors.purple[200],
      body: FutureBuilder(
        builder: (
          context,
          snapshot,
        ) {
          if (snapshot.hasData) {
            return Center(
              child: Text(
                snapshot.data.toString(),
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
        future: DatabaseService().listUsers(),
      ),
    );
  }
}
