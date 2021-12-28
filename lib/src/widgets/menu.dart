import 'package:flutter/material.dart';

import '../constants/constants.dart';
import '../cubit/notes_cubit.dart';

class Menu extends StatelessWidget {
  final List<String> choicesNames;
  final Map<String, Widget> choicesIcons;
  final Map<String, dynamic> routesAndOptions;

  const Menu({
    Key? key,
    required this.choicesNames,
    required this.choicesIcons,
    required this.routesAndOptions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<PopupMenuEntry<String>> _popUpMenuItems =
        choicesNames.map((String value) {
      return PopupMenuItem<String>(
        padding: const EdgeInsets.all(0),
        value: value,
        child: Padding(
          padding: const EdgeInsets.only(left: 5.0),
          child: Row(
            children: [
              choicesIcons[value]!,
              const SizedBox(width: 5),
              Text(value),
            ],
          ),
        ),
      );
    }).toList();

    return PopupMenuButton<String>(
      offset: const Offset(0, 55),
      onSelected: (String choice) {
        if (routesAndOptions[choice][0] == showdialog) {
          showDialog(
            context: context,
            builder: (context) => routesAndOptions[choice][dialog],
          );
        } else if (routesAndOptions[choice][0] == goToRoute) {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => routesAndOptions[choice][route]),
          );
        } else if (routesAndOptions[choice][0] == doAction) {
          NotesCubit.of(context)
              .checkUncheckNote(routesAndOptions[choice][action]);
        }
      },
      itemBuilder: (BuildContext context) {
        return _popUpMenuItems;
      },
    );
  }
}
