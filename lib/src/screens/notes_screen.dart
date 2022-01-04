import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/cubits.dart';
import '../widgets/widgets.dart';

class NotesScreen extends StatelessWidget {
  NotesScreen({Key? key}) : super(key: key);

  final _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      key: _key,
      drawer: const SafeArea(
        child: Drawer(),
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
              // TODO: ADD image to indicate no notes
              : const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
