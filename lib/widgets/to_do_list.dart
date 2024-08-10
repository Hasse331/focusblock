import 'package:flutter/material.dart';
import 'package:time_blocking/models/time_block.dart';
import 'package:time_blocking/models/to_do.dart';

class ToDoList extends StatefulWidget {
  const ToDoList(
      {super.key, required this.blockIndex, required this.currentBlock});

  final int blockIndex;
  final Map<String, dynamic> currentBlock;

  @override
  ToDoListState createState() => ToDoListState();
}

class ToDoListState extends State<ToDoList> {
  late Map<String, dynamic> _currentBlock;
  late List toDoList;

  @override
  void initState() {
    super.initState();
    setState(() {
      _currentBlock = widget.currentBlock;
      if (_currentBlock["toDoList"] == null) {
        toDoList = [
          ToDoItem(name: 'No data', isChecked: false),
        ];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: toDoList.length,
        itemBuilder: (context, index) {
          return CheckboxListTile(
            title: Text(toDoList[index].name),
            value: toDoList[index].isChecked,
            onChanged: (value) {
              setState(() {
                // Add state update
              });
            },
          );
        },
      ),
    );
  }
}
