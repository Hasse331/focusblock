import 'package:flutter/material.dart';
import 'package:time_blocking/dialogs/add_block.dart';
import 'package:time_blocking/dialogs/confirm_dialog.dart';
import 'package:time_blocking/storage/load_time_blocks.dart';
import 'package:time_blocking/storage/save_description.dart';

class OpenBlockScreen extends StatefulWidget {
  const OpenBlockScreen(
      this.currentBlock, this.index, this.removeBlock, this.updateParentState,
      {super.key});

  final Map<String, dynamic> currentBlock;
  final int index;
  final Function(dynamic) removeBlock;
  final Function() updateParentState;

  @override
  OpenBlockScreenState createState() => OpenBlockScreenState();
}

class OpenBlockScreenState extends State<OpenBlockScreen> {
  late Map<String, dynamic> _currentBlock;
  Function get removeBlock => widget.removeBlock;
  int get index => widget.index;
  Function get updateParentState => widget.updateParentState;
  bool showInput = false;
  bool nullDescription = true;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _currentBlock = widget.currentBlock;
    _descriptionController = TextEditingController();
    nullDescription = descriptionNullCheck();
    if (!nullDescription) {
      _descriptionController =
          TextEditingController(text: _currentBlock["description"]);
    }
  }

  bool descriptionNullCheck() {
    if (_currentBlock["description"] == "" ||
        _currentBlock["description"] == null) {
      return true;
    } else {
      return false;
    }
  }

  void saveDescription() {
    // Update relevant states:
    setState(() {
      _currentBlock["description"] = _descriptionController.text;
      nullDescription = descriptionNullCheck();
      showInput = !showInput;
    });

    // saveBlockDescription is saving null values as empty string
    saveBlockDescription(index, _descriptionController.text);
  }

  void updateState() {
    loadTimeBlocks().then((updatedBlocks) {
      setState(() {
        _currentBlock = updatedBlocks[index];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _currentBlock["blockName"],
          style: const TextStyle(fontSize: 18),
        ),
        actions: [
          IconButton(
            onPressed: () {
              addBlockDialog(context, updateState,
                  type: "Edit", index: index, updateParent: updateParentState);
            },
            icon: const Icon(
              Icons.edit,
              color: Colors.white,
            ),
          ),
          IconButton(
            onPressed: () {
              // init will be triggered, so empty state update function
              confirmDialog(context, updateParentState, action: () {
                removeBlock(index);
                Navigator.of(context).pop();
              },
                  title: "Delete this block",
                  message:
                      "This will permanently delete This timeblock. Are you sure you want to continue?");
            },
            icon: const Icon(
              Icons.delete,
              color: Colors.red,
            ),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            children: [
              // TODO: Refactor description as a separate widget(s)
              // TODO: ToDo list
              // TODO: Links/sources

              // Descritpion:
              Row(
                children: [
                  if (!nullDescription && !showInput)
                    Expanded(
                      child: Text(
                        "${_currentBlock["description"]}",
                        softWrap: true,
                        overflow: TextOverflow.fade,
                      ),
                    ),
                  if (!showInput)
                    TextButton(
                      onPressed: () {
                        setState(() {
                          showInput = true;
                        });
                      },
                      child: Icon(
                        nullDescription ? Icons.add : Icons.edit,
                        size: 18,
                      ),
                    )
                ],
              ),
              if (showInput)
                Expanded(
                  child: Column(
                    children: [
                      TextField(
                        controller: _descriptionController,
                        maxLines: 10,
                        minLines: 1,
                        decoration: InputDecoration(
                          labelText: nullDescription
                              ? "Add description"
                              : "Edti description",
                        ),
                      ),
                      Row(
                        children: [
                          TextButton(
                            onPressed: () {
                              setState(() {
                                showInput = !showInput;
                              });
                            },
                            child: const Text("Return"),
                          ),
                          TextButton(
                            onPressed: () {
                              saveDescription();
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
        ),
      ),
    );
  }
}
