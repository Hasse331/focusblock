import 'package:flutter/material.dart';
import 'package:time_blocking/dialogs/add_block.dart';
import 'package:time_blocking/dialogs/confirm_dialog.dart';
import 'package:time_blocking/storage/load_time_blocks.dart';

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

  @override
  void initState() {
    super.initState();
    _currentBlock = widget.currentBlock;
  }

  void updateState() {
    loadTimeBlocks().then((updatedBlocks) {
      setState(() {
        _currentBlock = updatedBlocks[index];
      });
    });
  }

  void toggleInput() {
    setState(() {
      showInput = true;
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
              // TODO: Description
              // TODO: ToDo list
              // TODO: Links

              // TODO: Add save button and function
              if (_currentBlock["description"] != null)
                Text("${_currentBlock["description"]}"),
              if (showInput) const TextField(),
              TextButton(
                onPressed: () {
                  toggleInput();
                },
                // TODO: Make user able to hide the input field
                child: Text(showInput ? "Return" : "Add description"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
