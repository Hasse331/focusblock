import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:time_blocking/dialogs/add_block.dart';
import 'package:time_blocking/dialogs/confirm_dialog.dart';
import 'package:time_blocking/models/time_block.dart';
import 'package:time_blocking/screens/open_block.dart';
// import 'package:time_blocking/utils/add_test_data.dart';
import 'package:time_blocking/storage/load_time_blocks.dart';
import 'package:time_blocking/storage/reset_time_blocks.dart';
import 'package:time_blocking/storage/update_time_block.dart';
import 'package:time_blocking/widgets/my_time_block.dart';

// TODO: Optimizing UI for wide screens and other devices desktop/web
// TODO: Add no blocks added text

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
    updateState();
  }

  void updateState() {
    loadTimeBlocks().then((blocks) {
      setState(() {
        timeBlocks = blocks;
      });
    });
  }

  // TODO: Refactor to better state management system
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
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: ListTile(
                title: const Text('MENU'),
                trailing: Builder(builder: (context) {
                  return IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.close),
                  );
                }),
                onTap: () {
                  // Update the state of the app.
                  // ...
                },
              ),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.list),
              title: const Text('Templates'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              leading: const Icon(Icons.done),
              title: const Text('To Do Blocks'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              leading: const Icon(Icons.golf_course_sharp),
              title: const Text('Goals'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.account_box),
              title: const Text('Account'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              leading: const Icon(Icons.room_preferences),
              title: const Text('Theme'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
          ],
        ),
      ),
      // AppBar
      appBar: AppBar(
        leading: Builder(builder: (context) {
          return IconButton(
            onPressed: () {
              Scaffold.of(context).openDrawer();
              // TODO: Add menu
              // TODO: Add save schedules / templates feature
              // TODO: Add To Do - Not today / later screen and feature to add these blocks to today's schedule
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
