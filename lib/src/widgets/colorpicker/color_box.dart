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

    const int _blackPrimaryValue = 0xFF000000;

    const MaterialColor primaryBlack = MaterialColor(
      _blackPrimaryValue,
      <int, Color>{
        50: Color(0xFF000000),
        100: Color(0xFF000000),
        200: Color(0xFF000000),
        300: Color(0xFF000000),
        400: Color(0xFF000000),
        500: Color(_blackPrimaryValue),
        600: Color(0xFF000000),
        700: Color(0xFF000000),
        800: Color(0xFF000000),
        900: Color(0xFF000000),
      },
    );

    final List<Color?> colors = [
      Colors.orange[900],
      Colors.cyan,
      Colors.brown,
      Colors.pinkAccent,
      Colors.lime,
      Colors.purple,
      primaryBlack,
      Colors.grey,
      Colors.amber,
    ];

    final listLenght = colors.length;

    return InkWell(
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
          final cubit = NotesCubit.of(context);

          return cubit.editNote
              ? Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Container(
                    child: const Icon(
                      Icons.color_lens_outlined,
                      color: Colors.white,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.black12),
                      color: cubit.choosenColor,
                    ),
                    width: 35,
                    height: 35,
                  ),
                )
              : IconButton(
                  onPressed: () {
                    cubit.changeEditingNote(editingNote: true);
                  },
                  icon: const Icon(Icons.edit),
                );
        },
      ),
    );
  }
}
