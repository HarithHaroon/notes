import 'package:app/src/widgets/widgets.dart';
import 'package:flutter/material.dart';

class ColorsToPickFrom extends StatelessWidget {
  final double borderRadius;
  const ColorsToPickFrom({
    Key? key,
    required this.containerColor,
    required this.listLenght,
    required this.colors,
    required this.colorDimension,
    this.borderRadius = 0,
  }) : super(key: key);

  final Color? containerColor;
  final int listLenght;
  final List<Color?> colors;
  final double colorDimension;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: containerColor,
      contentPadding: const EdgeInsets.all(10),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius)),
      content: Container(
        width: 260,
        height: 260,
        color: containerColor,
        child: GridView.builder(
          itemCount: listLenght,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
          ),
          itemBuilder: (context, index) {
            return ColorToPick(
              color: colors[index]!,
              colorDimension: colorDimension,
            );
          },
        ),
      ),
    );
  }
}
