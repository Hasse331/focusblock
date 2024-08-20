import 'package:flutter/material.dart';
import 'package:time_blocking/models/template.dart';
import 'package:time_blocking/storage/templates/load_templates.dart';
import 'package:time_blocking/storage/templates/use_template.dart';

class UseTemplateDialog extends StatefulWidget {
  const UseTemplateDialog(this.updateParentState, {super.key});

  final Function updateParentState;

  @override
  UseTemplateDialogState createState() => UseTemplateDialogState();
}

class UseTemplateDialogState extends State<UseTemplateDialog> {
  get _updateParentState => widget.updateParentState;
  List<Template> templates = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    updateState();
  }

  void updateState() {
    loadTemplates().then((List<Template> loadedTemplates) {
      setState(() {
        templates = loadedTemplates;
        isLoading = false;
      });
    });
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
                  const Text(
                    'Select a Template',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: templates.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(
                            templates[index].name), // Display template names
                        onTap: () {
                          useTemplate(
                              index); // Call useTemplate with the selected index
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
