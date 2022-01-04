import 'package:flutter/material.dart';

class NoteModel {
  int? id;
  late String title;
  late String content;
  late Color color;
  late String colorString;
  late bool checked;
  DateTime date = DateTime.now();
  late String listDate;
  late String noteDate;

  NoteModel({
    this.title = '',
    this.checked = false,
    this.id,
    required this.content,
    required this.color,
    required this.date,
    required this.listDate,
    required this.noteDate,
  });

  String colorToHex(Color color) {
    final hexColor = color.value.toRadixString(16);
    return hexColor;
  }

  Color hexToColor(String hexColor) {
    final color = HexColor(hexColor);
    return color;
  }

  NoteModel.fromDb(Map<String, dynamic> note) {
    note.forEach((key, value) {
      id = note['id'];
      title = note['title'];
      content = note['content'];
      color = hexToColor(note['color']);
      checked = note['checked'] == 1;
      listDate = note['listDate'];
      noteDate = note['noteDate'];
    });
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'content': content,
      'color': colorToHex(color),
      'checked': checked ? 1 : 0,
      'listDate': listDate,
      'noteDate': noteDate,
    };
  }
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}
