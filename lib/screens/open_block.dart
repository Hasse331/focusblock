import 'package:flutter/material.dart';
import 'package:time_blocking/dialogs/add_block.dart';
import 'package:time_blocking/dialogs/confirm_dialog.dart';
import 'package:time_blocking/models/time_block.dart';
import 'package:time_blocking/models/to_do.dart';
import 'package:time_blocking/storage/load_time_blocks.dart';
import 'package:time_blocking/widgets/add_to_do_item.dart';
import 'package:time_blocking/widgets/description.dart';
import 'package:time_blocking/widgets/to_do_list.dart';

class OpenBlockScreen extends StatefulWidget {
  const OpenBlockScreen(
      this.currentBlock, this.index, this.removeBlock, this.updateParentState,
      {super.key});

  final TimeBlock currentBlock;
  final int index;
  final Function(dynamic) removeBlock;
  final Function() updateParentState;

  @override
  OpenBlockScreenState createState() => OpenBlockScreenState();
}

class OpenBlockScreenState extends State<OpenBlockScreen> {
  late TimeBlock _currentBlock;
  late List<ToDoItem>? toDoItems;
  Function get removeBlock => widget.removeBlock;
  int get index => widget.index;
  Function get updateParentState => widget.updateParentState;

  @override
  void initState() {
    super.initState();
    _currentBlock = widget.currentBlock;
    toDoItems = _currentBlock.toDoItems;
    toDoItems ??= [];
  }

  void updateState({bool toDo = false}) {
    loadTimeBlocks().then((updatedBlocks) {
      setState(() {
        _currentBlock = updatedBlocks[index];
        if (toDo) {
          toDoItems = _currentBlock.toDoItems;
        }
      });
    });
    updateParentState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _currentBlock.blockName,
          style: const TextStyle(fontSize: 18),
        ),
        actions: [
          IconButton(
            onPressed: () {
              addBlockDialog(context, updateState,
                  type: "Edit", index: index, updateParent: updateParentState);
            },
            icon: const Icon(
              Icons.edit,
              color: Colors.white,
            ),
          ),
          IconButton(
            onPressed: () {
              // init will be triggered, so empty state update function
              confirmDialog(context, updateParentState, action: () {
                removeBlock(index);
                Navigator.of(context).pop();
              },
                  title: "Delete this block",
                  message:
                      "This will permanently delete This timeblock. Are you sure you want to continue?");
            },
            icon: const Icon(
              Icons.delete,
              color: Colors.red,
            ),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Description / notes
            DescriptionWidget(
              currentBlock: _currentBlock,
              index: index,
            ),
            const Divider(),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "To Do List",
              style: TextStyle(fontSize: 25),
            ),
            AddToDoItem(
              blockIndex: index,
              updateState: updateState,
            ),
            ToDoList(
              currentBlock: _currentBlock,
              blockIndex: index,
              toDoList: toDoItems,
              updateParentStates: updateState,
            ),
            // TODO: FEATURE: Links/resources
          ],
        ),
      ),
    );
  }
}
