import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/cubits.dart';
import '../screens/screens.dart';
import 'widgets.dart';

class GridNotes extends StatelessWidget {
  const GridNotes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double cardHeight = screenHeight * 0.22;

    return BlocConsumer<NotesCubit, NotesStates>(
      listener: (context, state) {},
      builder: (context, state) {
        final cubit = NotesCubit.of(context);

        return Padding(
          padding: const EdgeInsets.all(2.0),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisExtent: cardHeight,
            ),
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
                child: GridNoteItem(noteModel: cubit.cards[index]),
              );
            },
          ),
        );
      },
    );
  }
}
