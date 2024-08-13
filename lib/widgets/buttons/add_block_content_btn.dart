import 'package:flutter/material.dart';

class AddBlockContentBtn extends StatelessWidget {
  const AddBlockContentBtn(
      {super.key, required this.displayContentState, required this.message});

  final Function displayContentState;
  final String message;

  // TODO: Add autofocus to the field

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TextButton(
          onPressed: () {
            displayContentState();
          },
          child: Text(message),
        ),
        IconButton(
          onPressed: () {
            displayContentState();
          },
          icon: Icon(
            Icons.add,
            size: 25,
          ),
        ),
      ],
    );
  }
}
