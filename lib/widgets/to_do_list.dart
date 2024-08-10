import 'package:flutter/material.dart';
import 'package:time_blocking/models/time_block.dart';
import 'package:time_blocking/models/to_do.dart';

class ToDoList extends StatefulWidget {
  const ToDoList(
      {super.key,
      required this.blockIndex,
      required this.currentBlock,
      required this.toDoList});

  final int blockIndex;
  final TimeBlock currentBlock;
  final List<ToDoItem>? toDoList;

  @override
  ToDoListState createState() => ToDoListState();
}

class ToDoListState extends State<ToDoList> {
  get blockIndex => widget.blockIndex;
  get toDoItem => widget.toDoList;
  get currentBlock => widget.currentBlock;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: toDoItem!.length,
        itemBuilder: (context, index) {
          return CheckboxListTile(
            title: Text(toDoItem![index].name),
            value: toDoItem![index].isChecked,
            onChanged: (value) {
              setState(() {
                toDoItem![index].isChecked = value!;
              });
            },
          );
        },
      ),
    );
  }
}
