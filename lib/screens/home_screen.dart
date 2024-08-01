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
      // TODO:  1. Implement drag and drop order feature 2. Automatic sorting later
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
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        // TODO: add dynamic time block size
        itemCount: timeBlocks.length,
        itemBuilder: (context, index) {
          final currentBlock = timeBlocks[index];
          return Dismissible(
            key: Key(currentBlock["blockName"]),
            onDismissed: (direction) {
              setState(
                // TODO: Add block dismissing function
                () {},
              );
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("${currentBlock["blockName"]}, dismissed"),
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.all(
                  30), // tänne dynaaminen palikan koko sen min pituuden mukaan
              margin: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                border: Border.all(
                    color: const Color.fromARGB(255, 21, 0, 255), width: 0.5),
                boxShadow: [
                  BoxShadow(
                    color:
                        const Color.fromARGB(255, 21, 0, 255).withOpacity(0.25),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, 2), // changes position of shadow
                  ),
                ],
                color: const Color.fromARGB(255, 12, 16, 46),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(children: [
                Text(
                  currentBlock["blockName"],
                  style: const TextStyle(color: Colors.white),
                ),
                Text(
                  '${currentBlock['startTime']} - ${currentBlock['endTime']}',
                  style: const TextStyle(color: Colors.white),
                ),
              ]),
            ),
          );
        },
      ),
    );
  }
}
