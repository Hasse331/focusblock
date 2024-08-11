import 'package:flutter/material.dart';
import 'package:time_blocking/models/time_block.dart';
import 'package:time_blocking/models/to_do.dart';
import 'package:time_blocking/storage/save_to_do.dart';

class AddToDoItem extends StatefulWidget {
  const AddToDoItem(
      {super.key,
      required this.blockIndex,
      required this.currentBlock,
      required this.updateState});

  final int blockIndex;
  final TimeBlock currentBlock;
  final Function updateState;

  @override
  AddToDoItemState createState() => AddToDoItemState();
}

class AddToDoItemState extends State<AddToDoItem> {
  late TimeBlock _currentBlock;
  late List<ToDoItem>? toDoList;
  late TextEditingController _toDoNameController;
  final FocusNode _focusNode = FocusNode();

  get blockIndex => widget.blockIndex;
  get updateState => widget.updateState;

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
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
                  updateState(toDo: true);
                  _toDoNameController.clear();
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
