import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/cubits.dart';

class ViewNoteTitle extends StatelessWidget {
  const ViewNoteTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.only(left: 5.0),
      child: SizedBox(
        width: screenWidth * 0.75,
        child: BlocConsumer<NotesCubit, NotesStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return Text(
              NotesCubit.of(context).titleController.text,
              style: TextStyle(
                decoration: NotesCubit.of(context).checkUncheckNoteTitle
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
                fontSize: 25,
              ),
            );
          },
        ),
      ),
    );
  }
}
