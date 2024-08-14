import 'package:flutter/material.dart';
import 'package:time_blocking/dialogs/add_block.dart';
import 'package:time_blocking/dialogs/confirm_dialog.dart';
import 'package:time_blocking/models/links.dart';
import 'package:time_blocking/models/time_block.dart';
import 'package:time_blocking/models/to_do.dart';
import 'package:time_blocking/storage/load_time_blocks.dart';
import 'package:time_blocking/widgets/buttons/add_block_content_btn.dart';
import 'package:time_blocking/widgets/inputs/add_link_input.dart';
import 'package:time_blocking/widgets/inputs/add_to_do_item.dart';
import 'package:time_blocking/widgets/description.dart';
import 'package:time_blocking/widgets/to_do_list.dart';
import 'package:url_launcher/url_launcher.dart';

class OpenBlockScreen extends StatefulWidget {
  const OpenBlockScreen(
      this.currentBlock, this.index, this.removeBlock, this.updateParentState,
      {super.key});

  final TimeBlock currentBlock;
  final int index;
  final Function(dynamic) removeBlock;
  final Function() updateParentState;

  @override
  OpenBlockScreenState createState() => OpenBlockScreenState();
}

class OpenBlockScreenState extends State<OpenBlockScreen> {
  late TimeBlock _currentBlock;
  late List<ToDoItem>? toDoItems;
  late List<Link>? links;
  Function get removeBlock => widget.removeBlock;
  int get index => widget.index;
  Function get updateParentState => widget.updateParentState;
  late bool emptyToDo;
  late bool emptyLinks;

  @override
  void initState() {
    super.initState();
    _currentBlock = widget.currentBlock;
    // Load and set To Do List
    toDoItems = _currentBlock.toDoItems;
    toDoItems ??= [];
    if (toDoItems == null || toDoItems!.isEmpty) {
      emptyToDo = true;
    } else {
      emptyToDo = false;
    }
    // Dummy data for testing:
    // links = [
    //   Link(name: 'Google', link: Uri.parse('https://www.google.com/')),
    //   Link(name: 'Wikipedia', link: Uri.parse('https://www.wikipedia.org/')),
    //   Link(name: 'Example', link: Uri.parse('https://www.example.com/')),
    // ];
    // emptyLinks = false;

    // Load and set links list
    links = _currentBlock.links;
    links ??= [];
    if (_currentBlock.links == null || _currentBlock.links!.isEmpty) {
      emptyLinks = true;
    } else {
      emptyLinks = false;
    }
  }

  void updateState({bool toDo = false, bool link = false}) {
    loadTimeBlocks().then((updatedBlocks) {
      setState(() {
        _currentBlock = updatedBlocks[index];
        if (toDo) {
          toDoItems = _currentBlock.toDoItems;
        }
        if (link) {
          links = _currentBlock.links;
        }
      });
    });
    updateParentState();
  }

  Future<void> _launchUrl(uri) async {
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $uri');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _currentBlock.blockName,
          style: const TextStyle(fontSize: 18),
        ),
        actions: [
          IconButton(
            onPressed: () {
              addBlockDialog(context, updateState,
                  type: "Edit", index: index, updateParent: updateParentState);
            },
            icon: const Icon(
              Icons.edit,
              color: Colors.white,
            ),
          ),
          IconButton(
            onPressed: () {
              // init will be triggered, so empty state update function
              confirmDialog(context, updateParentState, action: () {
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
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Description / notes
              DescriptionWidget(
                currentBlock: _currentBlock,
                index: index,
              ),
              const Divider(),
              const SizedBox(
                height: 10,
              ),
              if (emptyToDo)
                // Add To Do List +
                AddBlockContentBtn(
                    displayContentState: () {
                      setState(() {
                        emptyToDo = !emptyToDo;
                      });
                    },
                    message: "Add To Do List"),
              if (!emptyToDo)
                const Text(
                  "To Do List",
                  style: TextStyle(fontSize: 25),
                ),
              if (!emptyToDo)
                // Add to do input
                AddToDoItem(
                  blockIndex: index,
                  updateState: updateState,
                ),
              ToDoList(
                currentBlock: _currentBlock,
                blockIndex: index,
                toDoList: toDoItems,
                updateParentStates: updateState,
              ),
              const Divider(),
              const SizedBox(
                height: 10,
              ),
              if (emptyLinks)
                // Add Links +
                AddBlockContentBtn(
                    displayContentState: () {
                      setState(() {
                        emptyLinks = !emptyLinks;
                      });
                    },
                    message: "Add Links"),

              if (!emptyLinks)
                const Text(
                  "Links And Resources",
                  style: TextStyle(fontSize: 25),
                ),
              if (!emptyLinks)
                // const AddLinks()
                AddLinkInput(blockIndex: index, updateState: updateState),
              // TODO: FEATURE: 3. Make AddLinks widget to add links
              if (emptyLinks)
                AddLinkInput(blockIndex: index, updateState: updateState),
              if (!emptyLinks)
                for (var i = 0; i < links!.length; i++)
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    trailing: IconButton(
                      onPressed: () async {
                        _launchUrl(links![i].link);
                      },
                      icon: const Icon(Icons.open_in_new),
                    ),
                    title: Align(
                      alignment: Alignment.centerLeft,
                      child: TextButton(
                        child: Text(links![i].name),
                        onPressed: () async {
                          _launchUrl(links![i].link);
                        },
                      ),
                    ),
                  )
            ],
          ),
        ),
      ),
    );
  }
}
