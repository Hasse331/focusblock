import 'package:flutter/material.dart';
import 'package:time_blocking/models/time_block.dart';
import 'package:time_blocking/utils/calc_block_length.dart';

class MyTimeBlock extends StatelessWidget {
  const MyTimeBlock(
    this.currentBlock, {
    super.key,
  });

  final TimeBlock currentBlock;

  // TODO: Add optional icon to each block and in addBlock dialog

  @override
  Widget build(BuildContext context) {
    final blockSize = calcBlockLength(currentBlock);
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
      child: Column(children: [
        Text(
          currentBlock.blockName,
          style: const TextStyle(color: Colors.white),
        ),
        Text(
          '${currentBlock.startTime} - ${currentBlock.endTime}',
          style: const TextStyle(color: Colors.white),
        ),
      ]),
    );
  }
}
