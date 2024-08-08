import 'package:flutter/material.dart';

class ToDoList extends StatefulWidget {
  const ToDoList({super.key});

  @override
  ToDoListState createState() => ToDoListState();
}

class ToDoListState extends State<ToDoList> {
  @override
  Widget build(BuildContext context) {
    return const Text(
      "To Do List",
      style: TextStyle(fontSize: 25),
    );
  }
}
