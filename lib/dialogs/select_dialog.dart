import 'package:flutter/material.dart';
import 'package:time_blocking/models/template.dart';
import 'package:time_blocking/models/time_block.dart';
import 'package:time_blocking/storage/templates/load_templates.dart';
import 'package:time_blocking/storage/templates/use_template.dart';
import 'package:time_blocking/storage/timeblocks/load_time_blocks.dart';
import 'package:time_blocking/storage/timeblocks/update_time_block.dart';
import 'package:time_blocking/storage/to_do_blocks/load_to_do_blocks.dart';
import 'package:time_blocking/storage/to_do_blocks/remove_to_do_block.dart';

class SelectDialog extends StatefulWidget {
  const SelectDialog(this.updateParentState,
      {this.selectTemplate = false, this.selectToDoBlock = false, super.key});

  final Function updateParentState;
  final bool selectToDoBlock;
  final bool selectTemplate;

  @override
  SelectDialogState createState() => SelectDialogState();
}

class SelectDialogState extends State<SelectDialog> {
  get _updateParentState => widget.updateParentState;
  get _selectToDoBlock => widget.selectToDoBlock;
  get _selectTemplate => widget.selectTemplate;
  late String selection;
  List<dynamic> dataList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    if (!_selectToDoBlock && !_selectTemplate) {
      throw ArgumentError(
          "ERROR: Both _selectToDoBlock and _selectTemplate can not be null");
    }
    updateState();
  }

  void updateState() {
    if (_selectTemplate) {
      loadTemplates().then((List<Template> loadedTemplates) {
        setState(() {
          dataList = loadedTemplates;
          selection = "Template";
          isLoading = false;
        });
      });
    } else if (_selectToDoBlock) {
      loadToDoBlocks().then((List<TimeBlock> loadedToDoBlocks) {
        setState(() {
          dataList = loadedToDoBlocks;
          selection = "To Do Block";
          isLoading = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: isLoading
            ? const Center(
                child:
                    CircularProgressIndicator()) // Show loading indicator while fetching
            : Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Select a $selection',
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: dataList.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: _selectTemplate
                            ? Text(dataList[index].name)
                            : Text(dataList[index]
                                .blockName), // Display template names
                        onTap: () {
                          if (_selectTemplate) {
                            // Call useTemplate with the selected index
                            useTemplate(index);
                          } else if (_selectToDoBlock) {
                            loadTimeBlocks().then((List<TimeBlock> timeBlocks) {
                              setState(() {
                                timeBlocks.add(dataList[index]);
                                updateTimeBlocks(timeBlocks);
                                removeToDoBlock(listIndex: index);
                                _updateParentState();
                              });
                            });
                          }
                          Navigator.of(context).pop();
                          _updateParentState(); // Close the dialog
                        },
                      );
                    },
                  ),
                ],
              ),
      ),
    );
  }
}
