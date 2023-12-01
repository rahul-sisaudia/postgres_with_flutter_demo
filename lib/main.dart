import 'package:flutter/material.dart';
import 'package:postgres_with_flutter_demo/core/message_handler.dart';
import 'package:postgres_with_flutter_demo/core/postgres_helper.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Postgres with Flutter Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  Future<void> _incrementCounter() async {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
                onPressed: () {
                  PostgresHelper.requestForDBConnectionStart();
                },
                child: const Text("Request for open db")),
            ElevatedButton(
                onPressed: () async {
                  String? message = await PostgresHelper.createTable();
                  MessageHandler.showNativeAlert(context: context, title: 'Alert', content: message??"", defaultActionText: 'Close');
                },
                child: const Text("create table")),
            ElevatedButton(
                onPressed: () {
                  PostgresHelper.addData();
                },
                child: const Text("Add data")),
            ElevatedButton(
                onPressed: () {
                  PostgresHelper.fetchAllData();
                },
                child: const Text("fetch records")),
            ElevatedButton(
                onPressed: () {
                  PostgresHelper.requestForDBConnectionStop();
                },
                child: const Text("request for close db")),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
