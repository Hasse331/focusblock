import 'package:flutter/material.dart';
import 'package:time_blocking/dialogs/confirm_dialog.dart';

class OpenBlockScreen extends StatefulWidget {
  const OpenBlockScreen(
      this.currentBlock, this.index, this.removeBlock, this.updateState,
      {super.key});

  final Map<String, dynamic> currentBlock;
  final int index;
  final Function(dynamic) removeBlock;
  final Function() updateState;

  @override
  OpenBlockScreenState createState() => OpenBlockScreenState();
}

class OpenBlockScreenState extends State<OpenBlockScreen> {
  get currentBlock => widget.currentBlock;
  get removeBlock => widget.removeBlock;
  get index => widget.index;
  get updateState => widget.updateState;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          currentBlock["blockName"],
        ),
        actions: [
          IconButton(
            onPressed: () {
              // TODO: Make edit dialog
            },
            icon: const Icon(
              Icons.edit,
              color: Colors.white,
            ),
          ),
          IconButton(
            onPressed: () {
              // init will be triggered, so empty state update function
              confirmDialog(context, updateState, action: () {
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
        child: const Center(
          child: Column(
            children:
                // TODO: Block notes feature -> title, text, links
                [Text("text 1"), Text("text 2")],
          ),
        ),
      ),
    );
  }
}
