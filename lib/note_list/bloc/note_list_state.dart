part of 'note_list_bloc.dart';

enum NoteListStatus { initial, loading, success, failure }

final class NoteListState extends Equatable {
  const NoteListState({
    this.status = NoteListStatus.initial,
    this.notes = const [],
  });

  final NoteListStatus status;
  final List<Note> notes;

  NoteListState copyWith({
    NoteListStatus? status,
    List<Note>? notes,
  }) {
    return NoteListState(
      status: status ?? this.status,
      notes: notes ?? this.notes,
    );
  }

  @override
  List<Object?> get props => [status, notes];
}
