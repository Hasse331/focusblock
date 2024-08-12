import 'package:flutter/material.dart';
import 'package:time_blocking/models/time_block.dart';
import 'package:time_blocking/models/to_do.dart';
import 'package:time_blocking/storage/load_time_blocks.dart';
import 'package:time_blocking/storage/update_to_do.dart';
import 'package:time_blocking/storage/update_time_block.dart';

class ToDoList extends StatefulWidget {
  const ToDoList(
      {super.key,
      required this.blockIndex,
      required this.currentBlock,
      required this.toDoList,
      required this.updateParentStates});

  final int blockIndex;
  final TimeBlock currentBlock;
  final List<ToDoItem>? toDoList;
  final Function updateParentStates;

  @override
  ToDoListState createState() => ToDoListState();
}

class ToDoListState extends State<ToDoList> {
  int get blockIndex => widget.blockIndex;
  // Probably because of updateParentStates function what is resetting value of toDoItems
  List<ToDoItem> get toDoList => widget.toDoList!;
  TimeBlock get currentBlock => widget.currentBlock;
  Function get updateParentStates => widget.updateParentStates;

  void removeToDoItem(int blockIndex, int index) {
    loadTimeBlocks().then((blocks) {
      setState(() {
        blocks[blockIndex].toDoItems!.removeAt(index);
        updateTimeBlocks(blocks);
        updateParentStates(toDo: true);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ReorderableListView.builder(
        itemCount: toDoList.length,
        itemBuilder: (context, index) {
          return Dismissible(
            key: Key(toDoList[index].name + index.toString()),
            onDismissed: (direction) {
              removeToDoItem(blockIndex, index);
              // TODO: UI/UX: Add undo snackbar
              // ScaffoldMessenger.of(context).showSnackBar(
              //   SnackBar(
              //     content: Text(
              //         "${toDoItem[index].name} dismissed (not working yet)"),
              //     action: SnackBarAction(
              //       label: 'Undo',
              //       onPressed: () {
              //         setState(() {
              //           // Make this work
              //           // toDoItems.insert(index, toDoItem[index]);
              //           // updateToDoItems(toDoItem);
              //         });
              //       },
              //     ),
              //     duration: const Duration(seconds: 5),
              //   ),
              // );
            },
            child: CheckboxListTile(
              title: Text(toDoList[index].name),
              value: toDoList[index].isChecked,
              onChanged: (value) {
                loadTimeBlocks().then((blocks) {
                  setState(() {
                    // TODO: BUG: sometimes not updating the state when re-entering the widgewt
                    toDoList[index].isChecked = !toDoList[index].isChecked;
                    blocks[blockIndex].toDoItems![index].isChecked = value!;
                    updateTimeBlocks(blocks);
                  });
                });
              },
            ),
          );
        },
        onReorder: (int oldIndex, int newIndex) {
          setState(
            () {
              if (oldIndex < newIndex) {
                newIndex -= 1;
              }
              final toDo = toDoList.removeAt(oldIndex);
              toDoList.insert(newIndex, toDo);
              updateToDo(
                  blockIndex: blockIndex,
                  oldIndex: oldIndex,
                  newIndex: newIndex,
                  toDo: toDoList);
              updateParentStates(toDo: true);
            },
          );
        },
      ),
    );
  }
}
