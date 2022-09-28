import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';

import '../../bloc/note_bloc.dart';
import '../../model/note_data.dart';
import '../../model/text_data.dart';
import '../../model/todo_data.dart';
import 'delete_dialog.dart';
import 'text_field_sheet.dart';

class NoteAppBar extends StatefulWidget implements PreferredSizeWidget {
  const NoteAppBar({Key? key, required this.data}) : super(key: key);

  final NoteData data;

  @override
  State<NoteAppBar> createState() => _NoteAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _NoteAppBarState extends State<NoteAppBar> {
  List<Widget> _buildActionItems() {
    List<Widget> list = [];
    list.add(IconButton(
      icon: const Icon(Icons.share_outlined),
      onPressed: () => _onSharePressed(context),
    ));

    list.add(IconButton(
      icon: const Icon(Icons.edit_outlined),
      onPressed: () => _onRenamePressed(context),
    ));

    if (widget.data.type == NoteType.todo) {
      list.add(IconButton(
        icon: const Icon(Icons.clear_outlined),
        onPressed: () => _onClearCompleted(context),
      ));
    }

    list.add(IconButton(
      icon: const Icon(Icons.delete_outline_sharp),
      onPressed: () => _onDeletePressed(context),
    ));

    return list;
  }

  void _onSharePressed(BuildContext context) async {
    String text = '';

    if (widget.data.type == NoteType.todo) {
      // Share todo list
      final items = (widget.data as TodoData).items;

      for (var todo in items) {
        text += '${todo.text}\n';
      }
    } else {
      // Share text note
      text = (widget.data as TextData).text;
    }

    Share.share(text, subject: widget.data.title);
  }

  void _onRenamePressed(BuildContext context) async {
    final bloc = BlocProvider.of<NoteBloc>(context);
    final newName = await TextFieldSheet.show(
      context: context,
      labelText: 'New Title',
      initialText: widget.data.title,
    );

    if (newName != null && newName.isNotEmpty) {
      widget.data.title = newName;
      bloc.add(NoteUpdated());
    }
  }

  void _onClearCompleted(BuildContext context) {
    BlocProvider.of<NoteBloc>(context).add(NoteTodoClearedCompleted());
  }

  void _onDeletePressed(BuildContext context) async {
    final bloc = BlocProvider.of<NoteBloc>(context);
    bool canDelete = await DeleteDialog.show(context: context);

    if (canDelete) {
      bloc.add(NoteDeleted());

      if (mounted) {
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          BlocProvider.of<NoteBloc>(context).add(NoteUpdated());
          Navigator.pop(context);
        },
      ),
      actions: _buildActionItems(),
    );
  }
}
