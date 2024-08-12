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
  late bool emptyToDo;
  late bool emptyLinks;

  @override
  void initState() {
    super.initState();
    _currentBlock = widget.currentBlock;
    toDoItems = _currentBlock.toDoItems;
    toDoItems ??= [];
    if (toDoItems == null || toDoItems!.length < 1) {
      emptyToDo = true;
    } else {
      emptyToDo = false;
    }
    if (_currentBlock.links == null || _currentBlock.links!.length < 1) {
      emptyLinks = true;
    } else {
      emptyLinks = false;
    }
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
            if (emptyToDo)
              // TODO: REFACTOR: Make this reusable, since it is already in 3 places
              Row(
                children: [
                  TextButton(
                    onPressed: () {
                      setState(() {
                        emptyToDo = !emptyToDo;
                      });
                    },
                    child: const Text('Add To Do List'),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        emptyToDo = !emptyToDo;
                      });
                    },
                    icon: Icon(
                      Icons.add,
                      size: 25,
                    ),
                  ),
                ],
              ),
            if (!emptyToDo)
              const Text(
                "To Do List",
                style: TextStyle(fontSize: 25),
              ),
            if (!emptyToDo)
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
            Divider(),
            SizedBox(
              height: 10,
            ),
            if (emptyLinks)
              Row(
                children: [
                  TextButton(
                    onPressed: () {
                      setState(() {
                        emptyLinks = !emptyLinks;
                      });
                    },
                    child: const Text('Add Links / Resources'),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        emptyLinks = !emptyLinks;
                      });
                    },
                    icon: Icon(
                      Icons.add,
                      size: 25,
                    ),
                  ),
                ],
              ),

            if (!emptyLinks)
              const Text(
                "Links And Resources",
                style: TextStyle(fontSize: 25),
              ), // TODO: FEATURE: Continue links/resources
          ],
        ),
      ),
    );
  }
}
