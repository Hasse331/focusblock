import 'package:flutter/material.dart';
import 'package:time_blocking/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SSTB - Super Simple Time Blocking',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 5, 28, 175)),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
