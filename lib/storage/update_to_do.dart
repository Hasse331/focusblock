import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:time_blocking/models/to_do.dart';

Future<void> updateToDo(
    {required int blockIndex, required List<ToDoItem> toDo}) async {
  final prefs = await SharedPreferences.getInstance();
  final timeBlocksString = prefs.getString('timeBlocks') ?? '[]';
  final List<dynamic> blocks = jsonDecode(timeBlocksString);

  if (blockIndex >= 0 && blockIndex < blocks.length) {
    blocks[blockIndex]["toDoItems"] = toDo;
    await prefs.setString('timeBlocks', jsonEncode(blocks));
  }
}
