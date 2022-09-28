import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import '../bloc/note_list_bloc.dart';
import '../model/note_data.dart';
import '../model/text_data.dart';
import '../model/todo_data.dart';

import 'note_screen.dart';
import 'settings_screen.dart';
import 'widget/note_list.dart';
import 'widget/text_field_sheet.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Widget _buildActionButtons(BuildContext context) {
    final buttonSize = const SpeedDial().buttonSize;
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;

    final buttonColor = colorScheme.primary;
    final foregroundColor = colorScheme.background;
    final labelColor = colorScheme.brightness == Brightness.dark
        ? theme.highlightColor
        : colorScheme.background;

    return SpeedDial(
      icon: Icons.add,
      backgroundColor: buttonColor,
      foregroundColor: foregroundColor,
      buttonSize: buttonSize,
      children: [
        SpeedDialChild(
          child: const Icon(Icons.rule),
          backgroundColor: buttonColor,
          foregroundColor: foregroundColor,
          labelBackgroundColor: labelColor,
          label: 'Todo',
          labelStyle: const TextStyle(fontSize: 18.0),
          onTap: () => _newNotePressed(context, NoteType.todo),
        ),
        SpeedDialChild(
          child: const Icon(Icons.description_outlined),
          backgroundColor: buttonColor,
          foregroundColor: foregroundColor,
          labelBackgroundColor: labelColor,
          label: 'Text',
          labelStyle: const TextStyle(fontSize: 18.0),
          onTap: () => _newNotePressed(context, NoteType.text),
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

    if (!mounted) {
      return;
    }

    NoteData note;

    switch (type) {
      case NoteType.todo:
        note = TodoData(
          title: noteName,
          editTime: DateTime.now(),
          items: [],
        );
        break;
      case NoteType.text:
        note = TextData(
          title: noteName,
          editTime: DateTime.now(),
          text: '',
        );
        break;
    }

    final bloc = BlocProvider.of<NoteListBloc>(context);

    await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => NoteScreen(data: note),
        ));

    bloc.add(NoteListUpdated());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NoteListBloc, NoteListState>(
      builder: (context, state) => Scaffold(
        appBar: AppBar(
          title: const Text('Note'),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const SettingsScreen(),
                    ));
              },
            )
          ],
        ),
        floatingActionButton: _buildActionButtons(context),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: const NoteList(),
      ),
    );
  }
}
