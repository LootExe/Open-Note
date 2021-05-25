import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import '../bloc/note_list_bloc.dart';
import '../model/note_data.dart';
import '../model/text_data.dart';
import '../model/todo_data.dart';
import '../repository/notes_repository.dart';

import 'note_screen.dart';
import 'settings_screen.dart';
import 'widget/note_list.dart';
import 'widget/settings_button.dart';
import 'widget/text_field_sheet.dart';

class HomeScreen extends StatelessWidget {
  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text('Note'),
      centerTitle: true,
      actions: <Widget>[
        SettingsButton(routeDestination: SettingsScreen()),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    final buttonSize = SpeedDial().buttonSize;
    final double xPos = (MediaQuery.of(context).size.width - buttonSize) / 2;
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;

    final buttonColor = colorScheme.primary;
    final labelColor = colorScheme.brightness == Brightness.dark
        ? theme.highlightColor
        : colorScheme.background;

    return SpeedDial(
      icon: Icons.add,
      backgroundColor: buttonColor,
      buttonSize: buttonSize,
      marginEnd: xPos,
      children: [
        SpeedDialChild(
          child: const Icon(Icons.rule),
          backgroundColor: buttonColor,
          labelBackgroundColor: labelColor,
          label: 'Todo',
          labelStyle: const TextStyle(fontSize: 18.0),
          onTap: () => _newNotePressed(context, NoteType.Todo),
        ),
        SpeedDialChild(
          child: const Icon(Icons.description_outlined),
          backgroundColor: buttonColor,
          labelBackgroundColor: labelColor,
          label: 'Text',
          labelStyle: const TextStyle(fontSize: 18.0),
          onTap: () => _newNotePressed(context, NoteType.Text),
        ),
      ],
    );
  }

  void _newNotePressed(BuildContext context, NoteType type) async {
    final noteName = await TextFieldSheet.show(
      context: context,
      labelText: 'Note name',
      initialText: 'New Note',
    );

    if (noteName == null || noteName.isEmpty) {
      return;
    }

    NoteData note;

    switch (type) {
      case NoteType.Todo:
        note = TodoData(
          title: noteName,
          editTime: DateTime.now(),
          items: [],
        );
        break;
      case NoteType.Text:
        note = TextData(
          title: noteName,
          editTime: DateTime.now(),
          text: 'Add text here',
        );
        break;
    }

    await Navigator.push(
        context,
        CupertinoPageRoute(
          builder: (_) => NoteScreen(data: note),
        ));

    BlocProvider.of<NoteListBloc>(context).add(NoteListUpdated());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NoteListBloc(
        RepositoryProvider.of<NotesRepository>(context),
      ),
      child: BlocBuilder<NoteListBloc, NoteListState>(
        builder: (context, state) => Scaffold(
          appBar: _buildAppBar(context),
          floatingActionButton: _buildActionButtons(context),
          body: NoteList(),
        ),
      ),
    );
  }
}
