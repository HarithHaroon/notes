import 'package:flutter/material.dart';

import '../models/note_model.dart';

class GridNoteItem extends StatelessWidget {
  final NoteModel noteModel;

  const GridNoteItem({
    Key? key,
    required this.noteModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    final double screenWidth = MediaQuery.of(context).size.width;

    final double cardHeight = screenHeight * 0.22;
    final double cardWidth = screenWidth * 0.33;
    final double containerHeight = cardHeight * 0.86;

    return SizedBox(
      width: cardWidth,
      height: cardHeight,
      child: Card(
        elevation: 5,
        child: Column(
          children: [
            _buildHeader(),
            _buildContent(cardHeight, containerHeight),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      height: 10,
      color: noteModel.color,
    );
  }

  Widget _buildContent(double cardHeight, double containerHeight) {
    return SizedBox(
      width: cardHeight,
      height: containerHeight,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(3.0),
            width: cardHeight,
            child: Text(
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
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(3.0),
              width: cardHeight,
              height: cardHeight,
              child: Text(
                noteModel.content,
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
