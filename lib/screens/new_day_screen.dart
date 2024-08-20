import 'package:flutter/material.dart';
import 'package:time_blocking/dialogs/add_block.dart';
import 'package:time_blocking/dialogs/select_dialog.dart';

class NewDayScreen extends StatefulWidget {
  const NewDayScreen({super.key, required this.updateParentState});

  final Function updateParentState;

  @override
  NewDayScreenState createState() => NewDayScreenState();
}

// TODO: GAMIFYING: Add days completed score and validation between starting time and reset time to 8 hours

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
              // const Text(
              //   "Set goals",
              //   style: TextStyle(fontSize: 20),
              // ),
              // const Text(
              //   textAlign: TextAlign.center,
              //   "To get best out from your day, set 1-3 goals for next day. Select goals aligned with your long term goals.",
              // ),
              // const TextField(
              //     // TODO: today's goals FEATURE: Make user able to save today's goals
              //     // TODO: today's goals FEATURE: Make user able to link a goal to a long term goal
              //     ),
              // // TODO: today's goals FEATURE: Display added goals
              // const SizedBox(height: 30),
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
                  showDialog(
                    context: context,
                    builder: (context) => SelectDialog(_updateParentState),
                  );
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
