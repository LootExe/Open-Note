import 'package:equatable/equatable.dart';
import 'package:note_repository/note_repository.dart';

sealed class DateEntry extends Equatable {
  const DateEntry();

  @override
  List<Object?> get props => [];
}

final class PeriodEntry extends DateEntry {
  const PeriodEntry(this.period);

  final String period;

  @override
  List<Object?> get props => [period];
}

final class NoteEntry extends DateEntry {
  const NoteEntry(this.note);

  final Note note;

  @override
  List<Object?> get props => [note];
}
