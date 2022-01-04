import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/cubits.dart';

class ColorBox extends StatelessWidget {
  final Color? color;

  const ColorBox({Key? key, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const double colorDimension = 50;

    final List<Map<String, dynamic>> colorContainer = [
      {
        'box': Container(
          width: colorDimension,
          height: colorDimension,
          color: Colors.orange[900],
        ),
        'color': Colors.orange[900],
      },
      {
        'box': Container(
          width: colorDimension,
          height: colorDimension,
          color: Colors.cyan,
        ),
        'color': Colors.cyan,
      },
      {
        'box': Container(
          width: colorDimension,
          height: colorDimension,
          color: Colors.brown,
        ),
        'color': Colors.brown,
      },
      {
        'box': Container(
          width: colorDimension,
          height: colorDimension,
          color: Colors.pinkAccent,
        ),
        'color': Colors.pinkAccent,
      },
      {
        'box': Container(
          width: colorDimension,
          height: colorDimension,
          color: Colors.lime,
        ),
        'color': Colors.lime,
      },
      {
        'box': Container(
          width: colorDimension,
          height: colorDimension,
          color: Colors.purple,
        ),
        'color': Colors.purple,
      },
      {
        'box': Container(
          width: colorDimension,
          height: colorDimension,
          color: Colors.black,
        ),
        'color': Colors.black,
      },
      {
        'box': Container(
          width: colorDimension,
          height: colorDimension,
          color: Colors.grey,
        ),
        'color': Colors.grey,
      },
      {
        'box': Container(
          width: colorDimension,
          height: colorDimension,
          color: Colors.amber,
        ),
        'color': Colors.amber,
      },
    ];

    final listLenght = colorContainer.length;
    final Color? containerColor = Colors.grey[200];

    return Container(
      margin: const EdgeInsets.only(left: 10.0),
      child: InkWell(
        onTap: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                backgroundColor: containerColor,
                contentPadding: const EdgeInsets.all(10),
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero),
                content: Container(
                  width: 260,
                  height: 260,
                  color: containerColor,
                  child: GridView.builder(
                    itemCount: listLenght,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3),
                    itemBuilder: (context, index) {
                      return BlocConsumer<NotesCubit, NotesStates>(
                        listener: (context, state) {},
                        builder: (context, state) {
                          return InkWell(
                            splashColor: Colors.amberAccent,
                            onTap: () {
                              NotesCubit.of(context)
                                  .changeColor(colorContainer[index]['color']);

                              Navigator.pop(context);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.black,
                                  width: 0.5,
                                ),
                              ),
                              margin: const EdgeInsets.all(5),
                              child: colorContainer[index]['box'],
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
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
