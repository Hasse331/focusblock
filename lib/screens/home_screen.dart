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
        // TODO: set the blocks in correct order, earlier in day first
        // TODO: set the size of each block by making time length func
        // TODO: add reset feature -> reset btn, dialog and function
        // TODO: Validate the block times better in TimePicker wdgt
        itemCount: timeBlocks.length,
        itemBuilder: (context, index) {
          final currentBlock = timeBlocks[index];
          return Container(
            padding: const EdgeInsets.all(25),
            margin: const EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: const Color.fromARGB(66, 144, 126, 208),
                borderRadius: BorderRadius.circular(5)),
            child: Column(children: [
              Text(currentBlock["blockName"]),
              Text('${currentBlock['startTime']} - ${currentBlock['endTime']}'),
            ]),
          );
        },
      ),
    );
  }
}
