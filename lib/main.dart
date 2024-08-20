import 'package:flutter/material.dart';
import 'package:time_blocking/screens/block_screen.dart';

void main() {
  runApp(const MyApp());
}

var kHighlightColor = const Color.fromARGB(255, 17, 0, 255);
var kforegroundColor = const Color.fromARGB(255, 200, 200, 200);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  // TODO: reorder storage folder it's getting messy
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FocusBlock - One day at a time',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 5, 28, 175)),
        useMaterial3: true,
        appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: const Color.fromARGB(255, 14, 12, 35),
          foregroundColor: kforegroundColor,
          shadowColor: kHighlightColor,
          elevation: 3,
        ),
      ),
      home: const SafeArea(child: BlockScreen()),
    );
  }
}
