import 'package:flutter/material.dart';
import 'package:time_blocking/models/template.dart';
import 'package:time_blocking/models/time_block.dart';
import 'package:time_blocking/storage/templates/load_templates.dart';
import 'package:time_blocking/storage/timeblocks/update_time_block.dart';
import 'package:time_blocking/widgets/my_time_block.dart';

class ReadOnlyBlocks extends StatefulWidget {
  const ReadOnlyBlocks({super.key, this.templates, this.templateIndex});

  final List<Template>? templates;
  final int? templateIndex;

  @override
  ReadOnlyBlocksState createState() => ReadOnlyBlocksState();
}

class ReadOnlyBlocksState extends State<ReadOnlyBlocks> {
  late List<TimeBlock> timeBlocks = [];
  get _templates => widget.templates;
  get _templateIndex => widget.templateIndex;

  @override
  void initState() {
    super.initState();
    updateState();
  }

  void updateState() {
    loadTemplates().then((List<Template> loadedTemplates) {
      setState(() {
        timeBlocks = _templates[_templateIndex].templates;
      });
    });
  }

  void removeBlock(index) {
    setState(() {
      timeBlocks.removeAt(index);
      updateTimeBlocks(timeBlocks);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("FocusBlock "),
            const Icon(
              Icons.horizontal_rule,
              size: 12,
            ),
            Center(
              child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    " ${_templates[_templateIndex].name}",
                    style: const TextStyle(
                        fontSize: 18, fontStyle: FontStyle.italic),
                  )),
            )
          ],
        ),
      ),

      // Blocks
      body: ListView.builder(
        itemCount: timeBlocks.length,
        itemBuilder: (context, index) {
          final TimeBlock currentBlock = timeBlocks[index];

          return GestureDetector(
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text(
                      "Template blocks are read only and can not be opened")));
            },
            child: MyTimeBlock(currentBlock: currentBlock),
          );
        },
      ),
    );
  }
}
