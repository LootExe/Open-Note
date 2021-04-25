import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import '../model/note_data.dart';
import '../model/text_data.dart';
import '../model/todo_data.dart';
import './settings_screen.dart';
import './note_screen.dart';
import './note_list.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      floatingActionButton: _buildActionButton(context),
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

  Widget _buildActionButton(BuildContext context) {
    final buttonSize = SpeedDial().buttonSize;
    final double xPos = (MediaQuery.of(context).size.width - buttonSize) / 2;
    final buttonColor = Theme.of(context).accentColor;

    return SpeedDial(
      icon: Icons.add,
      backgroundColor: buttonColor,
      buttonSize: buttonSize,
      marginEnd: xPos,
      overlayColor: Theme.of(context).colorScheme.surface,
      children: [
        SpeedDialChild(
          child: const Icon(Icons.check_circle_outline_sharp),
          backgroundColor: buttonColor,
          label: 'Todo Note',
          labelStyle: const TextStyle(fontSize: 18.0, color: Colors.black),
          onTap: () => _newNotePressed(context, NoteType.Todo),
        ),
        SpeedDialChild(
          child: const Icon(Icons.notes),
          backgroundColor: buttonColor,
          label: 'Text Note',
          labelStyle: const TextStyle(fontSize: 18.0, color: Colors.black),
          onTap: () => _newNotePressed(context, NoteType.Text),
        ),
      ],
    );
  }

  void _settingsButtonPressed(BuildContext context) {
    Navigator.push(
        context,
        CupertinoPageRoute(
          builder: (_) => SettingsScreen(),
        ));
  }

  void _newNotePressed(BuildContext context, NoteType type) {
    NoteData note;

    switch (type) {
      case NoteType.Todo:
        note = TodoData(title: 'New Note', editTime: DateTime.now(), items: []);
        break;
      case NoteType.Text:
        note = TextData(title: 'New Note', editTime: DateTime.now(), text: '');
        break;
    }

    Navigator.push(
        context,
        CupertinoPageRoute(
          builder: (_) => NoteScreen(note),
        ))
      ..then((_) => setState(() => {}));
  }
}
