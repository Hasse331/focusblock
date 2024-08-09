import 'package:flutter/material.dart';
import 'package:time_blocking/models/time_block.dart';
import 'package:time_blocking/models/to_do.dart';
import 'package:time_blocking/storage/update_time_block.dart';

class ToDoList extends StatefulWidget {
  const ToDoList({super.key, required this.blockIndex});

  final int blockIndex;

  @override
  ToDoListState createState() => ToDoListState();
}

// TODO: 2. Continue the ToDo feature when my brains are working and feeling good (not frustrated)

class ToDoListState extends State<ToDoList> {
  // Correctly formatted dummy data:
  List<TimeBlock> timeBlocks = [
    TimeBlock(
      blockName: 'Morning',
      startTime: const TimeOfDay(hour: 8, minute: 0),
      endTime: const TimeOfDay(hour: 12, minute: 0),
      description: 'Focus on important tasks',
      toDoItems: [
        ToDoItem(name: 'Finish report', isChecked: true),
        ToDoItem(name: 'Meeting with client', isChecked: false),
        ToDoItem(name: 'Check emails', isChecked: false),
      ],
    ),
    // ... Add more TimeBlocks with details
  ];

  @override
  Widget build(BuildContext context) {
    // Use blockIndex here when implemented
    TimeBlock currentBlock = timeBlocks[0];
    // Add null check here when implemented:
    List<ToDoItem> toDoList = currentBlock.toDoItems!;
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
