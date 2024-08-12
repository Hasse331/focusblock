import 'package:flutter/material.dart';
import 'package:time_blocking/models/time_block.dart';
import 'package:time_blocking/storage/save_description.dart';

class DescriptionWidget extends StatefulWidget {
  const DescriptionWidget(
      {super.key, required this.currentBlock, required this.index});

  final TimeBlock currentBlock;
  final int index;

  @override
  DescriptionWidgetState createState() => DescriptionWidgetState();
}

class DescriptionWidgetState extends State<DescriptionWidget> {
  late TimeBlock _currentBlock;
  int get index => widget.index;
  bool showInput = false;
  bool nullDescription = true;
  late TextEditingController _descriptionController;
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    // Dispose the FocusNode when the widget is disposed
    _focusNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _currentBlock = widget.currentBlock;
    _descriptionController = TextEditingController();
    nullDescription = descriptionNullCheck();
    if (!nullDescription) {
      _descriptionController =
          TextEditingController(text: _currentBlock.description);
    }
  }

  bool descriptionNullCheck() {
    if (_currentBlock.description == "" || _currentBlock.description == null) {
      return true;
    } else {
      return false;
    }
  }

  void saveDescription() {
    // Update relevant states:
    setState(() {
      _currentBlock.description = _descriptionController.text;
      nullDescription = descriptionNullCheck();
      showInput = !showInput;
    });

    // saveBlockDescription is saving null values as empty string
    saveBlockDescription(index, _descriptionController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Descritpion text:
        Row(
          children: [
            if (nullDescription && !showInput)
              TextButton(
                onPressed: () {
                  setState(() {
                    showInput = !showInput;
                  });
                  _focusNode.requestFocus();
                },
                child: const Text('Add Notes'),
              ),
            if (!nullDescription && !showInput)
              Expanded(
                child: Text(
                  "${_currentBlock.description}",
                  style: const TextStyle(fontSize: 15),
                  softWrap: true,
                  overflow: TextOverflow.fade,
                ),
              ),
            // Descritpion add/edit icon:
            if (!showInput)
              IconButton(
                onPressed: () {
                  setState(() {
                    showInput = true;
                  });
                  _focusNode.requestFocus();
                },
                padding: EdgeInsets.only(left: nullDescription ? 0 : 18),
                icon: Icon(
                  nullDescription ? Icons.add : Icons.edit,
                  size: nullDescription ? 25 : 20,
                ),
              ),

            // Descritpion input field:
            if (showInput)
              Expanded(
                child: Column(
                  children: [
                    TextField(
                      textCapitalization: TextCapitalization.sentences,
                      controller: _descriptionController,
                      focusNode: _focusNode,
                      autofocus: false,
                      maxLines: 10,
                      minLines: 1,
                      decoration: InputDecoration(
                        labelText: nullDescription ? "Add notes" : "Edti notes",
                      ),
                    ),
                    // Descritpion input field buttons:
                    Row(
                      // TODO: UI/UX add vertical horizontal padding to inputfields
                      children: [
                        TextButton(
                          onPressed: () {
                            setState(() {
                              showInput = !showInput;
                              FocusScope.of(context).unfocus();
                            });
                          },
                          child: const Text("Return"),
                        ),
                        TextButton(
                          onPressed: () {
                            saveDescription();
                            FocusScope.of(context).unfocus();
                          },
                          child: const Text("Save"),
                        ),
                      ],
                    )
                  ],
                ),
              ),
          ],
        ),
      ],
    );
  }
}
