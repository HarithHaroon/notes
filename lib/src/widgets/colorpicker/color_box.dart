import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/cubits.dart';
import '../widgets.dart';

class ColorBox extends StatelessWidget {
  final Color? color;

  const ColorBox({Key? key, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const double colorDimension = 50;

    final List<Color?> colors = [
      Colors.orange[900],
      Colors.cyan,
      Colors.brown,
      Colors.pinkAccent,
      Colors.lime,
      Colors.purple,
      Colors.black,
      Colors.grey,
      Colors.amber,
    ];

    final listLenght = colors.length;

    return Container(
      margin: const EdgeInsets.only(left: 10.0),
      child: InkWell(
        onTap: () {
          showDialog(
            context: context,
            builder: (context) {
              return ColorsToPickFrom(
                containerColor: Colors.grey[200],
                listLenght: listLenght,
                colors: colors,
                colorDimension: colorDimension,
                borderRadius: 5,
              );
            },
          );
        },
        child: BlocConsumer<NotesCubit, NotesStates>(
          listener: (BuildContext context, state) {},
          builder: (BuildContext context, state) {
            return Container(
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.black12),
                color: NotesCubit.of(context).choosenColor,
              ),
              width: 35,
              height: 35,
            );
          },
        ),
      ),
    );
  }
}
