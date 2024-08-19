import 'package:shared_preferences/shared_preferences.dart';

void resetTemplates() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove('templates');
}
