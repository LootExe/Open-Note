import 'package:flutter/material.dart';
import 'package:note_repository/note_repository.dart';

import '../../../../l10n/generated/l10n.dart';
import '../../../common/date_time_extension.dart';
import '../../model/date_entry.dart';
import '../note_card/note_card.dart';

import 'date_period_separator.dart';

class DateSeparatedNoteList extends StatelessWidget {
  const DateSeparatedNoteList({
    super.key,
    this.padding,
    required this.notes,
    this.onNotePressed,
    this.onNoteDismissed,
  });

  final EdgeInsetsGeometry? padding;
  final List<Note> notes;
  final ValueSetter<Note>? onNotePressed;
  final ValueSetter<String>? onNoteDismissed;

  List<DateEntry> _generateDateSeparatedList(List<Note> notes) {
    final List<DateEntry> entries = [];

    void addEntries(PeriodEntry period, Note note) {
      if (!entries.contains(period)) {
        entries.add(period);
      }

      entries.add(NoteEntry(note));
    }

    final l10n = S.current;
    final periodToday = PeriodEntry(l10n.dateSeparatedListTodaySeparator);
    final periodYesterday =
        PeriodEntry(l10n.dateSeparatedListYesterdaySeparator);
    final periodPast30Days = PeriodEntry(l10n.dateSeparatedList30DaysSeparator);

    for (final note in notes) {
      if (note.editTime.isToday) {
        // Add all entries with an editTime of today.
        addEntries(periodToday, note);
      } else if (note.editTime.isYesterday) {
        // Add all entries with an editTime of yesterday.
        addEntries(periodYesterday, note);
      } else if (note.editTime.isPast30Days) {
        // Add all entries with an editTime of past 30 days.
        addEntries(periodPast30Days, note);
      } else {
        // Add all entries per specific year.
        addEntries(PeriodEntry(note.editTime.year.toString()), note);
      }
    }

    return entries;
  }

  @override
  Widget build(BuildContext context) {
    final entries = _generateDateSeparatedList(notes);

    return ListView.builder(
      padding: padding,
      itemCount: entries.length,
      itemBuilder: (context, index) {
        final entry = entries[index];

        if (entry is PeriodEntry) {
          return DatePeriodSeparator(date: entry.period);
        } else if (entry is NoteEntry) {
          final note = entry.note;

          return NoteCard(
            key: Key(note.id),
            note: note,
            onPressed: () => onNotePressed?.call(note),
            onDismissed: () => onNoteDismissed?.call(note.id),
          );
        } else {
          return null;
        }
      },
    );
  }
}
