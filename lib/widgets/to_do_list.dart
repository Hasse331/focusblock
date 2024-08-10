import 'package:flutter/material.dart';
import 'package:time_blocking/models/time_block.dart';
import 'package:time_blocking/models/to_do.dart';
import 'package:time_blocking/storage/load_time_blocks.dart';
import 'package:time_blocking/storage/update_time_block.dart';

// TODO: new todo items are not displaying when going home_screen and back
// getting old toDoList form parent maybe/ not updating it idk??

class ToDoList extends StatefulWidget {
  const ToDoList(
      {super.key,
      required this.blockIndex,
      required this.currentBlock,
      required this.toDoList,
      required this.updateState});

  final int blockIndex;
  final TimeBlock currentBlock;
  final List<ToDoItem>? toDoList;
  final Function updateState;

  @override
  ToDoListState createState() => ToDoListState();
}

class ToDoListState extends State<ToDoList> {
  int get blockIndex => widget.blockIndex;
  List<ToDoItem> get toDoItem => widget.toDoList!;
  TimeBlock get currentBlock => widget.currentBlock;
  Function get updateState => widget.updateState;

  void removeToDoItem(int blockIndex, int index) {
    loadTimeBlocks().then((blocks) {
      setState(() {
        toDoItem.removeAt(index);
        blocks[blockIndex].toDoItems!.removeAt(index);
        updateTimeBlocks(blocks);
        updateState();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: toDoItem.length,
        itemBuilder: (context, index) {
          return Dismissible(
            key: Key(toDoItem[index].name + index.toString()),
            onDismissed: (direction) {
              removeToDoItem(blockIndex, index);
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
              title: Text(toDoItem[index].name),
              value: toDoItem[index].isChecked,
              onChanged: (value) {
                loadTimeBlocks().then((blocks) {
                  setState(() {
                    toDoItem[index].isChecked = !toDoItem[index].isChecked;
                    // TODO: This is buggy somehow
                    // blocks[blockIndex].toDoItems![index].isChecked = value!;
                    // updateTimeBlocks(blocks);
                  });
                });
              },
            ),
          );
        },
      ),
    );
  }
}
