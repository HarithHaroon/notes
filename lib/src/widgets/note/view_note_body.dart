import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import '../../cubit/cubits.dart';

class ViewNoteBody extends StatelessWidget {
  const ViewNoteBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = NotesCubit.of(context);

    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(5),
        width: double.infinity,
        color: cubit.choosenColor.withOpacity(colorOpacity),
        child: Text(
          cubit.contentController.text,
          style: const TextStyle(
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
