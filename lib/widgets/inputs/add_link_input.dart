import 'package:flutter/material.dart';
import 'package:time_blocking/models/to_do.dart';
import 'package:time_blocking/storage/open_block/save_link.dart';
import 'package:time_blocking/widgets/show_error.dart';

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
  late TextEditingController _linkController;
  final FocusNode _focusNode = FocusNode();

  get blockIndex => widget.blockIndex;
  get updateState => widget.updateState;

  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _linkController = TextEditingController();
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

  bool hasValidEnding(String url) {
    final RegExp endingPattern = RegExp(r"\.[a-zA-Z]{2,}");
    return endingPattern.hasMatch(url);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          textCapitalization: TextCapitalization.sentences,
          focusNode: _focusNode,
          autofocus: false,
          controller: _linkController,
          decoration: const InputDecoration(
            hintText: 'Add New Link',
          ),
        ),
        if (_isFocused)
          Row(
            children: [
              TextButton(
                onPressed: () {
                  setState(() {
                    FocusScope.of(context).unfocus();
                    _linkController.clear();
                  });
                },
                child: const Text("Cancel"),
              ),
              TextButton(
                onPressed: () {
                  if (hasValidEnding(_linkController.text)) {
                    saveLink(
                        blockIndex: blockIndex, link: _linkController.text);
                    updateState(link: true);
                    _linkController.clear();
                    FocusScope.of(context).unfocus();
                  } else {
                    showError(context,
                        "Link has to have valid domain like .com .org .fi");
                  }
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
