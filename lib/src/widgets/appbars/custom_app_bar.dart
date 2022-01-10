import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants/constants.dart';
import '../../cubit/cubits.dart';
import '../widgets.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double appBarHeight = AppBar().preferredSize.height;
    final isNoteChecked = NotesCubit.of(context).checkUncheckNoteTitle;

    final cubit = NotesCubit.of(context);

    if (isNoteChecked) {
      noteMenuFirstTitle = uncheckNote;
    } else {
      noteMenuFirstTitle = checkNote;
    }

    List<String> choicesNames = [noteMenuFirstTitle, deleteNote];

    final List<SimpleDialogOption> options = [
      SimpleDialogOption(
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
          final index = cubit.selectedNote;
          final notes = cubit.notes;

          cubit.deleteNote(notes[index].id!);

          Navigator.pop(context);
          Navigator.pop(context);
        },
      ),
      SimpleDialogOption(
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
      ),
    ];

    Map<String, Widget> choicesIcons = {
      noteMenuFirstTitle: isNoteChecked
          ? const Icon(Icons.check_box_outline_blank_sharp)
          : const Icon(Icons.check_box_sharp),
      deleteNote: const Icon(
        Icons.delete,
        color: iconColor,
      ),
    };

    final Map<String, List<dynamic>> actions = {
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
          color: cubit.choosenColor.withOpacity(appBarOpacity),
          height: appBarHeight,
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Row(
              children: [
                cubit.editNote ? const EditNoteTitle() : const ViewNoteTitle(),
                const ColorBox(),
                Expanded(
                  child: cubit.showMenu
                      ? Menu(
                          choicesIcons: choicesIcons,
                          choicesNames: choicesNames,
                          actions: actions,
                        )
                      : Container(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
