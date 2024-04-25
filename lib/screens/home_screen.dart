import 'package:flutter/material.dart';
import 'package:time_blocking/dialogs/add_block.dart';
import 'package:time_blocking/dialogs/confirm_dialog.dart';
import 'package:time_blocking/storage/load_time_blocks.dart';
import 'package:time_blocking/storage/reset_time_blocks.dart';

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
      blocks.sort(((a, b) {
        return a['startTime'].compareTo(b['startTime']);
      }));
      setState(() {
        timeBlocks = blocks;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("FocusBlock"),
        actions: [
          IconButton(
            onPressed: () {
              confirmDialog(context, updateState,
                  action: resetTimeBlocks,
                  title: "Reset time blocks",
                  message:
                      "This will permanently delete all timeblocks. Are you sure you want to continue?");
            },
            icon: const Icon(
              Icons.delete,
              color: Colors.red,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            addBlockDialog(context, updateState);
          },
          child: const Icon(Icons.add)),
      body: ListView.builder(
        // TODO: Validate the block times better in TimePicker wdgt
        // TODO: set the size of each block by making time length func
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
