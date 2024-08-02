import 'package:flutter/material.dart';

class OpenBlockScreen extends StatefulWidget {
  const OpenBlockScreen(this.currentBlock, {super.key});

  final Map<String, dynamic> currentBlock;

  @override
  OpenBlockScreenState createState() => OpenBlockScreenState();
}

class OpenBlockScreenState extends State<OpenBlockScreen> {
  get currentBlock => widget.currentBlock;

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
              // TODO: Make delete dialog
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
