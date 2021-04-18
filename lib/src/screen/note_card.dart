import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../model/note_data.dart';
import '../model/text_data.dart';
import '../model/todo_data.dart';

class NoteCard extends StatelessWidget {
  final NoteData _data;
  final Function _onPressed;
  final Function _onDissmissed;

  NoteCard(
      {required NoteData data,
      required Function onPressed,
      required Function onDissmissed})
      : this._data = data,
        this._onPressed = onPressed,
        this._onDissmissed = onDissmissed;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.startToEnd,
      confirmDismiss: (_) => _showDeleteDialog(context),
      onDismissed: (_) => _onDissmissed(),
      background: Container(
        margin: const EdgeInsets.only(top: 10.0, bottom: 2.0),
        color: Colors.red,
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: const Icon(Icons.delete),
        ),
      ),
      child: _buildNoteCard(),
    );
  }

  Card _buildNoteCard() {
    return Card(
      margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      elevation: 4.0,
      child: InkWell(
        onTap: () => _onPressed(),
        child: ListTile(
          leading: Icon(_noteTypeToIcon(_data)),
          title: Text(_data.title),
          subtitle: Text(
              'Last edited: ${DateFormat('hh:mm - dd.MM.yyyy').format(_data.editTime)}'),
        ),
      ),
    );
  }

  IconData _noteTypeToIcon(NoteData note) {
    if (note is TextData) {
      return Icons.notes;
    } else
      return Icons.check_circle_outline_sharp;
  }

  Future<bool?> _showDeleteDialog(BuildContext context) async {
    return await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('Delete Card'),
        content: const Text('Are you sure you want to delete the card?'),
        actions: <Widget>[
          TextButton(
            child: const Text('Yes'),
            onPressed: () => Navigator.of(context).pop(true),
          ),
          TextButton(
            child: const Text('Cancel'),
            onPressed: () => Navigator.of(context).pop(false),
          ),
        ],
      ),
    );
  }
}
