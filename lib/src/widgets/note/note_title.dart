import 'package:flutter/material.dart';

import '../../cubit/notes_cubit.dart';

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
      child: TextField(
        style: const TextStyle(
          fontSize: 25,
        ),
        onChanged: (String text) {},
        controller: NotesCubit.of(context).titleController,
        decoration: const InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.zero),
        ),
      ),
    );
  }
}
