import 'package:flutter/material.dart';
import 'package:time_blocking/models/links.dart';
import 'package:url_launcher/url_launcher.dart';

class LinkList extends StatelessWidget {
  const LinkList(
      {super.key,
      required this.links,
      required this.blockIndex,
      required this.removeListItem,
      required this.listIndex});

  final List<Link> links;
  final int blockIndex;
  final Function removeListItem;
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
        // final Link savedListItem = links![i];
        removeListItem(blockIndex, listIndex);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("${links[listIndex].name} link dismissed"),
            // action: SnackBarAction(
            //   // TODO: Make undo snackbad work -> indexing problems
            //   label: 'Undo',
            //   onPressed: () {
            //     setState(() {
            //       links!.insert(i, savedListItem);
            //       updateLinks(blockIndex: index, links: links!);
            //       updateState(link: true);
            //     });
            //   },
            // ),
            duration: const Duration(seconds: 5),
          ),
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
    );
  }
}
