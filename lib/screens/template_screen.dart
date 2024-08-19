import 'package:flutter/material.dart';
import 'package:time_blocking/dialogs/confirm_dialog.dart';
import 'package:time_blocking/models/template.dart';
import 'package:time_blocking/models/time_block.dart';
import 'package:time_blocking/screens/block_screen.dart';
import 'package:time_blocking/storage/load_templates.dart';
import 'package:time_blocking/storage/reset_templates.dart';
// import 'package:time_blocking/utils/add_test_data.dart';
import 'package:time_blocking/storage/update_time_block.dart';
import 'package:time_blocking/widgets/drawer.dart';
import 'package:time_blocking/widgets/my_time_block.dart';

// TODO: CROSS-PLATFORM: Optimizing UI for wide screens and other devices desktop/web
// TODO: UI/UX: Add no blocks added screen
// TODO: FEATURE: Add in new day screen 1-3 today's goals and link the goals to long term goal

class TemplateScreen extends StatefulWidget {
  const TemplateScreen({super.key});
  @override
  TemplateScreenState createState() => TemplateScreenState();
}

class TemplateScreenState extends State<TemplateScreen> {
  late List<TimeBlock> timeBlocks = [];
  late List<Template> templates = [];

  @override
  void initState() {
    super.initState();
    // addTestData();
    // resetTimeBlocks()
    // resetTemplates();
    updateState();
  }

  void updateState() {
    loadTemplates().then((List<Template> newTemplates) {
      print("DEBUGGING PRING DEBUGGING PRING DEBUGGING PRING");
      print("Loading templates in if statement");
      setState(() {
        templates = newTemplates;
        if (templates.isEmpty) {
          templates = [
            Template(name: "No tempaltes added", templates: [
              TimeBlock(
                  blockName: "NO BLOCK", startTime: "12:00", endTime: "13:00")
            ])
          ];
        }
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
                  child: Text("Templates",
                      style: TextStyle(
                          fontSize: 18, fontStyle: FontStyle.italic))),
            )
          ],
        ),
        actions: [
          IconButton(
            // TODO: FEATURE: Add reflection feature: 1. question and answer 2. summary 3. Saving the refleciton
            onPressed: () {
              confirmDialog(context, updateState,
                  action: resetTemplates,
                  title: "Reset all templates!",
                  message: "This action can't be undone!");
            },
            // TODO: Add days completed score to new_day screen and validation between starting time and reset time to 8 hours
            icon: const Icon(
              Icons.delete,
              color: Colors.red,
            ),
          ),
        ],
      ),
      // Add btn
      // Blocks
      body: ReorderableListView.builder(
        itemCount: templates.length,
        itemBuilder: (context, index) {
          print("DEBUGGING PRINT DEBUGGING PRINT DEBUGGING PRINT");
          print(templates[index].templates);
          final TimeBlock currentBlock = templates[index].templates[index];
          // Block Dismissing
          return Dismissible(
            key: Key(templates[index].name + index.toString()),
            onDismissed: (direction) {
              removeBlock(index);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("${templates[index].name} dismissed"),
                  action: SnackBarAction(
                    label: 'Undo',
                    onPressed: () {
                      setState(() {
                        // TODO: Make template screen dismiss function
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
                    builder: (context) {
                      return const BlockScreen();
                    },
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
