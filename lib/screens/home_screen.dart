import 'package:flutter/material.dart';
import 'package:time_blocking/dialogs/add_block.dart';
import 'package:time_blocking/utils/load_time_blocks.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  late List<dynamic> timeBlocks = [];
  // -> Using TimeBlock type instead of <dynamic>?

  @override
  void initState() {
    super.initState();
    updateState();
  }

  void updateState() {
    loadTimeBlocks().then((blocks) {
      setState(() {
        timeBlocks = blocks;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Time Blocking made simple"),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            addBlockDialog(context, updateState);
          },
          child: const Icon(Icons.add)),
      body: ListView.builder(
        itemCount: timeBlocks.length,
        itemBuilder: (context, index) {
          final currentBlock = timeBlocks[index];
          return ListTile(
            title: Text(currentBlock["blockName"]),
            subtitle: Text(
                '${currentBlock['startTime']} - ${currentBlock['endTime']}'),
          );
        },
      ),
    );
  }
}
