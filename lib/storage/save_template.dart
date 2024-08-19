import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> saveTemplate() async {
  final prefs = await SharedPreferences.getInstance();
  final timeBlocksStr = prefs.getString('timeBlocks') ?? '[]';
  final templatesStr = prefs.getString('templates') ?? '[]';
  List<dynamic> timeBlocks = json.decode(timeBlocksStr);
  List<dynamic> templates = json.decode(templatesStr);

  int templateNumber = templates.length;
  Map<String, dynamic> newTemplate = {
    'name': 'Saved Template$templateNumber',
    'template': timeBlocks,
  };

  templates.add(newTemplate);

  await prefs.setString('templates', json.encode(templates));
}
