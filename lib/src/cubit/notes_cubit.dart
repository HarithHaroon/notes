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

  List<NoteModel> _cards = [];

  List<NoteModel> get cards => _cards;

  int get selectedNote => _selectedNoteIndex;

  String get showGridOrList => CacheHelper.getData(key: 'gridOrList');
  void changeShowMenu(bool change) {
    showMenu = change;

    emit(ChangeShowMenuState());
  }

  changeShowGrid(String changeView) {
    CacheHelper.putString(key: 'gridOrList', value: changeView);

    emit(ChangeshowGridState());
  }

  void deleteNote(int index) {
    if (_cards.isNotEmpty) {
      _cards.removeAt(index);
    }

    emit(DeleteNoteState());
  }

  void changeNoteScreenContent(
    String title,
    String content,
    Color color,
    int index,
    bool update,
    DateTime newDate,
  ) {
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
  }

  void checkUncheckNote(int index) {
    if (_cards.isEmpty) {
      checkUncheckNoteTitle = !checkUncheckNoteTitle;
    } else {
      checkUncheckNoteTitle = !checkUncheckNoteTitle;
      _cards[index].checked = !_cards[index].checked;
    }

    emit(CheckNoteState());
  }

  void changeColor(Color color) {
    choosenColor = color;
    emit(PickColorState());
  }

  late List<NoteModel> _originalList;

  void addNote(NoteModel note) {
    isNoteUpdating = false;

    if (_cards.isEmpty) {
      _originalList = [];
    } else {
      _originalList = _cards.sublist(0);
    }

    _cards = [note, ..._originalList];

    emit(GetNotesState());
  }

  void updateNote(NoteModel note, int index) {
    isNoteUpdating = true;

    _cards.removeAt(index);

    _cards.insert(0, note);

    emit(UpdateNoteState());
  }
}
