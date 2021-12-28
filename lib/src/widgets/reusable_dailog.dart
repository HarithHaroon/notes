import 'package:flutter/material.dart';

class RDialog extends StatelessWidget {
  final Widget title;
  final List<Widget> options;

  const RDialog({
    Key? key,
    required this.title,
    required this.options,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      titlePadding: const EdgeInsets.fromLTRB(10.0, 12.0, 10, 0.0),
      title: title,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      children: options,
    );
  }
}
