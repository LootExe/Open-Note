import 'package:equatable/equatable.dart';
import 'package:note_repository/note_repository.dart';

abstract class DateEntry extends Equatable {
  const DateEntry();
}

class PeriodEntry extends DateEntry {
  final String period;

  @override
  List<Object?> get props => [period];

  const PeriodEntry(this.period);
}

class NoteEntry extends DateEntry {
  final Note note;

  @override
  List<Object?> get props => [note];

  const NoteEntry(this.note);
}
