
import 'package:flutter/material.dart';

import '../../cubit/cubits.dart';

class ColorToPick extends StatelessWidget {
  final Color color;
  final double colorDimension;
  final double borderRadius;

  const ColorToPick({
    Key? key,
    required this.color,
    required this.colorDimension,
    this.borderRadius = 50,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.amberAccent,
      onTap: () {
        NotesCubit.of(context).changeColor(color);

        Navigator.pop(context);
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(
            color: Colors.black,
            width: 0.5,
          ),
        ),
        margin: const EdgeInsets.all(5),
        child: Container(
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(
              color: Colors.black,
              width: 0.5,
            ),
          ),
          width: colorDimension,
          height: colorDimension,
        ),
      ),
    );
  }
}
