import 'package:flutter/material.dart';

import '../../cubit/notes_cubit.dart';

class EditNoteTitle extends StatelessWidget {
  const EditNoteTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: screenWidth * 0.75,
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Center(
        child: TextField(
          style: const TextStyle(
            fontSize: 25,
          ),
          onChanged: (String text) {
            NotesCubit.of(context).changeIsEmptyNote(isEmpty: false);
          },
          controller: NotesCubit.of(context).titleController,
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.only(left: 5),
            prefixIcon: Icon(Icons.title),
            border: OutlineInputBorder(borderRadius: BorderRadius.zero),
            hintText: 'Note title',
          ),
        ),
      ),
    );
  }
}
