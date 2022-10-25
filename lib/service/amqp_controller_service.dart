import 'package:dart_amqp/dart_amqp.dart';
import 'package:p_user_publisher/models/user.dart';

class AMQPControllerService {
  Future<void> send(
    User user,
  ) async {
    Client client = Client();
    Channel channel = await client.channel();
    Exchange exchange = await channel.exchange(
      "logs",
      ExchangeType.DIRECT,
    );

    exchange.publish(
      'OK',
      user.name,
    );

    client.close();
  }
}
