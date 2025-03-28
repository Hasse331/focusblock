import 'package:flutter/material.dart';
import 'package:time_blocking/storage/open_block/save_to_do.dart';

class AddToDoItem extends StatefulWidget {
  const AddToDoItem(
      {super.key, required this.blockIndex, required this.updateState});

  final int blockIndex;
  final Function updateState;

  @override
  AddToDoItemState createState() => AddToDoItemState();
}

class AddToDoItemState extends State<AddToDoItem> {
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
          textCapitalization: TextCapitalization.sentences,
          focusNode: _focusNode,
          autofocus: false,
          controller: _toDoNameController,
          decoration: const InputDecoration(
            hintText: 'Add New To Do',
          ),
        ),
        if (_isFocused)
          Row(
            children: [
              TextButton(
                onPressed: () {
                  setState(() {
                    FocusScope.of(context).unfocus();
                    _toDoNameController.clear();
                  });
                },
                child: const Text("Cancel"),
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
