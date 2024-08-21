import 'package:flutter/material.dart';
import 'package:time_blocking/models/template.dart';
import 'package:time_blocking/models/time_block.dart';
import 'package:time_blocking/storage/timeblocks/update_time_block.dart';
import 'package:time_blocking/storage/to_do_blocks/load_to_do_blocks.dart';
import 'package:time_blocking/widgets/my_time_block.dart';
import 'package:uuid/uuid.dart';

class ReadOnlyBlocks extends StatefulWidget {
  const ReadOnlyBlocks({super.key, this.templates, this.templateIndex});

  final List<Template>? templates;
  final int? templateIndex;

  @override
  ReadOnlyBlocksState createState() => ReadOnlyBlocksState();
}

class ReadOnlyBlocksState extends State<ReadOnlyBlocks> {
  late List<TimeBlock> timeBlocks = [];
  late String blockType;
  get _templates => widget.templates;
  get _templateIndex => widget.templateIndex;

  @override
  void initState() {
    super.initState();
    updateState();
  }

  void updateState() {
    if (_templates == null) {
      loadToDoBlocks().then((List<TimeBlock> loadedToDoBlocks) {
        setState(() {
          blockType = "To Do";
          if (loadedToDoBlocks.isEmpty) {
            timeBlocks = [
              TimeBlock(
                  blockId: const Uuid().v4(),
                  blockName: "No To Do blocks added",
                  startTime: "12:00",
                  endTime: "15:00")
            ];
          } else {
            timeBlocks = loadedToDoBlocks;
          }
        });
      });
    } else {
      setState(() {
        blockType = "Template";
        timeBlocks = _templates[_templateIndex].templates;
      });
    }
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
        // TODO: Add here + btn to add to do:s
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
                  child: _templates == null
                      ? const Text(
                          " To Do",
                          style: TextStyle(
                              fontSize: 18, fontStyle: FontStyle.italic),
                        )
                      : Text(
                          " ${_templates[_templateIndex].name}",
                          style: const TextStyle(
                              fontSize: 18, fontStyle: FontStyle.italic),
                        )),
            )
          ],
        ),
        // actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.add))],
      ),

      // Blocks
      body: ListView.builder(
        itemCount: timeBlocks.length,
        itemBuilder: (context, index) {
          final TimeBlock currentBlock = timeBlocks[index];

          return GestureDetector(
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                      "$blockType blocks are read only and can not be opened"),
                ),
              );
            },
            child: MyTimeBlock(currentBlock: currentBlock),
          );
        },
      ),
    );
  }
}
