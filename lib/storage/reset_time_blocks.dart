import 'package:shared_preferences/shared_preferences.dart';

void resetTimeBlocks() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove('timeBlocks');
}
