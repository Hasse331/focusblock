import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> useTemplate() async {
  final prefs = await SharedPreferences.getInstance();
  final templatesStr = prefs.getString('templates') ?? '[]';
  List<dynamic> templates = json.decode(templatesStr);

  await prefs.setString('timeBlocks', json.encode(templates[0]["templates"]));
}
