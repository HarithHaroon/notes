import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/note_model.dart';

class NotesDatabase {
  static final NotesDatabase instance = NotesDatabase._init();

  static Database? _database;

  NotesDatabase._init();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initDb('notes.db');
    return _database!;
  }

  Future<Database> _initDb(String filePath) async {
    String dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDb,
    );
  }

  Future _createDb(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $tableNotes
          (
            id INTEGER PRIMARY KEY AUTOINCREMENT, 
            ${NoteFields.title} TEXT, 
            ${NoteFields.content} TEXT,
            ${NoteFields.color} TEXT,
            ${NoteFields.noteDate} TEXT,
            ${NoteFields.listDate} TEXT,
            ${NoteFields.checked} INTEGER         
          )
        ''');
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }

  void addNoteToDatabse(NoteModel note) async {
    final db = await instance.database;
    db.insert('Notes', note.toMap());
  }

  Future<NoteModel?> getNoteFromDatabase(int id) async {
    final db = await instance.database;
    final maps = await db.query(
      tableNotes,
      columns: NoteFields.values,
      where: '${NoteFields.id} =?',
      whereArgs: [id + 1],
    );
    if (maps.isNotEmpty) {
      return NoteModel.fromDb(maps.first);
    } else {
      return null;
    }
  }

  Future<List<NoteModel>> getAllNotesFromDatabase() async {
    final db = await instance.database;
    final result = await db.query(tableNotes);

    return result.map((note) {
      return NoteModel.fromDb(note);
    }).toList();
  }

  Future<int> updateNoteInDatabase(NoteModel note) async {
    final db = await instance.database;
    return db.update(
      tableNotes,
      note.toMap(),
      where: '${NoteFields.id} =?',
      whereArgs: [note.id],
    );
  }

  Future<int> deleteNoteInDatabase(int id) async {
    final db = await instance.database;

    return await db.delete(
      tableNotes,
      where: '${NoteFields.id} =?',
      whereArgs: [id],
    );
  }
}

const String tableNotes = 'Notes';

class NoteFields {
  static final List<String> values = [
    title,
    content,
    color,
    noteDate,
    listDate,
    checked,
  ];
  static const String id = 'id';
  static const String title = 'title';
  static const String content = 'content';
  static const String color = 'color';
  static const String noteDate = 'noteDate';
  static const String listDate = 'listDate';
  static const String checked = 'checked';
}
