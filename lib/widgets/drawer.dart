import 'package:flutter/material.dart';
import 'package:time_blocking/screens/block_screen.dart';
import 'package:time_blocking/screens/template_screen.dart';
import 'package:time_blocking/storage/save_template.dart';

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
            leading: const Icon(Icons.list),
            title: const Text('Today'),
            onTap: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const BlockScreen()),
                (Route<dynamic> route) => false, // Removes all previous routes
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.save),
            title: const Text('Save today as a template'),
            onTap: () {
              // TODO: Add some indication it worked
              saveTemplate();
            },
          ),
          ListTile(
            leading: const Icon(Icons.list),
            title: const Text('Templates'),
            onTap: () {
              // TODO: 2. FEATURE: Creater and display templates screen
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
              // TODO: FEATURE: Add To Do blocks
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
