import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

Future<void> saveToDo({required int blockIndex, required String toDo}) async {
  final prefs = await SharedPreferences.getInstance();
  final timeBlocksString = prefs.getString('timeBlocks') ?? '[]';
  final List<dynamic> blocks = jsonDecode(timeBlocksString);

  if (blockIndex >= 0 && blockIndex < blocks.length) {
    final timeBlock = blocks[blockIndex] as Map<String, dynamic>;
    if (!timeBlock.containsKey('toDoItems')) {
      timeBlock['toDoItems'] = [];
    }
    final toDoItems = timeBlock['toDoItems'] as List<dynamic>;
    toDoItems.add({'name': toDo, 'isChecked': false});
    await prefs.setString('timeBlocks', jsonEncode(blocks));
  } else {
    // Handle index out of bounds error
  }
}
