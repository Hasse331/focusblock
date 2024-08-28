import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:time_blocking/models/links.dart';
import 'package:url_launcher/url_launcher.dart';

class LinkList extends StatelessWidget {
  const LinkList(
      {super.key,
      required this.links,
      required this.blockIndex,
      required this.removeListItem,
      required this.listIndex,
      required this.undoRemove});

  final List<Link> links;
  final int blockIndex;
  final Function removeListItem;
  final Function undoRemove;
  final int listIndex;

  Future<void> _launchUrl(uri) async {
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $uri');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      onDismissed: (direction) {
        final removedItem = links[listIndex];
        removeListItem(blockIndex, listIndex);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("${links[listIndex].name} dismissed"),
            action: SnackBarAction(
              label: 'Undo',
              onPressed: () {
                undoRemove(listIndex, removedItem);
              },
            ),
            duration: const Duration(seconds: 3),
          ),
        );
      },
      child: GestureDetector(
        onLongPress: () {
          // Copy the link to the clipboard when the ListTile is long-pressed
          Clipboard.setData(
              ClipboardData(text: links[listIndex].link.toString()));
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Link copied to clipboard!')),
          );
        },
        child: ListTile(
          contentPadding: EdgeInsets.zero,
          trailing: IconButton(
            onPressed: () async {
              _launchUrl(links[listIndex].link);
            },
            icon: const Icon(Icons.open_in_new),
          ),
          title: Align(
            alignment: Alignment.centerLeft,
            child: TextButton(
              child: Text(links[listIndex].name),
              onPressed: () async {
                _launchUrl(links[listIndex].link);
              },
            ),
          ),
        ),
      ),
    );
  }
}
