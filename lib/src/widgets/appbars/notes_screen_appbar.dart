import 'package:flutter/material.dart';

import '../../constants/constants.dart';
import '../../cubit/notes_cubit.dart';
import '../../screens/screens.dart';
import '../widgets.dart';

PreferredSizeWidget notesScreenAppBar(
    BuildContext context, GlobalKey<ScaffoldState> key) {
  final double appBarHeight = AppBar().preferredSize.height;
  final double screenWidth = MediaQuery.of(context).size.width;

  List<String> choicesNames = const [view, settings];

  Map<String, Widget> choicesIcons = const {
    view: Icon(
      Icons.grid_on_sharp,
      color: iconColor,
    ),
    settings: Icon(
      Icons.settings,
      color: iconColor,
    ),
  };

  List<Widget> options = [
    SimpleDialogOption(
      child: Row(
        children: const [
          Icon(
            Icons.list_alt,
            color: iconColor,
          ),
          SizedBox(width: 10),
          Text(
            'List',
            style: TextStyle(fontSize: 28),
          ),
        ],
      ),
      onPressed: () {
        NotesCubit.of(context).changeShowGrid('list');
        Navigator.pop(context);
      },
    ),
    SimpleDialogOption(
      child: Row(
        children: const [
          Icon(
            Icons.grid_on_sharp,
            color: iconColor,
          ),
          SizedBox(width: 10),
          Text(
            'Grid',
            style: TextStyle(fontSize: 28),
          ),
        ],
      ),
      onPressed: () {
        NotesCubit.of(context).changeShowGrid('grid');
        Navigator.pop(context);
      },
    ),
  ];

  Map<String, dynamic> routesAndOptions = {
    view: [
      showdialog,
      RDialog(title: const Text('View'), options: options),
      route,
      action,
    ],
    settings: [
      goToRoute,
      dialog,
      const SettingsScreen(),
      action,
    ],
  };

  return AppBar(
    elevation: 0.0,
    leadingWidth: screenWidth * 0.8,
    leading: InkWell(
      onTap: () {
        key.currentState!.openDrawer();
      },
      splashColor: Colors.black12,
      child: SizedBox(
        width: 200,
        height: appBarHeight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: const [
            Icon(Icons.menu),
            Text(
              'Notes',
              style: TextStyle(
                fontSize: 22,
              ),
            ),
          ],
        ),
      ),
    ),
    actions: [
      Menu(
        choicesIcons: choicesIcons,
        choicesNames: choicesNames,
        actions: routesAndOptions,
      ),
    ],
  );
}
