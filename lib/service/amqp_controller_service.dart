import 'dart:async';
import 'dart:io';

import 'package:dart_amqp/dart_amqp.dart';

class AMQPControllerService {
  Future<void> send(
    String username,
  ) async {
    ConnectionSettings connectionSettings = ConnectionSettings(
      maxConnectionAttempts: 5,
      host: '10.0.2.2',
      port: 5672,
    );

    Client client = Client(
      settings: connectionSettings,
    );
    Channel channel = await client.channel();
    Exchange exchange = await channel.exchange(
      "logs",
      ExchangeType.DIRECT,
    );

    exchange.publish(
      'OK',
      username,
    );

    client.close();
  }

  Future<String> receive(
    String username,
  ) async {
    final connectionSettings = ConnectionSettings(
      host: '10.0.2.2',
      port: 5672,
    );
    Client client = Client(
      settings: connectionSettings,
    );

    ProcessSignal.sigint.watch().listen(
      (
        event,
      ) async {
        await client.close();
        exit(
          0,
        );
      },
    );

    List<String> routingKeys = [];
    routingKeys.add(
      username,
    );

    final Completer<String> completer = Completer<String>();

    client.channel().then(
      (
        Channel channel,
      ) {
        return channel.exchange(
          "logs",
          ExchangeType.DIRECT,
          durable: false,
        );
      },
    ).then(
      (
        Exchange exchange,
      ) {
        return exchange.bindPrivateQueueConsumer(
          routingKeys,
          consumerTag: "logs",
          noAck: true,
        );
      },
    ).then(
      (
        Consumer consumer,
      ) {
        consumer.listen(
          (
            AmqpMessage message,
          ) =>
              completer.complete(
            message.payloadAsString,
          ),
        );
      },
    );

    return completer.future;
  }
}
