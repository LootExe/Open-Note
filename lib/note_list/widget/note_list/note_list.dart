import 'package:flutter/material.dart';
import 'package:note_repository/note_repository.dart';
import 'package:open_note/note_list/util/note_list_sorter.dart';
import 'package:open_note/note_list/widget/note_list/date_separated_note_list.dart';
import 'package:open_note/note_list/widget/note_list/reorderable_note_list.dart';
import 'package:open_note/note_list/widget/note_list/simple_note_list.dart';
import 'package:settings_repository/settings_repository.dart';

class NoteList extends StatelessWidget {
  const NoteList({
    required this.notes,
    required this.sortMode,
    required this.sortOrder,
    required this.onNotePressed,
    required this.onNoteDismissed,
    super.key,
    this.padding,
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
          notes: sortAlphabetical(notes),
          onNotePressed: onNotePressed,
          onNoteDismissed: onNoteDismissed,
        );
      case NoteSortMode.alphabeticalDescending:
        return SimpleNoteList(
          padding: padding,
          notes: sortAlphabetical(notes, ascending: false),
          onNotePressed: onNotePressed,
          onNoteDismissed: onNoteDismissed,
        );
      case NoteSortMode.editDate:
        return DateSeparatedNoteList(
          padding: padding,
          notes: sortEditDate(notes),
          onNotePressed: onNotePressed,
          onNoteDismissed: onNoteDismissed,
        );
      case NoteSortMode.manual:
        return ReorderableNoteList(
          padding: padding,
          notes: sortManual(notes, sortOrder),
          order: sortOrder,
          onNotePressed: onNotePressed,
          onNoteDismissed: onNoteDismissed,
        );
    }
  }
}
