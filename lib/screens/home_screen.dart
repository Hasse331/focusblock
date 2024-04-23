import 'package:flutter/material.dart';
import 'package:time_blocking/dialogs/add_block.dart';
import 'package:time_blocking/models/time_block.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  List<TimeBlock> timeBlocks = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Time Blocking made simple"),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            addBlockDialog(context);
          },
          child: const Icon(Icons.add)),
      body: ListView.builder(
        itemCount: timeBlocks.length,
        itemBuilder: (context, index) {
          return const ListTile(
              title: Text("dummy title"), subtitle: Text("dummy subtitle"));
        },
      ),
    );
  }
}
