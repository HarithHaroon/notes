import 'package:flutter/material.dart';

class NotesDrawer extends StatelessWidget {
  const NotesDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.teal,
            ),
            child: SizedBox(),
          ),
          ListTile(
            leading: const Icon(
              Icons.text_snippet_sharp,
              color: Colors.black,
            ),
            title: const Text(
              'Notes',
              style: TextStyle(
                fontSize: 22,
              ),
            ),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(
              Icons.delete,
              color: Colors.black,
            ),
            title: const Text(
              'Trash Can',
              style: TextStyle(
                fontSize: 22,
              ),
            ),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
