import 'package:time_blocking/models/links.dart';
import 'package:time_blocking/models/to_do.dart';
import 'package:uuid/uuid.dart';

class TimeBlock {
  final String blockId;
  final String blockName;
  final String startTime;
  final String endTime;
  String? description; // referred as notes also in UI
  List<ToDoItem>? toDoItems;
  final List<Link>? links;

  TimeBlock({
    String? blockId,
    required this.blockName,
    required this.startTime,
    required this.endTime,
    this.description,
    this.toDoItems,
    this.links,
  }) : blockId = blockId ?? const Uuid().v4();

  factory TimeBlock.fromJson(Map<String, dynamic> json) => TimeBlock(
        blockId: json['blockId'] ?? const Uuid().v4(),
        blockName: json['blockName'] as String,
        startTime: json['startTime'] as String,
        endTime: json['endTime'] as String,
        description: json["description"] as String?,
        toDoItems: (json['toDoItems'] as List<dynamic>?)
            ?.map((item) => ToDoItem.fromJson(item as Map<String, dynamic>))
            .toList(),
        links: (json['links'] as List<dynamic>?)
            ?.map((item) => Link.fromJson(item as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson([timeBlock]) => {
        'blockId': blockId,
        'blockName': blockName,
        'startTime': startTime, // Already a string, no changes needed
        'endTime': endTime, // Already a string, no changes needed
        'description': description,
        'toDoItems': toDoItems?.map((item) => item.toJson()).toList(),
        'links': links?.map((item) => item.toJson()).toList(),
      };
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
