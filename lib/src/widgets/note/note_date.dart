import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../cubit/cubits.dart';

class NoteDate extends StatelessWidget {
  const NoteDate({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = NotesCubit.of(context);
    String noteTime;
    String listDate;
    if (cubit.isNewNote) {
      noteTime = DateFormat().add_jm().format(DateTime.now());
      listDate = DateFormat().add_yMMMMd().format(DateTime.now());
    } else {
      noteTime = cubit.notes[cubit.selectedNote].noteTime;
      listDate = cubit.notes[cubit.selectedNote].listDate!;
    }

    return BlocConsumer<NotesCubit, NotesStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              listDate,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 5),
            Text(
              noteTime,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        );
      },
    );
  }
}
