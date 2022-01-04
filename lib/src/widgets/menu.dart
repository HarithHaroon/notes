import 'package:flutter/material.dart';

import '../constants/constants.dart';
import '../cubit/notes_cubit.dart';

class Menu extends StatelessWidget {
  final List<String> choicesNames;
  final Map<String, Widget>? choicesIcons;
  final Map<String, dynamic> actions;

  const Menu({
    Key? key,
    required this.choicesNames,
    this.choicesIcons,
    required this.actions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<PopupMenuEntry<String>> _popUpMenuItems =
        choicesNames.map((String choiceName) {
      return PopupMenuItem<String>(
        padding: const EdgeInsets.all(0),
        value: choiceName,
        child: Padding(
          padding: const EdgeInsets.only(left: 5.0),
          child: Row(
            children: [
              choicesIcons == null
                  ? const SizedBox()
                  : choicesIcons![choiceName]!,
              const SizedBox(width: 5),
              Text(choiceName),
            ],
          ),
        ),
      );
    }).toList();

    return PopupMenuButton<String>(
      offset: const Offset(0, 55),
      onSelected: (String choiceName) {
        if (menuAction(choiceName) == showdialog) {
          showDialog(
            context: context,
            builder: (context) => actions[choiceName][dialog],
          );
        } else if (menuAction(choiceName) == goToRoute) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => actions[choiceName][route]),
          );
        } else if (menuAction(choiceName) == doAction) {
          NotesCubit.of(context).checkUncheckNote(actions[choiceName][action]);
        }
      },
      itemBuilder: (BuildContext context) {
        return _popUpMenuItems;
      },
    );
  }

  String menuAction(String choiceName) {
    if (actions[choiceName][0] == showdialog) {
      return showdialog;
    } else if (actions[choiceName][0] == goToRoute) {
      return goToRoute;
    } else {
      return doAction;
    }
  }
}
