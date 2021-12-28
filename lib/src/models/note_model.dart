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
}
