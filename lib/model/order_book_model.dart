final json = {
  "topic": "orderbook",
  "action": "partial",
  "symbol": "algo-usdt",
  "data": {
    "bids": [
      [0.0996, 12]
    ],
    "asks": [
      [0.1005, 747],
      [0.101, 87],
      [0.3, 7],
      [0.4, 1],
      [0.6, 7],
      [1, 2]
    ],
    "timestamp": "2023-10-07T12:15:11.340Z"
  },
  "time": 1696680911,
};

class OrderBook {
  String topic;
  String action;
  String symbol;
  Data data;
  int time;

  OrderBook({
    required this.topic,
    required this.action,
    required this.symbol,
    required this.data,
    required this.time,
  });

  factory OrderBook.fromJson(Map<String, Object?> json) {
    return OrderBook(
      topic: json["topic"] as String,
      action: json["action"] as String,
      symbol: json["symbol"] as String,
      data: Data.fromJson(json["data"] as Map<String, Object?>),
      time: json["time"] as int,
    );
  }
}

class Data {
  List<List<num>> bids;
  List<List<num>> asks;
  DateTime timestamp;

  Data({
    required this.bids,
    required this.asks,
    required this.timestamp,
  });

  factory Data.fromJson(Map<String, Object?> json) {
    return Data(
      bids: List<List>.from(json["bids"] as List).map((e) => List<num>.from(e)).toList(),
      asks: List<List>.from(json["asks"] as List).map((e) => List<num>.from(e)).toList(),
      timestamp: DateTime.parse(json["timestamp"] as String),
    );
  }

  @override
  String toString() {
    return "bids: $bids\nasks: $asks\ntimestamp: $timestamp";
  }
}
