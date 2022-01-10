import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../constants/constants.dart';
import '../cubit/cubits.dart';
import '../models/note_model.dart';
import '../widgets/widgets.dart';

class NoteScreen extends StatelessWidget {
  final String title;
  final String content;
  final Color color;

  const NoteScreen({
    Key? key,
    this.title = '',
    this.content = '',
    this.color = defaultNoteColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = NotesCubit.of(context);

    return WillPopScope(
      onWillPop: () async {
        final String defaultNoteTime =
            DateFormat().add_jm().format(DateTime.now());
        final String defaultListDate =
            DateFormat().add_yMMMMd().format(DateTime.now());

        if (cubit.isNoteUpdating) {
          cubit.updateNote(
            NoteModel(
              id: cubit.notes[cubit.selectedNote].id,
              title: cubit.titleController.text,
              checked: cubit.checkUncheckNoteTitle,
              content: cubit.contentController.text,
              color: cubit.choosenColor,
              listDate: defaultListDate,
              noteTime: defaultNoteTime,
            ),
          );
        } else {
          cubit.addNote(
            NoteModel(
              title: cubit.titleController.text,
              content: cubit.contentController.text,
              color: cubit.choosenColor,
              listDate: defaultListDate,
              noteTime: defaultNoteTime,
            ),
          );
        }

        cubit.changeEditingNote(editingNote: false);

        return true;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: Column(
            children: [
              const CustomAppBar(),
              BlocConsumer<NotesCubit, NotesStates>(
                listener: (context, state) {},
                builder: (context, state) {
                  return Container(
                    padding: const EdgeInsets.only(right: 5, top: 5),
                    color: cubit.choosenColor.withOpacity(colorOpacity),
                    child: const SizedBox(
                      height: 50,
                      child: NoteDate(),
                    ),
                  );
                },
              ),
              BlocConsumer<NotesCubit, NotesStates>(
                listener: (context, state) {},
                builder: (context, state) {
                  return cubit.editNote
                      ? const EditNoteBody()
                      : const ViewNoteBody();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
