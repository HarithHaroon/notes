import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../constants/constants.dart';
import '../models/note_model.dart';
import '../remotes/helpers.dart';
import 'cubits.dart';

class NotesCubit extends Cubit<NotesStates> {
  NotesCubit() : super(NotesInitialState());

  static NotesCubit of(context) => BlocProvider.of(context);

  Color choosenColor = defaultNoteColor;

  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  DateTime date = DateTime.now();

  int noteIndex = 0;
  int _selectedNoteIndex = 0;

  bool isNoteUpdating = false;
  bool isNewNote = true;
  bool showDialog = true;
  bool checkUncheckNoteTitle = false;
  bool showMenu = false;
  bool editNote = false;
  bool isEmptyNote = true;

  int get selectedNote => _selectedNoteIndex;

  String get showGridOrList => CacheHelper.getData(key: 'gridOrList');

  void changeIsEmptyNote({required bool isEmpty}) {
    isEmptyNote = isEmpty;
  }

  void changeNewNote({required bool newNote}) {
    isNewNote = newNote;
    emit(ChangeNewNoteBoolState());
  }

  void changeEditingNote({required bool editingNote}) {
    editNote = editingNote;
    emit(EditingNoteState());
  }

  void changeShowMenu(bool change) {
    showMenu = change;

    emit(ChangeShowMenuState());
  }

  void changeShowGrid(String changeView) {
    CacheHelper.putString(key: 'gridOrList', value: changeView);

    emit(ChangeshowGridState());
  }

  void changeNoteScreenContent({
    required String title,
    required String content,
    required Color color,
    required int index,
    required bool update,
    required DateTime newDate,
  }) {
    noteIndex = index;
    titleController.text = title;
    contentController.text = content;
    choosenColor = color;
    isNoteUpdating = update;
    date = newDate;
  }

  void changeSelectedNoteIndex(int index) {
    _selectedNoteIndex = index;
  }

  void changeCheckUncheckNote(bool checked) {
    checkUncheckNoteTitle = checked;
    emit(CheckNoteState());
  }

  void checkUncheckNote(int index) {
    if (_notes.isEmpty) {
      checkUncheckNoteTitle = !checkUncheckNoteTitle;
    } else {
      checkUncheckNoteTitle = !checkUncheckNoteTitle;
      _notes[index].checked = !_notes[index].checked;
    }

    emit(CheckNoteState());
  }

  void changeColor(Color color) {
    choosenColor = color;
    emit(PickColorState());
  }

  void _addNoteToDatabse(NoteModel note) {
    NotesDatabase.instance.addNoteToDatabse(note);
  }

  List<NoteModel> _notes = [];

  List<NoteModel> get notes => _notes;

  Future getNotesFromDatabase() async {
    _notes = await NotesDatabase.instance.getAllNotesFromDatabase();

    emit(GetNotesState());
  }

  Future _updateNoteInDatabase(NoteModel note) async {
    await NotesDatabase.instance.updateNoteInDatabase(note);
    getNotesFromDatabase();
  }

  Future _deleteNoteInDatabase(int id) async {
    await NotesDatabase.instance.deleteNoteInDatabase(id);
  }

  void addNote(NoteModel note) {
    isNoteUpdating = false;
    _addNoteToDatabse(note);

    getNotesFromDatabase();
    emit(GetNotesState());
  }

  void updateNote(NoteModel note) {
    isNoteUpdating = true;

    _updateNoteInDatabase(note);

    emit(UpdateNoteState());
  }

  Future deleteNote(int id) async {
    await _deleteNoteInDatabase(id);

    await getNotesFromDatabase();
  }
}
