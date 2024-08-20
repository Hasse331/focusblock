import 'package:flutter/material.dart';
import 'package:time_blocking/dialogs/confirm_dialog.dart';
import 'package:time_blocking/models/template.dart';
import 'package:time_blocking/models/time_block.dart';
import 'package:time_blocking/screens/block_screen.dart';
import 'package:time_blocking/screens/read_only_blocks.dart';
import 'package:time_blocking/storage/load_templates.dart';
import 'package:time_blocking/storage/remove_template.dart';
import 'package:time_blocking/storage/reset_templates.dart';
import 'package:time_blocking/widgets/drawer.dart';
import 'package:time_blocking/widgets/my_time_block.dart';

class TemplateScreen extends StatefulWidget {
  const TemplateScreen({super.key});
  @override
  TemplateScreenState createState() => TemplateScreenState();
}

class TemplateScreenState extends State<TemplateScreen> {
  late List<TimeBlock> timeBlocks = [];
  late List<Template> templates = [];

  @override
  void initState() {
    super.initState();
    updateState();
  }

  void updateState() {
    loadTemplates().then((List<Template> newTemplates) {
      setState(() {
        templates = newTemplates;
        if (templates.isEmpty) {
          templates = [
            Template(name: "No templates added", templates: [
              TimeBlock(
                  blockName: "NO BLOCKS ADDED",
                  startTime: "12:00",
                  endTime: "13:00")
            ])
          ];
        }
      });
    });
  }

  void updateTemplateState(index) {
    setState(() {
      // TODO: Make template removing to work
      templates.removeAt(index);
      removeTemplate(index);
    });
  }

  // TODO: Add template renaming

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerWidget(),
      // AppBar
      appBar: AppBar(
        leading: Builder(builder: (context) {
          return IconButton(
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            icon: const Icon(
              Icons.menu,
            ),
          );
        }),
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
                  child: Text(" Templates",
                      style: TextStyle(
                          fontSize: 18, fontStyle: FontStyle.italic))),
            )
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              confirmDialog(context, updateState,
                  action: resetTemplates,
                  title: "Reset all templates",
                  message: "This action can't be undone!");
            },
            icon: const Icon(
              Icons.delete,
              color: Colors.red,
            ),
          ),
        ],
      ),
      // Add btn
      // Blocks
      body: ReorderableListView.builder(
        itemCount: templates.length,
        itemBuilder: (context, index) {
          final Template currentTemplate = templates[index];

          // Block Dismissing
          return Dismissible(
            key: Key(templates[index].name + index.toString()),
            onDismissed: (direction) {
              final templateName = templates[index].name;
              updateTemplateState(index);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("$templateName dismissed"),
                  action: SnackBarAction(
                    label: 'Undo',
                    onPressed: () {
                      setState(() {
                        // TODO: Make template screen dismiss undo function
                      });
                    },
                  ),
                  duration: const Duration(seconds: 5),
                ),
              );
            },
            // Block
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return ReadOnlyBlocks(
                          templates: templates, templateIndex: index);
                    },
                  ),
                );
              },
              child: MyTimeBlock(
                currentTemplate: currentTemplate,
              ),
            ),
          );
        },
        onReorder: (int oldIndex, int newIndex) {
          setState(
            () {
              // TODO: make template reorder work
              // if (oldIndex < newIndex) {
              //   newIndex -= 1;
              // }
              // final block = timeBlocks.removeAt(oldIndex);
              // timeBlocks.insert(newIndex, block);
              // updateTimeBlocks(timeBlocks);
            },
          );
        },
      ),
    );
  }
}
