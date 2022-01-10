import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/src/constants/constants.dart';
import 'package:notes/src/screens/screens.dart';

import '../cubit/cubits.dart';
import '../widgets/widgets.dart';

class NotesScreen extends StatelessWidget {
  NotesScreen({Key? key}) : super(key: key);

  final _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    const double fontSize = 28.0;
    final width = MediaQuery.of(context).size.width;

    final cubit = NotesCubit.of(context);

    Widget dialogTitle = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Add Note',
          style: TextStyle(color: Colors.teal),
        ),
        const SizedBox(height: 5),
        Container(
          width: double.infinity,
          color: Colors.teal,
          height: 2,
        ),
      ],
    );

    List<Widget> dialogOptions = [
      SimpleDialogOption(
        child: Row(
          children: const [
            Icon(
              Icons.text_snippet,
              size: 28,
            ),
            SizedBox(width: 10),
            Text(
              'Text',
              style: TextStyle(fontSize: fontSize),
            ),
          ],
        ),
        onPressed: () {
          cubit.changeShowMenu(false);

          cubit.changeNoteScreenContent(
            '',
            '',
            defaultNoteColor,
            0,
            false,
            DateTime.now(),
          );
          Navigator.pop(context);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NoteScreen(
                title: cubit.titleController.text = '',
                content: cubit.contentController.text = '',
                color: cubit.choosenColor = defaultNoteColor,
              ),
            ),
          );
          cubit.changeEditingNote(editingNote: true);
        },
      ),
      SimpleDialogOption(
        child: Row(
          children: const [
            Icon(Icons.fact_check_rounded),
            SizedBox(width: 10),
            Text(
              'Checklist',
              style: TextStyle(fontSize: fontSize),
            ),
          ],
        ),
        onPressed: () {
          Navigator.pop(context);

          ScaffoldMessenger.of(context).showSnackBar(
            notesSnackBar(
              content: 'No Checklists yet!',
            ),
          );
        },
      ),
    ];

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          await showDialog(
            context: context,
            builder: (context) {
              return RDialog(
                title: dialogTitle,
                options: dialogOptions,
              );
            },
          );
        },
      ),
      backgroundColor: Colors.grey[200],
      key: _key,
      drawer: const SafeArea(
        child: NotesDrawer(),
      ),
      appBar: notesScreenAppBar(context, _key),
      body: BlocConsumer<NotesCubit, NotesStates>(
        listener: (context, state) {},
        builder: (context, state) {
          final notes = NotesCubit.of(context).notes;

          return notes.isNotEmpty
              ? NotesCubit.of(context).showGridOrList == 'grid'
                  ? const GridNotes()
                  : const Padding(
                      padding: EdgeInsets.only(top: 3.0),
                      child: ListNotes(),
                    )
              : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(right: 30),
                        width: width / 2,
                        child: Image.asset('assets/images/pencil.png'),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'No saved notes!',
                        style: TextStyle(
                          color: Colors.teal,
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                      ),
                    ],
                  ),
                );
        },
      ),
    );
  }
}
