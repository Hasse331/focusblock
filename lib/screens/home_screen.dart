import 'package:flutter/material.dart';
import 'package:time_blocking/dialogs/add_block.dart';
import 'package:time_blocking/dialogs/confirm_dialog.dart';
import 'package:time_blocking/storage/load_time_blocks.dart';
import 'package:time_blocking/storage/reset_time_blocks.dart';
import 'package:time_blocking/storage/update_time_block.dart';
import 'package:time_blocking/widgets/my_time_block.dart';

// TODO: 1. Add edit block feature
// TODO: 3. Block notes feature
// TODO: 4. Add save schedules feature and menu

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
      // TODO:  2. Implement drag and drop order feature
      setState(() {
        timeBlocks = blocks;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar
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
      // Add btn
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addBlockDialog(context, updateState);
        },
        child: const Icon(Icons.add),
      ),
      // Blocks
      body: ListView.builder(
        itemCount: timeBlocks.length,
        itemBuilder: (context, index) {
          final Map<String, dynamic> currentBlock = timeBlocks[index];

          // Block Dismissing
          return Dismissible(
            key: Key(currentBlock["blockName"]),
            onDismissed: (direction) {
              setState(
                () {
                  timeBlocks.removeAt(index);
                  updateTimeBlocks(timeBlocks);
                },
              );
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("${currentBlock["blockName"]} dismissed"),
                ),
              );
            },
            // Block
            child: MyTimeBlock(currentBlock),
          );
        },
      ),
    );
  }
}
