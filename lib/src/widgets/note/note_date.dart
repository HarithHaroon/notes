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

    String date;
    String time;

    if (cubit.isNewNote) {
      date = DateFormat().add_yMMMMd().format(DateTime.now());
      time = DateFormat().add_jm().format(DateTime.now());
    } else {
      date = cubit.notes[cubit.selectedNote].listDate!;
      time = cubit.notes[cubit.selectedNote].noteTime;
    }

    return BlocConsumer<NotesCubit, NotesStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              date,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 5),
            Text(
              time,
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
