import 'package:flutter/material.dart';

class NoteModel {
  late String title;
  late String content;
  late Color color;
  late bool checked;
  late DateTime date;

  NoteModel({
    this.title = '',
    this.checked = false,
    required this.content,
    required this.color,
    required this.date,
  });

  late String noteDate;
  late String listDate;
  NoteModel.fromDb(List<Map<String, dynamic>> data) {
    for (var note in data) {
      title = note['title'];
      content = note['content'];
      color = note['color'];
      checked = note['checked'] == 1;
      listDate = note['listDate'];
      noteDate = note['noteDate'];
    }
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'content': content,
      'color': color,
      'checked': checked ? 1 : 0,
      'listDate': listDate,
      'noteDate': noteDate,
    };
  }
}
