import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/note_bloc.dart';
import '../../model/todo_data.dart';
import 'delete_dialog.dart';
import 'text_field_sheet.dart';

class TodoNoteMenu extends StatelessWidget {
  const TodoNoteMenu({
    Key? key,
    required this.data,
  }) : super(key: key);

  final TodoData data;

  void _popupValueToAction({
    required BuildContext context,
    required TodoMenuComand comand,
  }) async {
    switch (comand) {
      case TodoMenuComand.Rename:
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
      case TodoMenuComand.Delete:
        bool canDelete = await DeleteDialog.show(context: context);

        if (canDelete) {
          BlocProvider.of<NoteBloc>(context).add(NoteDeleted());
          Navigator.pop(context);
        }
        break;
      case TodoMenuComand.TodoMarkAll:
        BlocProvider.of<NoteBloc>(context).add(NoteTodoAllMarked());
        break;
      case TodoMenuComand.TodoUnmarkAll:
        BlocProvider.of<NoteBloc>(context).add(NoteTodoAllUnmarked());
        break;
      case TodoMenuComand.TodoClearMarked:
        BlocProvider.of<NoteBloc>(context).add(NoteTodoClearedCompleted());
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
          value: TodoMenuComand.Rename,
        ),
        const PopupMenuItem(
          child: ListTile(
            leading: Icon(Icons.delete),
            title: Text('Delete'),
          ),
          value: TodoMenuComand.Delete,
        ),
        const PopupMenuItem(
          child: ListTile(
            leading: Icon(Icons.done_all),
            title: Text('Mark all'),
          ),
          value: TodoMenuComand.TodoMarkAll,
        ),
        const PopupMenuItem(
          child: ListTile(
            leading: Icon(Icons.delete_outline),
            title: Text('Unmark all'),
          ),
          value: TodoMenuComand.TodoUnmarkAll,
        ),
        const PopupMenuItem(
          child: ListTile(
            leading: Icon(Icons.rule),
            title: Text('Clear completed'),
          ),
          value: TodoMenuComand.TodoClearMarked,
        ),
      ],
      onSelected: (value) => _popupValueToAction(
        context: context,
        comand: value as TodoMenuComand,
      ),
    );
  }
}

enum TodoMenuComand {
  Rename,
  Delete,
  TodoMarkAll,
  TodoUnmarkAll,
  TodoClearMarked,
}
