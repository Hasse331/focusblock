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
              final savedToDo = toDoList[index];
              removeToDoItem(blockIndex, index);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("${toDoList[index].name} dismissed"),
                  action: SnackBarAction(
                    label: 'Undo',
                    onPressed: () {
                      setState(() {
                        toDoList.insert(index, savedToDo);
                        updateToDo(blockIndex: blockIndex, toDo: toDoList);
                        updateParentStates(toDo: true);
                      });
                    },
                  ),
                  duration: const Duration(seconds: 5),
                ),
              );
            },
            child: CheckboxListTile(
              contentPadding: EdgeInsets.zero,
              // TODO: UI/UX: Make toDoItems editable
              title: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(child: Text(toDoList[index].name)),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.edit,
                      size: 18,
                    ),
                  ),
                ],
              ),
              value: toDoList[index].isChecked,
              onChanged: (value) {
                loadTimeBlocks().then((blocks) {
                  setState(() {
                    // TODO: BUG: sometimes not updating the state when re-entering the widgewt
                    // Have not happended anymore for a while
                    // Maybe after fixing state update problems
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
              updateToDo(blockIndex: blockIndex, toDo: toDoList);
              updateParentStates(toDo: true);
            },
          );
        },
      ),
    );
  }
}
