import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../constants/constants.dart';
import '../cubit/notes_cubit.dart';
import '../cubit/notes_states.dart';
import '../screens/screens.dart';
import 'widgets.dart';

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
    BlocConsumer<NotesCubit, NotesStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return SimpleDialogOption(
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
        );
      },
    ),
    BlocConsumer<NotesCubit, NotesStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return SimpleDialogOption(
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
        );
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

  Widget dialogTitle = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text(
        'Add Note',
        style: TextStyle(color: Colors.teal),
      ),
      const SizedBox(height: 5),
      Container(
        width: double.infinity,
        color: Colors.teal,
        height: 2,
      ),
    ],
  );

  List<Widget> dialogOptions = [
    BlocConsumer<NotesCubit, NotesStates>(
        listener: (context, state) {},
        builder: (context, state) {
          final cubit = NotesCubit.of(context);

          return SimpleDialogOption(
            child: Row(
              children: const [
                Icon(
                  Icons.text_snippet,
                  size: 28,
                ),
                SizedBox(width: 10),
                Text(
                  'Text',
                  style: TextStyle(fontSize: 28),
                ),
              ],
            ),
            onPressed: () {
              cubit.changeShowMenu(false);

              cubit.changeNoteScreenContent(
                '',
                '',
                defaultNoteColor,
                0,
                false,
                DateTime.now(),
              );
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NoteScreen(
                    title: cubit.titleController.text = '',
                    content: cubit.contentController.text = '',
                    color: cubit.choosenColor = defaultNoteColor,
                  ),
                ),
              );
            },
          );
        }),
    SimpleDialogOption(
      child: Row(
        children: const [
          Icon(Icons.fact_check_rounded),
          SizedBox(width: 10),
          Text(
            'Checklist',
            style: TextStyle(fontSize: 28),
          ),
        ],
      ),
    ),
  ];

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
      IconButton(
        onPressed: () async {
          await showDialog(
            context: context,
            builder: (context) {
              return RDialog(
                title: dialogTitle,
                options: dialogOptions,
              );
            },
          );
        },
        icon: const Icon(Icons.add_circle),
      ),
      Menu(
        choicesIcons: choicesIcons,
        choicesNames: choicesNames,
        routesAndOptions: routesAndOptions,
      ),
    ],
  );
}
