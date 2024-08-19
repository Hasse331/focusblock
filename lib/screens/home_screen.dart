import 'package:flutter/material.dart';
import 'package:time_blocking/dialogs/add_block.dart';
import 'package:time_blocking/dialogs/confirm_dialog.dart';
import 'package:time_blocking/models/time_block.dart';
import 'package:time_blocking/screens/open_block.dart';
// import 'package:time_blocking/utils/add_test_data.dart';
import 'package:time_blocking/storage/load_time_blocks.dart';
import 'package:time_blocking/storage/reset_time_blocks.dart';
import 'package:time_blocking/storage/update_time_block.dart';
import 'package:time_blocking/widgets/drawer.dart';
import 'package:time_blocking/widgets/my_time_block.dart';

// TODO: CROSS-PLATFORM: Optimizing UI for wide screens and other devices desktop/web
// TODO: UI/UX: Add no blocks added screen
// TODO: FEATURE: Add in new day screen 1-3 today's goals and link the goals to long term goal

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  late List<TimeBlock> timeBlocks = [];

  @override
  void initState() {
    super.initState();
    // addTestData();
    // resetTimeBlocks();
    updateState();
  }

  void updateState() {
    loadTimeBlocks().then((blocks) {
      setState(() {
        timeBlocks = blocks;
      });
    });
  }

  // TODO: REFACTOR: to better state management system
  // Now states have to be updated separately in every level
  // what makes state management complicated and may causing unexpected
  // behaviour / bugs if not handiling properly. Maintainance and new
  // features are also harder to implement.

  void removeBlock(index) {
    setState(() {
      timeBlocks.removeAt(index);
      updateTimeBlocks(timeBlocks);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerWidget(),
      // AppBar
      appBar: AppBar(
        leading: Builder(builder: (context) {
          return IconButton(
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            icon: const Icon(
              Icons.menu,
            ),
          );
        }),
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("FocusBlock "),
            Icon(
              Icons.horizontal_rule,
              size: 12,
            ),
            Center(
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  " My Day",
                  style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
                ),
              ),
            )
          ],
        ),
        actions: [
          IconButton(
            // TODO: FEATURE: Add reflection feature: 1. question and answer 2. summary 3. Saving the refleciton
            onPressed: () {
              confirmDialog(context, updateState,
                  action: resetTimeBlocks,
                  title: "Day completed!",
                  message:
                      "Well done! You've just wrapped up another productive day! 🎉\n\nBy continuing, you'll reset your today's schedule and start fresh for tomorrow.\n\nKeep in mind, this action can't be undone.");
            },
            // TODO: Add days completed score to new_day screen and validation between starting time and reset time to 8 hours
            icon: const Icon(
              Icons.check_box_sharp,
            ),
          ),
        ],
      ),
      // Add btn
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addBlockDialog(context, updateState, type: "New");
        },
        child: const Icon(Icons.add),
      ),
      // Blocks
      body: ReorderableListView.builder(
        itemCount: timeBlocks.length,
        itemBuilder: (context, index) {
          final TimeBlock currentBlock = timeBlocks[index];

          // Block Dismissing
          return Dismissible(
            key: Key(currentBlock.blockName + index.toString()),
            onDismissed: (direction) {
              removeBlock(index);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("${currentBlock.blockName} dismissed"),
                  action: SnackBarAction(
                    label: 'Undo',
                    onPressed: () {
                      setState(() {
                        timeBlocks.insert(index, currentBlock);
                        updateTimeBlocks(timeBlocks);
                      });
                    },
                  ),
                  duration: const Duration(seconds: 5),
                ),
              );
            },
            // Block
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OpenBlockScreen(
                        currentBlock, index, removeBlock, updateState),
                  ),
                );
              },
              child: MyTimeBlock(currentBlock),
            ),
          );
        },
        onReorder: (int oldIndex, int newIndex) {
          setState(
            () {
              if (oldIndex < newIndex) {
                newIndex -= 1;
              }
              final block = timeBlocks.removeAt(oldIndex);
              timeBlocks.insert(newIndex, block);
              updateTimeBlocks(timeBlocks);
            },
          );
        },
      ),
    );
  }
}
