import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> removeToDoBlock(int index) async {
  final prefs = await SharedPreferences.getInstance();
  final templatesStr = prefs.getString('toDoBlocks') ?? '[]';
  List<dynamic> templates = json.decode(templatesStr);

  templates.removeAt(index);

  await prefs.setString('toDoBlocks', json.encode(templates));
}
