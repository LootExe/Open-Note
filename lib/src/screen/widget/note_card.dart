import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../model/note_data.dart';
import 'delete_dialog.dart';

class NoteCard extends StatelessWidget {
  const NoteCard({
    Key? key,
    required this.data,
    required this.onPressed,
    required this.onDissmissed,
  }) : super(key: key);

  final NoteData data;
  final VoidCallback onPressed;
  final VoidCallback onDissmissed;

  IconData _noteTypeToIcon(NoteData note) {
    switch (note.type) {
      case NoteType.Todo:
        return Icons.rule;
      case NoteType.Text:
        return Icons.description_outlined;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.startToEnd,
      confirmDismiss: (_) => DeleteDialog.show(context: context),
      onDismissed: (_) => onDissmissed(),
      background: Container(
        margin: const EdgeInsets.only(top: 10.0, bottom: 2.0),
        color: Colors.red,
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Icon(
            Icons.delete_outline,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
      ),
      child: Card(
        margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 4.0,
        child: InkWell(
          onTap: () => onPressed(),
          child: ListTile(
            leading: Icon(
              _noteTypeToIcon(data),
              color: Theme.of(context).primaryColor,
            ),
            title: Text(data.title),
            subtitle:
                Text(DateFormat('hh:mm - dd.MM.yyyy').format(data.editTime)),
          ),
        ),
      ),
    );
  }
}
