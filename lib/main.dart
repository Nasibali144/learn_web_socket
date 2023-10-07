import 'package:flutter/material.dart';
import 'package:learn_web_socket/service/socket_service.dart';

void main() {
  SocketService.init();
  SocketService.send();
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


class HomePage extends StatelessWidget {
  const HomePage({super.key});



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: SocketService.read(),
        builder: (context, snapshot) {
          if(!snapshot.hasData) {
            return const Center(
              child: Text("No Data"),
            );
          }

          return Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Text("Symbol", style: Theme.of(context).textTheme.titleMedium,),
                    const SizedBox(width: 20,),
                    Expanded(child: Text(snapshot.data?.symbol ?? "No data", style: Theme.of(context).textTheme.bodyMedium,)),
                  ],
                ),

                Row(
                  children: [
                    Text("Data", style: Theme.of(context).textTheme.titleMedium,),
                    const SizedBox(width: 20,),
                    Expanded(child: Text(snapshot.data?.data.toString() ?? "No data", style: Theme.of(context).textTheme.bodyMedium,)),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
