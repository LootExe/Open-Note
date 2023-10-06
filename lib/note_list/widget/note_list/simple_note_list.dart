import 'package:flutter/material.dart';
import 'package:note_repository/note_repository.dart';

import 'package:open_note/note_list/widget/note_card/note_card.dart';

class SimpleNoteList extends StatelessWidget {
  const SimpleNoteList({
    required this.notes,
    super.key,
    this.padding,
    this.onNotePressed,
    this.onNoteDismissed,
  });

  final EdgeInsetsGeometry? padding;
  final List<Note> notes;
  final ValueSetter<Note>? onNotePressed;
  final ValueSetter<String>? onNoteDismissed;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: padding,
      itemCount: notes.length,
      itemBuilder: (context, index) {
        final note = notes[index];

        return NoteCard(
          key: Key(note.id),
          note: note,
          onPressed: () => onNotePressed?.call(note),
          onDismissed: () => onNoteDismissed?.call(note.id),
        );
      },
    );
  }
}
