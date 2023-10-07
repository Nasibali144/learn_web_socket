import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:learn_web_socket/model/order_book_model.dart';
import 'package:web_socket_channel/status.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

sealed class SocketService {
  static final _url = Uri.parse("wss://api.hollaex.com/stream");

  static late final WebSocketChannel _channel;

  static void init() {
    _channel = WebSocketChannel.connect(_url);
  }

  static final _stream = _channel.stream.asBroadcastStream();
  static Stream<OrderBook> read() {
    final stream = _stream;
    return stream.transform<OrderBook>(
      StreamTransformer.fromHandlers(
        handleData: (data, sink) {
          final json = jsonDecode(data);
          debugPrint("RunTimeType: ${json.runtimeType}");
          if (json is Map && json.containsKey("topic")) {
            debugPrint("Data: $json");
            try {
              final orderbook = OrderBook.fromJson(json as Map<String, Object?>);
              sink.add(orderbook);
            } catch(e) {
              debugPrint("Error: $e");
            }
          }
        },
      ),
    );
  }

  static void send() {
    _channel.sink.add(jsonEncode({
      "op": "subscribe",
      "args": ["orderbook"],
    }));
  }

  static void close() {
    _channel.sink.close(goingAway);
  }
}
