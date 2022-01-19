import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants/constants.dart';
import '../../cubit/cubits.dart';

class EditNoteBody extends StatelessWidget {
  const EditNoteBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = NotesCubit.of(context);

    return Expanded(
      child: BlocConsumer<NotesCubit, NotesStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Container(
            padding: const EdgeInsets.only(left: 5.0, right: 5.0),
            color: cubit.choosenColor.withOpacity(colorOpacity),
            child: TextField(
              style: const TextStyle(
                fontSize: 20,
              ),
              onChanged: (String text) {
                NotesCubit.of(context).changeIsEmptyNote(isEmpty: false);
              },
              controller: cubit.contentController,
              keyboardType: TextInputType.text,
              maxLines: 99,
              decoration: const InputDecoration(
                border: InputBorder.none,
              ),
            ),
          );
        },
      ),
    );
  }
}
