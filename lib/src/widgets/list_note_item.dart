import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/note_model.dart';

class ListNoteItem extends StatelessWidget {
  final NoteModel noteModel;

  const ListNoteItem({Key? key, required this.noteModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const double padding = 3.0;
    const double itemHeight = 50;
    const double itemWidth = 10;

    return Padding(
      padding: const EdgeInsets.only(left: 3, right: 3),
      child: Card(
        elevation: 5,
        child: Row(
          children: [
            Container(
              width: itemWidth,
              height: itemHeight,
              color: noteModel.color,
            ),
            Expanded(
              child: SizedBox(
                width: double.infinity,
                height: itemHeight,
                child: Padding(
                  padding: const EdgeInsets.all(padding),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        noteModel.title,
                        style: TextStyle(
                          decoration: noteModel.checked
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                          decorationThickness: 2,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: Text(
                          DateFormat().add_yMMMMd().format(noteModel.date),
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
