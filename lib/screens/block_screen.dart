import 'package:flutter/material.dart';
import 'package:time_blocking/dialogs/add_block.dart';
import 'package:time_blocking/dialogs/confirm_dialog.dart';
import 'package:time_blocking/models/template.dart';
import 'package:time_blocking/models/time_block.dart';
import 'package:time_blocking/screens/open_block.dart';
import 'package:time_blocking/storage/load_templates.dart';
// import 'package:time_blocking/utils/add_test_data.dart';
import 'package:time_blocking/storage/load_time_blocks.dart';
import 'package:time_blocking/storage/reset_time_blocks.dart';
import 'package:time_blocking/storage/save_template.dart';
import 'package:time_blocking/storage/update_time_block.dart';
import 'package:time_blocking/widgets/drawer.dart';
import 'package:time_blocking/widgets/my_time_block.dart';

// TODO: CROSS-PLATFORM: Optimizing UI for wide screens and other devices desktop/web

class BlockScreen extends StatefulWidget {
  const BlockScreen(
      {super.key,
      this.templateView = false,
      this.templates,
      this.templateIndex});

  final bool templateView;
  final List<Template>? templates;
  final int? templateIndex;

  @override
  BlockScreenState createState() => BlockScreenState();
}

// TODO: Make a decision if making templates READ ONLY in blockScreen and openScreen
// Otherwise it is so much work to do!

class BlockScreenState extends State<BlockScreen> {
  late List<TimeBlock> timeBlocks = [];
  get _templateView => widget.templateView;
  get _templates => widget.templates;
  get _templateIndex => widget.templateIndex;

  @override
  void initState() {
    super.initState();
    // addTestData();
    // resetTimeBlocks();
    updateState();
  }

  void updateState() {
    if (_templateView) {
      loadTemplates().then((List<Template> loadedTemplates) {
        setState(() {
          timeBlocks = _templates[_templateIndex].templates;
        });
      });
    } else {
      loadTimeBlocks().then((blocks) {
        setState(() {
          timeBlocks = blocks;
        });
      });
    }
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
      drawer: _templateView ? null : const DrawerWidget(),

      // AppBar
      appBar: AppBar(
        leading: _templateView
            ? null
            : Builder(builder: (context) {
                return IconButton(
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                  icon: const Icon(
                    Icons.menu,
                  ),
                );
              }),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("FocusBlock "),
            const Icon(
              Icons.horizontal_rule,
              size: 12,
            ),
            Center(
              child: Align(
                alignment: Alignment.center,
                child: _templateView
                    ? Text(
                        // TODO: Fix overflow
                        " ${_templates[_templateIndex].name}",
                        style: const TextStyle(
                            fontSize: 18, fontStyle: FontStyle.italic),
                      )
                    : const Text(
                        " My Day",
                        style: TextStyle(
                            fontSize: 18, fontStyle: FontStyle.italic),
                      ),
              ),
            )
          ],
        ),
        actions: [
          if (!_templateView)
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
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: "save button",
            mini: true,
            onPressed: () {
              saveTemplate();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Today's schedule saved as a template ✅"),
                ),
              );
            },
            child: const Icon(Icons.save, size: 18),
          ),
          const SizedBox(width: 15),
          FloatingActionButton(
            heroTag: "new block button",
            onPressed: () {
              addBlockDialog(context, updateState, type: "New");
            },
            child: const Icon(Icons.add),
          ),
        ],
      ),

      // Blocks
      body: ReorderableListView.builder(
        itemCount: timeBlocks.length,
        itemBuilder: (context, index) {
          final TimeBlock currentBlock = timeBlocks[index];

          // Block Dismissing
          return Dismissible(
            // TODO: FEATURE: Make dismissing work or readonly when in templateView
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
                if (_templateView) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Template blocks can not be opened"),
                      duration: Duration(seconds: 3),
                    ),
                  );
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OpenBlockScreen(
                          currentBlock, index, removeBlock, updateState),
                    ),
                  );
                }
              },
              child: MyTimeBlock(currentBlock: currentBlock),
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
