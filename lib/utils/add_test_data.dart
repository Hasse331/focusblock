import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> addTestData() async {
  final prefs = await SharedPreferences.getInstance();

  // Get currently saved data
  final timeBlocks = prefs.getString('timeBlocks') ?? '[]';

  // Decode for operations
  List<dynamic> blocks = json.decode(timeBlocks);

  // Create new blocks
  final Map<String, dynamic> newBlock1 = {
    'blockName': "Test block 1",
    'startTime': "09:00", // Use string format for TimeOfDay
    'endTime': "11:00",
  };
  final Map<String, dynamic> newBlock2 = {
    'blockName': "Test block 2",
    'startTime': "11:00",
    'endTime': "12:00",
  };
  final Map<String, dynamic> newBlock3 = {
    'blockName': "Test block 3",
    'startTime': "13:00",
    'endTime': "13:30",
  };
  final Map<String, dynamic> newBlock4 = {
    'blockName': "Test block 4",
    'startTime': "14:00",
    'endTime': "17:00",
  };
  final Map<String, dynamic> newBlock5 = {
    'blockName': "Test block 5",
    'startTime': "17:00",
    'endTime': "21:00",
  };

  // Add new blocks to the list
  blocks.add(newBlock1);
  blocks.add(newBlock2);
  blocks.add(newBlock3);
  blocks.add(newBlock4);
  blocks.add(newBlock5);

  // Save updated list to SharedPreferences
  await prefs.setString('timeBlocks', json.encode(blocks));
}
