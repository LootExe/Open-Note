import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/note_bloc.dart';
import '../../model/text_data.dart';
import 'delete_dialog.dart';
import 'text_field_sheet.dart';

class TextNoteMenu extends StatelessWidget {
  const TextNoteMenu({
    Key? key,
    required this.data,
  }) : super(key: key);

  final TextData data;

  void _popupValueToAction({
    required BuildContext context,
    required TextMenuComand comand,
  }) async {
    switch (comand) {
      case TextMenuComand.Rename:
        final newName = await TextFieldSheet.show(
          context: context,
          labelText: 'New Title',
          initialText: data.title,
        );

        if (newName != null && newName.isNotEmpty) {
          data.title = newName;
          BlocProvider.of<NoteBloc>(context).add(NoteUpdated());
        }
        break;
      case TextMenuComand.Delete:
        bool canDelete = await DeleteDialog.show(context: context);

        if (canDelete) {
          BlocProvider.of<NoteBloc>(context).add(NoteDeleted());
          Navigator.pop(context);
        }
        break;
      case TextMenuComand.TextClear:
        BlocProvider.of<NoteBloc>(context).add(NoteTextCleared());
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: (context) => <PopupMenuEntry>[
        const PopupMenuItem(
          child: ListTile(
            leading: Icon(Icons.edit),
            title: Text('Rename'),
          ),
          value: TextMenuComand.Rename,
        ),
        const PopupMenuItem(
          child: ListTile(
            leading: Icon(Icons.delete),
            title: Text('Delete'),
          ),
          value: TextMenuComand.Delete,
        ),
        const PopupMenuItem(
          child: ListTile(
            leading: Icon(Icons.cleaning_services),
            title: Text('Clear Text'),
          ),
          value: TextMenuComand.TextClear,
        ),
      ],
      onSelected: (value) => _popupValueToAction(
        context: context,
        comand: value as TextMenuComand,
      ),
    );
  }
}

enum TextMenuComand {
  Rename,
  Delete,
  TextClear,
}
