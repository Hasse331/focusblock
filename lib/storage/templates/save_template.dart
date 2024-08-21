import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> saveTemplate({String? templateName}) async {
  final prefs = await SharedPreferences.getInstance();
  final timeBlocksStr = prefs.getString('timeBlocks') ?? '[]';
  final templatesStr = prefs.getString('templates') ?? '[]';
  List<dynamic> timeBlocks = json.decode(timeBlocksStr);
  List<dynamic> templates = json.decode(templatesStr);

  if (templateName == "") templateName = null;

  int templateNumber = templates.length + 1;
  Map<String, dynamic> newTemplate = {
    'name': templateName ?? 'Template $templateNumber',
    'templates': timeBlocks
  };

  templates.add(newTemplate);

  await prefs.setString('templates', json.encode(templates));
}
