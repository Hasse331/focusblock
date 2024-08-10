import 'package:flutter/material.dart';
import 'package:time_blocking/models/links.dart';
import 'package:time_blocking/models/to_do.dart';

// Currently this model is not used anywhere and may be incorrecly defined
// TODO: transform loaded JSON data to dart object structure for readability and type safety

class TimeBlock {
  final String blockName;
  final String startTime;
  final String endTime;
  final String? description; // referred as notes also in UI
  final List<ToDoItem>? toDoItems;
  final List<Link>? links;

  TimeBlock({
    required this.blockName,
    required this.startTime,
    required this.endTime,
    this.description,
    this.toDoItems,
    this.links,
  });

  factory TimeBlock.fromJson(Map<String, dynamic> json) => TimeBlock(
        blockName: json['blockName'] as String,
        startTime: json['startTime'] as String,
        endTime: json['endTime'] as String,
        description: json["description"] as String,
        toDoItems: json["toDoItems"] as List<ToDoItem>,
        links: json["links"] as List<Link>,
      );

  TimeOfDay stringToTimeOfDay(String timeString) {
    final splitTime = timeString.split(':');
    final hour = int.parse(splitTime[0]);
    final minute = int.parse(splitTime[1]);
    return TimeOfDay(hour: hour, minute: minute);
  }
}



/* Correctly formatted dummy data example:
class ToDoListState extends State<ToDoList> {
  
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
 */

/* Accessing the data example:
TimeBlock firstBlock = timeBlocks[0]; // Access the first TimeBlock

String firstBlockName = firstBlock.blockName; // Access block name
TimeOfDay firstBlockStartTime = firstBlock.startTime; // Access start time

List<ToDoItem> firstBlockTasks = firstBlock.toDoItems!; // Access to-do list

// Accessing individual task data
String firstTaskName = firstBlockTasks[0].name; // Access first task name
bool firstTaskChecked = firstBlockTasks[0].isChecked; // Access checked state
 */
