import 'package:flutter/material.dart';
import 'package:time_blocking/models/to_do.dart';

class AddLinkInput extends StatefulWidget {
  const AddLinkInput(
      {super.key, required this.blockIndex, required this.updateState});

  final int blockIndex;
  final Function updateState;

  @override
  AddToDoItemState createState() => AddToDoItemState();
}

class AddToDoItemState extends State<AddLinkInput> {
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
            hintText: 'Add New Link',
          ),
        ),
        if (_isFocused)
          Row(
            // TODO: UI/UX remove left side padding
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
                  // TODO: Add save link function
                  updateState();
                  _toDoNameController.clear();
                  FocusScope.of(context).unfocus();
                },
                child: const Text("Save"),
              ),
            ],
          ),
        const Text(""),
      ],
    );
  }
}
