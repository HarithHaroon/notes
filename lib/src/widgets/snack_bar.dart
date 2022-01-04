import 'package:flutter/material.dart';

SnackBar notesSnackBar({
  required String content,
}) {
  return SnackBar(
    backgroundColor: Colors.teal,
    duration: const Duration(seconds: 1),
    content: Text(
      content,
      style: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}
