import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:time_blocking/models/time_block.dart';

Future<void> saveToDoBlock(TimeBlock block) async {
  final prefs = await SharedPreferences.getInstance();
  final toDoBlocksStr = prefs.getString('toDoBlocks') ?? '[]';
  List<dynamic> toDoBlocks = json.decode(toDoBlocksStr);

  toDoBlocks.add(block);

  await prefs.setString('toDoBlocks', json.encode(toDoBlocks));
}
