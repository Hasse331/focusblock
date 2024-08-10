import 'package:flutter/material.dart';
import 'package:time_blocking/models/time_block.dart';
import 'package:time_blocking/models/to_do.dart';

class ToDoList extends StatefulWidget {
  const ToDoList(
      {super.key, required this.blockIndex, required this.currentBlock});

  final int blockIndex;
  final TimeBlock currentBlock;

  @override
  ToDoListState createState() => ToDoListState();
}

class ToDoListState extends State<ToDoList> {
  late TimeBlock _currentBlock;
  late List<ToDoItem>? toDoList;
  final FocusNode _focusNode = FocusNode();

  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
    setState(() {
      _currentBlock = widget.currentBlock;
      toDoList = _currentBlock.toDoItems;
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          if (toDoList != null)
            ListView.builder(
              itemCount: toDoList?.length,
              itemBuilder: (context, index) {
                return CheckboxListTile(
                  title: Text(toDoList![index].name),
                  value: toDoList![index].isChecked,
                  onChanged: (value) {
                    setState(() {
                      // Add state update
                    });
                  },
                );
              },
            ),
          TextField(
            focusNode: _focusNode,
            decoration: const InputDecoration(
              hintText: 'Add new To Do',
            ),
          ),
          if (_isFocused)
            Row(
              children: [
                TextButton(
                  onPressed: () {
                    setState(() {
                      FocusScope.of(context).unfocus();
                    });
                  },
                  child: const Text("Return"),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text("Save"),
                ),
              ],
            )
        ],
      ),
    );
  }
}
