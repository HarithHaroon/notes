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
    return BlocConsumer<NotesCubit, NotesStates>(
      listener: (context, state) {},
      builder: (context, state) {
        final cubit = NotesCubit.of(context);

        return WillPopScope(
          onWillPop: () async {
            if (cubit.isNoteUpdating) {
              cubit.updateNote(
                NoteModel(
                  title: cubit.titleController.text,
                  checked: cubit.checkUncheckNoteTitle,
                  content: cubit.contentController.text,
                  color: cubit.choosenColor,
                  date: DateTime.now(),
                ),
                cubit.noteIndex,
              );
            } else {
              cubit.addNote(
                NoteModel(
                  title: cubit.titleController.text,
                  content: cubit.contentController.text,
                  color: cubit.choosenColor,
                  date: DateTime.now(),
                ),
              );
            }

            return true;
          },
          child: Scaffold(
            resizeToAvoidBottomInset: true,
            body: SafeArea(
              child: Column(
                children: [
                  const CustomAppBar(),
                  Container(
                    padding: const EdgeInsets.only(top: 5, right: 5.0),
                    color: cubit.choosenColor.withOpacity(colorOpacity),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          DateFormat('MM/dd/yyyy').format(cubit.date),
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 5),
                        Text(
                          DateFormat().add_jm().format(cubit.date),
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      color: NotesCubit.of(context)
                          .choosenColor
                          .withOpacity(colorOpacity),
                      child: TextField(
                        controller: cubit.contentController,
                        keyboardType: TextInputType.text,
                        maxLines: 99,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),
                    ),
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
