// TODO: UI/UX: Add new day screen
// TODO: FEATURE: Add in new day screen 1-3 today's goals
// TODO: FEATURE: Make user able to load templates

// TODO: FEATURE: Make user able to link a goal to a long term goal

import 'package:flutter/material.dart';
import 'package:time_blocking/dialogs/add_block.dart';
import 'package:time_blocking/storage/templates/use_template.dart';

class NewDayScreen extends StatefulWidget {
  const NewDayScreen({super.key, required this.updateParentState});

  final Function updateParentState;

  @override
  NewDayScreenState createState() => NewDayScreenState();
}

class NewDayScreenState extends State<NewDayScreen> {
  get _updateParentState => widget.updateParentState;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("FocusBlock "),
            Icon(
              Icons.horizontal_rule,
              size: 12,
            ),
            Center(
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  " New day",
                  style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
                ),
              ),
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              const SizedBox(height: 50),
              const Text(
                "New Day!",
                style: TextStyle(fontSize: 35),
              ),
              const Text("Start new day or plan for a next one"),
              const Divider(),
              const SizedBox(height: 30),
              const Text(
                "Set goals",
                style: TextStyle(fontSize: 20),
              ),
              const Text(
                textAlign: TextAlign.center,
                "To get best out from your day, set 1-3 goals for next day aligned with your long term goals",
              ),
              const TextField(),
              const SizedBox(height: 30),
              const Text(
                textAlign: TextAlign.center,
                "Get started",
                style: TextStyle(fontSize: 20),
              ),
              const Text(
                textAlign: TextAlign.center,
                "Add your first timeblock or load template",
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  addBlockDialog(context, _updateParentState, type: "New");
                },
                child: const Text("Add first block"),
              ),
              ElevatedButton(
                onPressed: () {
                  // TODO: Make select template dialog
                  // TODO: Make useTemplate function
                  useTemplate();
                  _updateParentState();
                },
                child: const Text("Load template"),
              )
            ],
          ),
        )),
      ),
    );
  }
}
