import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../constants/constants.dart';
import '../cubit/cubits.dart';
import '../widgets/widgets.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double appBarHeight = AppBar().preferredSize.height;
    final isNoteChecked = NotesCubit.of(context).checkUncheckNoteTitle;

    if (isNoteChecked) {
      noteMenuFirstTitle = uncheckNote;
    } else {
      noteMenuFirstTitle = checkNote;
    }

    List<String> choicesNames = [noteMenuFirstTitle, deleteNote];

    Map<String, Widget> choicesIcons = {
      noteMenuFirstTitle: isNoteChecked
          ? const Icon(Icons.check_box_outline_blank_sharp)
          : const Icon(Icons.check_box_sharp),
      deleteNote: const Icon(
        Icons.delete,
        color: iconColor,
      ),
    };

    final List<Widget> options = [
      BlocConsumer<NotesCubit, NotesStates>(
        listener: (context, state) {},
        builder: (context, state) {
          final cubit = NotesCubit.of(context);

          return SimpleDialogOption(
            child: Row(
              children: const [
                Icon(
                  Icons.check,
                  color: iconColor,
                ),
                SizedBox(width: 10),
                Text(
                  'Yes',
                  style: TextStyle(fontSize: 28),
                ),
              ],
            ),
            onPressed: () {
              final int index = cubit.selectedNote;

              cubit.deleteNote(index);
              Navigator.pop(context);
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
                  Icons.clear,
                  color: iconColor,
                ),
                SizedBox(width: 10),
                Text(
                  'No',
                  style: TextStyle(fontSize: 28),
                ),
              ],
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          );
        },
      ),
    ];

    final Map<String, dynamic> routesAndOptions = {
      noteMenuFirstTitle: [
        doAction,
        dialog,
        route,
        NotesCubit.of(context).selectedNote,
      ],
      deleteNote: [
        showdialog,
        RDialog(title: const Text('Delete this note?'), options: options),
        route,
        action,
      ]
    };

    return BlocConsumer<NotesCubit, NotesStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Container(
          color: NotesCubit.of(context).choosenColor.withOpacity(appBarOpacity),
          height: appBarHeight + 3,
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Padding(
              padding: const EdgeInsets.only(left: 2.0),
              child: Row(
                children: [
                  const NoteTitle(),
                  const ColorBox(),
                  Expanded(
                    child: NotesCubit.of(context).showMenu
                        ? Menu(
                            choicesIcons: choicesIcons,
                            choicesNames: choicesNames,
                            routesAndOptions: routesAndOptions,
                          )
                        : Container(),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
