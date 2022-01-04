import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants/constants.dart';
import '../../cubit/cubits.dart';

class NoteBody extends StatelessWidget {
  const NoteBody({
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
            padding: const EdgeInsets.all(8.0),
            color: cubit.choosenColor.withOpacity(colorOpacity),
            child: TextField(
              style: const TextStyle(
                fontSize: 20,
              ),
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
