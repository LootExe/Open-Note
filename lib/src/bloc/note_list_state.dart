part of 'note_list_bloc.dart';

abstract class NoteListState {
  final List<NoteData> notes;

  NoteListState(this.notes) {
    _sortNotesByTime(notes);
  }

  void _sortNotesByTime(List<NoteData> noteList) =>
      noteList.sort((a, b) => b.editTime.compareTo(a.editTime));
}

class NoteListInitial extends NoteListState {
  NoteListInitial(List<NoteData> notes) : super(notes);
}

class NoteListLoadSuccess extends NoteListState {
  NoteListLoadSuccess(List<NoteData> notes) : super(notes);
}

class NoteListUpdateSuccess extends NoteListState {
  NoteListUpdateSuccess(List<NoteData> notes) : super(notes);
}

class NoteListItemDeleteSuccess extends NoteListState {
  NoteListItemDeleteSuccess(List<NoteData> notes) : super(notes);
}

class NoteListExportSuccess extends NoteListState {
  NoteListExportSuccess(List<NoteData> notes) : super(notes);
}

class NoteListExportFailure extends NoteListState {
  NoteListExportFailure(List<NoteData> notes) : super(notes);
}

class NoteListImportSuccess extends NoteListState {
  NoteListImportSuccess(List<NoteData> notes) : super(notes);
}

class NoteListImportFailure extends NoteListState {
  NoteListImportFailure(List<NoteData> notes) : super(notes);
}

class NoteListImportFileStartFailure extends NoteListState {
  NoteListImportFileStartFailure(List<NoteData> notes) : super(notes);
}

class NoteListImportFileLoadSuccess extends NoteListState {
  final List<NoteListFile> files;

  NoteListImportFileLoadSuccess(List<NoteData> notes, this.files)
      : super(notes);
}
