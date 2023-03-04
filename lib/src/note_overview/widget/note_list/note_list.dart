import 'package:flutter/material.dart';
import 'package:note_repository/note_repository.dart';
import 'package:settings_repository/settings_repository.dart';

import '../../util/note_list_sorter.dart';
import 'date_separated_note_list.dart';
import 'reorderable_note_list.dart';
import 'simple_note_list.dart';

class NoteList extends StatelessWidget {
  const NoteList({
    super.key,
    this.padding,
    required this.notes,
    required this.sortMode,
    required this.sortOrder,
    required this.onNotePressed,
    required this.onNoteDismissed,
  });

  final EdgeInsets? padding;
  final List<Note> notes;
  final NoteSortMode sortMode;
  final List<String> sortOrder;
  final ValueSetter<Note> onNotePressed;
  final ValueSetter<String> onNoteDismissed;

  @override
  Widget build(BuildContext context) {
    switch (sortMode) {
      case NoteSortMode.alphabeticalAscending:
        return SimpleNoteList(
          padding: padding,
          notes: NoteListSorter.sortAlphabetical(notes),
          onNotePressed: onNotePressed,
          onNoteDismissed: onNoteDismissed,
        );
      case NoteSortMode.alphabeticalDescending:
        return SimpleNoteList(
          padding: padding,
          notes: NoteListSorter.sortAlphabetical(notes, false),
          onNotePressed: onNotePressed,
          onNoteDismissed: onNoteDismissed,
        );
      case NoteSortMode.editDate:
        return DateSeparatedNoteList(
          padding: padding,
          notes: NoteListSorter.sortEditDate(notes),
          onNotePressed: onNotePressed,
          onNoteDismissed: onNoteDismissed,
        );
      case NoteSortMode.manual:
        return ReorderableNoteList(
          padding: padding,
          notes: NoteListSorter.sortManual(notes, sortOrder),
          order: sortOrder,
          onNotePressed: onNotePressed,
          onNoteDismissed: onNoteDismissed,
        );
    }
  }
}
