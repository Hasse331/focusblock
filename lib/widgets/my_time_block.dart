import 'package:flutter/material.dart';
import 'package:time_blocking/models/template.dart';
import 'package:time_blocking/models/time_block.dart';
import 'package:time_blocking/utils/calc_block_length.dart';

class MyTimeBlock extends StatelessWidget {
  const MyTimeBlock({
    this.currentBlock,
    this.currentTemplate,
    super.key,
  });

  final TimeBlock? currentBlock;
  final Template? currentTemplate;

  // TODO: UI/UX: Add optional icon to each block and in addBlock dialog

  @override
  Widget build(BuildContext context) {
    if (currentTemplate == null && currentBlock == null) {
      ArgumentError(
          "ERROR: currentTemplate and currentBlock both can not be null");
    }
    final blockSize = currentTemplate == null
        ? calcBlockLength(currentBlock)
        : 200.toDouble();
    final blockName = currentTemplate == null
        ? currentBlock!.blockName
        : currentTemplate!.name;
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: blockSize,
      ), // Dynamic block size
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        border: Border.all(
            color: const Color.fromARGB(255, 21, 0, 255), width: 0.5),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 21, 0, 255).withOpacity(0.25),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2), // changes position of shadow
          ),
        ],
        color: const Color.fromARGB(255, 12, 16, 46),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(children: [
              Text(
                blockName,
                style: const TextStyle(color: Colors.white),
              ),
              if (currentTemplate == null && currentBlock != null)
                Text(
                  '${currentBlock!.startTime} - ${currentBlock!.endTime}',
                  style: const TextStyle(color: Colors.white),
                ),
            ]),
          ),
        ],
      ),
    );
  }
}
