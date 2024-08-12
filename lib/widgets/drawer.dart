import 'package:flutter/material.dart';

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
            title: const Text('Templates'),
            onTap: () {
              // TODO: FEATURE: Add save schedules / templates feature
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
              // TODO: FEATURE: Add Goals
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
