import 'package:flutter/material.dart';
import 'package:note_repository/note_repository.dart';

import 'package:open_note/note_list/widget/note_card/card_date.dart';
import 'package:open_note/note_list/widget/note_card/card_preview.dart';
import 'package:open_note/note_list/widget/note_card/card_title.dart';

class CardContent extends StatelessWidget {
  const CardContent({
    required this.note,
    super.key,
  });

  final Note note;

  IconData _getNoteIcon(Note note) {
    if (note is TextNote) {
      return Icons.description_outlined;
    } else if (note is TodoNote) {
      return Icons.rule;
    } else {
      return Icons.question_mark;
    }
  }

  @override
  Widget build(BuildContext context) {
    final cardIcon = _getNoteIcon(note);
    final cardTitle = note.title;
    final cardDate = note.editTime;
    final cardPreview = note.toString();

    return Row(
      children: [
        Center(child: Icon(cardIcon)),
        const SizedBox(width: 20),
        Flexible(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CardTitle(title: cardTitle),
              Row(
                children: [
                  CardDate(dateTime: cardDate),
                  const SizedBox(width: 8),
                  Flexible(
                    child: CardPreview(content: cardPreview),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
