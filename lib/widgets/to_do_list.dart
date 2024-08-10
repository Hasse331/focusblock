import 'package:flutter/material.dart';
import 'package:time_blocking/models/time_block.dart';
import 'package:time_blocking/models/to_do.dart';
import 'package:time_blocking/storage/load_time_blocks.dart';
import 'package:time_blocking/storage/save_to_do.dart';

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
  late TextEditingController _toDoNameController;
  final FocusNode _focusNode = FocusNode();

  get blockIndex => widget.blockIndex;

  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _toDoNameController = TextEditingController();
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
    setState(() {
      _currentBlock = widget.currentBlock;
      toDoList = _currentBlock.toDoItems;
      toDoList ??= [ToDoItem(name: "No To DO items yet", isChecked: false)];
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void updateState() {
    loadTimeBlocks().then((updatedBlocks) {
      setState(() {
        _currentBlock = updatedBlocks[blockIndex];
        toDoList = _currentBlock.toDoItems;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // TODO:  ListView.builder is continually crashing the application
/*         Expanded(
          child: ListView.builder(
            itemCount: toDoList!.length,
            itemBuilder: (context, index) {
              return CheckboxListTile(
                title: Text(toDoList![index].name),
                value: toDoList![index].isChecked,
                onChanged: (value) {
                  setState(() {
                    toDoList![index].isChecked = value!;
                  });
                },
              );
            },
          ),
        ), */
        TextField(
          focusNode: _focusNode,
          controller: _toDoNameController,
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
                onPressed: () {
                  saveToDo(
                      blockIndex: blockIndex, toDo: _toDoNameController.text);
                  updateState();
                  FocusScope.of(context).unfocus();
                },
                child: const Text("Save"),
              ),
            ],
          ),
      ],
    );
  }
}
