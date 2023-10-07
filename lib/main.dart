import 'package:flutter/material.dart';
import 'package:learn_web_socket/model/order_book_model.dart';
import 'package:learn_web_socket/service/socket_service.dart';

void main() {
  SocketService.init();
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  OrderBook? orderBook;

  @override
  void initState() {
    super.initState();
    SocketService.send();
    SocketService.read().listen((event) {
      orderBook = event;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    if(orderBook == null) {
      return const Scaffold(
        body: Center(
          child: Text("No Data"),
        ),
      );
    }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                Text("Symbol", style: Theme.of(context).textTheme.titleMedium,),
                const SizedBox(width: 20,),
                Expanded(child: Text(orderBook?.symbol ?? "No data", style: Theme.of(context).textTheme.bodyMedium,)),
              ],
            ),

            Row(
              children: [
                Text("Data", style: Theme.of(context).textTheme.titleMedium,),
                const SizedBox(width: 20,),
                Expanded(child: Text(orderBook?.data.toString() ?? "No data", style: Theme.of(context).textTheme.bodyMedium,)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    SocketService.close();
  }
}
