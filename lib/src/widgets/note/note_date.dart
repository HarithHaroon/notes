import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../cubit/cubits.dart';

class NoteDate extends StatelessWidget {
  const NoteDate({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = NotesCubit.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          DateFormat('MM/dd/yyyy').format(cubit.date),
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(width: 5),
        Text(
          DateFormat().add_jm().format(cubit.date),
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
