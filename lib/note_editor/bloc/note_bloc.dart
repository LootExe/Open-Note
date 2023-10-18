import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:note_repository/note_repository.dart';

part 'note_event.dart';
part 'note_state.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  NoteBloc({
    required NoteRepository repository,
    required Note note,
  })  : _repository = repository,
        _originalNote = note.copyWith(),
        _cachedNote = note.copyWith(),
        super(NoteState(note: note)) {
    on<NoteSaved>(_onNoteSaved);
    on<NoteDeleted>(_onNoteDeleted);
    on<NoteCleared>(_onNoteCleared);

    on<NoteTitleChanged>(_onNoteTitleChanged);
    on<NoteTextContentChanged>(_onTextContentChanged);
    on<NoteTodoItemAdded>(_onTodoItemAdded);
    on<NoteTodoItemDeleted>(_onTodoItemDeleted);
    on<NoteTodoItemChanged>(_onTodoItemChanged);
  }

  // TODO(Frank): Try to get rid of _cachedNote.
  // Maybe edit Note members directly and update editTime
  final NoteRepository _repository;
  Note _originalNote;
  Note _cachedNote;

  Future<void> _onNoteSaved(
    NoteSaved event,
    Emitter<NoteState> emit,
  ) async {
    if (_cachedNote == _originalNote) {
      return;
    }

    // TODO(Frank): Remove editTime and save note directly
    _cachedNote = _cachedNote.copyWith(editTime: DateTime.now());
    _originalNote = _cachedNote.copyWith();

    await _repository.writeNote(_cachedNote);
    emit(state.copyWith(note: _cachedNote));
  }

  Future<void> _onNoteDeleted(
    NoteDeleted event,
    Emitter<NoteState> emit,
  ) async {
    await _repository.deleteNote(_cachedNote.id);
  }

  void _onNoteCleared(NoteCleared event, Emitter<NoteState> emit) {
    Note note;

    if (_cachedNote is TextNote) {
      final textNote = _cachedNote as TextNote;
      note = textNote.copyWith(content: '');
    } else {
      final todoNote = _cachedNote as TodoNote;
      final items = List.of(todoNote.items)
        ..removeWhere((item) => item.isChecked);
      note = todoNote.copyWith(items: items);
    }

    _cachedNote = note;
    emit(state.copyWith(note: _cachedNote));
  }

  void _onNoteTitleChanged(NoteTitleChanged event, Emitter<NoteState> emit) {
    _cachedNote = _cachedNote.copyWith(title: event.title);
    emit(state.copyWith(note: _cachedNote));
  }

  void _onTextContentChanged(
    NoteTextContentChanged event,
    Emitter<NoteState> emit,
  ) {
    if (_cachedNote is! TextNote) {
      return;
    }

    final note = _cachedNote as TextNote;
    _cachedNote = note.copyWith(content: event.content);
    emit(state.copyWith(note: _cachedNote));
  }

  void _onTodoItemAdded(NoteTodoItemAdded event, Emitter<NoteState> emit) {
    if (_cachedNote is! TodoNote) {
      return;
    }

    final note = _cachedNote as TodoNote;
    final items = List.of(note.items)..add(event.item);

    _cachedNote = note.copyWith(items: items);
    emit(state.copyWith(note: _cachedNote));
  }

  void _onTodoItemDeleted(NoteTodoItemDeleted event, Emitter<NoteState> emit) {
    if (_cachedNote is! TodoNote) {
      return;
    }

    final note = _cachedNote as TodoNote;
    final items = List.of(note.items)
      ..removeWhere((item) => item.id == event.id);

    _cachedNote = note.copyWith(items: items);
    emit(state.copyWith(note: _cachedNote));
  }

  void _onTodoItemChanged(NoteTodoItemChanged event, Emitter<NoteState> emit) {
    if (_cachedNote is! TodoNote) {
      return;
    }

    final note = _cachedNote as TodoNote;
    final items = List.of(note.items);
    final index = items.indexWhere((item) => item.id == event.item.id);
    items[index] = event.item;

    _cachedNote = note.copyWith(items: items);
    emit(state.copyWith(note: _cachedNote));
  }
}
