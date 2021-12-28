import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/notes_cubit.dart';
import '../cubit/notes_states.dart';

class NoteTitle extends StatelessWidget {
  const NoteTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: screenWidth * 0.75,
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: BlocConsumer<NotesCubit, NotesStates>(
        listener: (BuildContext context, state) {},
        builder: (BuildContext context, Object? state) {
          final cubit = NotesCubit.of(context);

          return TextField(
            style: const TextStyle(
              fontSize: 25,
            ),
            onChanged: (String text) {},
            controller: cubit.titleController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(borderRadius: BorderRadius.zero),
            ),
          );
        },
      ),
    );
  }
}
