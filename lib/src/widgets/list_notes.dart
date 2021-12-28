import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/notes_cubit.dart';
import '../cubit/notes_states.dart';
import '../screens/screens.dart';
import 'widgets.dart';

class ListNotes extends StatelessWidget {
  const ListNotes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NotesCubit, NotesStates>(
      listener: (context, state) {},
      builder: (context, state) {
        final cubit = NotesCubit.of(context);

        return ListView.builder(
          itemCount: cubit.cards.length,
          itemBuilder: (context, index) {
            final note = cubit.cards[index];

            return InkWell(
              onTap: () {
                cubit.changeShowMenu(true);

                cubit.changeSelectedNoteIndex(index);

                cubit.changeCheckUncheckNote(note.checked);

                cubit.changeNoteScreenContent(
                  note.title,
                  note.content,
                  note.color,
                  index,
                  true,
                  DateTime.now(),
                );

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const NoteScreen(),
                  ),
                );
              },
              child: ListNoteItem(
                noteModel: cubit.cards[index],
              ),
            );
          },
        );
      },
    );
  }
}
