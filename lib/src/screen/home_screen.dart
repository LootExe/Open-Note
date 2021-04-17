import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../repository/notes_repository.dart';
import '../bloc/note_list_bloc.dart';
import '../model/note_data.dart';
import './settings_screen.dart';
import './note_screen.dart';
import './note_card.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      floatingActionButton: _buildActionButton(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: NoteList(),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text('Note'),
      centerTitle: true,
      actions: <Widget>[
        IconButton(
          padding: const EdgeInsets.only(right: 24.0),
          icon: const Icon(Icons.settings),
          onPressed: () => _settingsButtonPressed(context),
        ),
      ],
    );
  }

  FloatingActionButton _buildActionButton(BuildContext context) {
    return FloatingActionButton(
      child: const Icon(Icons.add),
      onPressed: () {
        // TODO: Add new card function
        /* PopupMenuButton(
          child: Center(child: Text('click here')),
          itemBuilder: (context) {
            return List.generate(3, (index) {
              return PopupMenuItem(
                child: Text('button no $index'),
              );
            });
          },
        ); */
      },
    );
  }

  void _settingsButtonPressed(BuildContext context) {
    Navigator.push(
        context,
        CupertinoPageRoute(
          builder: (_) => SettingsScreen(),
        ));
  }
}

class NoteList extends StatefulWidget {
  @override
  _NoteListState createState() => _NoteListState();
}

class _NoteListState extends State<NoteList> {
  late NoteListBloc notesBloc;

  @override
  void initState() {
    super.initState();
    notesBloc = NoteListBloc(RepositoryProvider.of<NotesRepository>(context));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NoteListBloc, NoteListState>(
      bloc: notesBloc,
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
              BlocProvider.of<NoteListBloc>(context)
                ..add(NoteListItemDeleted(state.notes[index]));
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
      ..then((_) => notesBloc.add(NoteListUpdated()));
  }
}
