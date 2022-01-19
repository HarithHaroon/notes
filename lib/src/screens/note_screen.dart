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

    bool userIsEdiiting() {
      return cubit.editNote;
    }

    bool updatingNote() {
      return cubit.isNoteUpdating;
    }

    String getDefaultDate() {
      return DateFormat().add_yMMMMd().format(DateTime.now());
    }

    String getDefaultTime() {
      return DateFormat().add_jm().format(DateTime.now());
    }

    void updateNote() {
      cubit.updateNote(
        NoteModel(
          id: cubit.notes[cubit.selectedNote].id,
          title: cubit.titleController.text,
          checked: cubit.checkUncheckNoteTitle,
          content: cubit.contentController.text,
          color: cubit.choosenColor,
          listDate: getDefaultDate(),
          noteTime: getDefaultTime(),
        ),
      );
    }

    void addNewNote() {
      cubit.addNote(
        NoteModel(
          title: cubit.titleController.text,
          content: cubit.contentController.text,
          color: cubit.choosenColor,
          listDate: getDefaultDate(),
          noteTime: getDefaultTime(),
        ),
      );
    }

    return WillPopScope(
      onWillPop: () async {
        if (userIsEdiiting()) {
          if (updatingNote()) {
            updateNote();
          } else {
            if (!cubit.isEmptyNote) {
              addNewNote();
            }
          }
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
