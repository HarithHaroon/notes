import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../cubit/notes_cubit.dart';
import '../models/note_model.dart';

class NotesDatabase {
  late Database database;

  void createDatabase() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentDirectory.path, 'notes.db');

    openDatabase(
      path,
      version: 1,
      onCreate: (Database database, int version) async {
        //  'CREATE TABLE notes (id INTEGER PRIMARY KEY, title TEXT, time TEXT, content TEXT, checked INTEGER)'
        await database.execute("""
        CREATE TABLE Notes
        (
         id INTEGER PRIMARY KEY, 
         title TEXT, 
         content TEXT,
         color BLOB,
         noteDate TEXT,
         listDate TEXT,
         checked INTEGER
        )
         """);
      },
      onOpen: (database) {
        // getDataFromDatabase(database);
        // emit(GetFromDatabaseState());
      },
    ).then((value) {
      database = value;
      print('databse created');
      // emit(CreateDatabaseState());
    });
  }

  void insertToDatabase({
    required title,
    required content,
    required color,
    required checked,
    required listDate,
    required noteDate,
  }) async {
    print('inserting..');
    await database.transaction((txn) async {
      // INSERT INTO tasks(title, time) VALUES("$title", "$time")
      txn.rawInsert("""
            INSERT INTO Notes
            (title, content, color, checked, listDate, noteDate) 
            VALUES("$title", "$content", "$color", "$checked", "$listDate ", "$noteDate")
          """).then((value) {
        print('inserted $value');
        // NotesCubit().insertToDatabase();
        // getDataFromDatabase(database);
        // emit(GetFromDatabaseState());
      }).catchError((err) {
        print(err.toString());
      });
    });
  }

  void getDataFromDatabase(Database database) {
    database.rawQuery('SELECT * FROM Notes').then((value) {
      final cubit = NotesCubit();

      final note = NoteModel.fromDb(value);
      cubit.setCard = note;

      // newTasks = [];
      // tasks = value;

      cubit.setCard = note;
      // tasks.forEach((task) {
      //   if (task['status'] == null) {
      //     newTasks.add(task);
      //   } else if (task['status'] == 'Done') {
      //     doneTasks.add(task);
      //   } else if (task['status'] == 'Archive') {
      //     archivedTasks.add(task);
      //   }
      // });
      // emit(GetDatabaseLoadingState());
    });
  }
}
