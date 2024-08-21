import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> removeToDoBlock({int? listIndex}) async {
  final prefs = await SharedPreferences.getInstance();
  final toDoStr = prefs.getString('toDoBlocks') ?? '[]';
  List<dynamic> toDo = json.decode(toDoStr);

  listIndex ??= toDo.length - 1;

  toDo.removeAt(listIndex);

  await prefs.setString('toDoBlocks', json.encode(toDo));
}
