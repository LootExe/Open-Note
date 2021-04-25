import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../repository/notes_repository.dart';
import '../bloc/note_list_bloc.dart';
import '../model/note_data.dart';
import './note_card.dart';
import './note_screen.dart';

class NoteList extends StatefulWidget {
  @override
  _NoteListState createState() => _NoteListState();
}

class _NoteListState extends State<NoteList> {
  late NoteListBloc _notesBloc;

  @override
  void initState() {
    super.initState();
    _notesBloc = NoteListBloc(RepositoryProvider.of<NotesRepository>(context));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NoteListBloc, NoteListState>(
      bloc: _notesBloc,
      builder: (context, state) {
        return ListView.builder(
          padding: const EdgeInsets.only(top: 12.0),
          itemCount: state.notes.length,
          itemBuilder: (context, index) => NoteCard(
            data: state.notes[index],
            onPressed: () {
              _noteCardPressed(state.notes[index]);
            },
            onDissmissed: () {
              _notesBloc.add(NoteListItemDeleted(state.notes[index]));
            },
          ),
        );
      },
    );
  }

  void _noteCardPressed(NoteData note) {
    Navigator.push(
        context,
        CupertinoPageRoute(
          builder: (_) => NoteScreen(note),
        ))
      ..then((_) => _notesBloc.add(NoteListUpdated()));
  }
}
