import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> saveTemplate(int index) async {
  final prefs = await SharedPreferences.getInstance();
  final templatesStr = prefs.getString('templates') ?? '[]';
  List<dynamic> templates = json.decode(templatesStr);

  templates.removeAt(index);

  await prefs.setString('templates', json.encode(templates));
}
