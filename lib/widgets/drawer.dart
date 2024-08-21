import 'package:flutter/material.dart';
import 'package:time_blocking/screens/block_screen.dart';
import 'package:time_blocking/screens/read_only_blocks.dart';
import 'package:time_blocking/screens/template_screen.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: ListTile(
              title: const Text('MENU'),
              trailing: Builder(builder: (context) {
                return IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.close),
                );
              }),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.today),
            title: const Text("Today's schedule"),
            onTap: () {
              ScaffoldMessenger.of(context).clearSnackBars();
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const BlockScreen()),
                (Route<dynamic> route) => false, // Removes all previous routes
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.list),
            title: const Text('Templates'),
            onTap: () {
              ScaffoldMessenger.of(context).clearSnackBars();
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const TemplateScreen()),
                (Route<dynamic> route) => false, // Removes all previous routes
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.done),
            title: const Text('To Do Blocks'),
            onTap: () {
              ScaffoldMessenger.of(context).clearSnackBars();
              Navigator.push(
                context,
                // ReadOnlyBlocks() Without arguments will display To Do blocks
                MaterialPageRoute(builder: (context) => const ReadOnlyBlocks()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.golf_course_sharp),
            title: const Text('Goals'),
            onTap: () {
              // TODO: FEATURE: Add long term Goals
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.account_box),
            title: const Text('Account'),
            onTap: () {
              // TODO: CROSS-PLATFORM: Add user accounts
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {
              // TODO: FEATURE: Add Settings and user preferences
            },
          ),
          ListTile(
            leading: const Icon(Icons.color_lens),
            title: const Text('Theme'),
            onTap: () {
              // TODO: FEATURE: Add themes
            },
          ),
        ],
      ),
    );
  }
}
