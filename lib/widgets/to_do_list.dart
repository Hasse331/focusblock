import 'package:flutter/material.dart';

class ToDoList extends StatefulWidget {
  const ToDoList({super.key});

  @override
  ToDoListState createState() => ToDoListState();
}

// TODO: 1. Plan and understand completely the data structure for todo data
// TODO: 2. Continue the ToDo feature when my brains are working and feeling good (not frustrated)

class ToDoListState extends State<ToDoList> {
  final List<String> testItems = ['Task 1', 'Task 2', 'Task 3'];
  final List<bool> checked = [false, false, false];

  void _toggleCheckbox(int index) {
    setState(() {
      checked[index] = !checked[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: testItems.length,
        itemBuilder: (context, index) {
          return CheckboxListTile(
            title: Text(testItems[index]),
            value: checked[index],
            onChanged: (value) {
              _toggleCheckbox(index);
            },
          );
        },
      ),
    );
  }
}
