import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_repository/note_repository.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../../l10n/generated/l10n.dart';
import '../../../bloc/note_bloc.dart';
import '../../../../common/widget/widgets.dart';

import 'note_menu_entry.dart';
import 'note_menu_item.dart';

class NoteMenu extends StatelessWidget {
  const NoteMenu({super.key});

  void _onClear(BuildContext context) =>
      context.read<NoteBloc>().add(const NoteCleared());

  Future<void> _onShare(BuildContext context) async {
    final note = context.read<NoteBloc>().state.note;
    String content = '';

    if (note is TextNote) {
      content = note.content;
    } else if (note is TodoNote) {
      content = note.items.map((i) => i.text).toList().join('\n');
    }

    if (content.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(S.of(context).noteMenuShareMessage)),
      );

      return;
    }

    await Share.share(content);
  }

  Future<void> _onDelete(BuildContext context) async {
    final bloc = context.read<NoteBloc>();
    final navigator = Navigator.of(context);

    bool canDelete = await DeleteDialog.show(context);

    if (canDelete) {
      bloc.add(const NoteDeleted());
      navigator.pop();
    }
  }

  void _onSelected(BuildContext context, NoteMenuEntry value) {
    switch (value) {
      case NoteMenuEntry.clear:
        _onClear(context);
        break;
      case NoteMenuEntry.share:
        _onShare(context);
        break;
      case NoteMenuEntry.delete:
        _onDelete(context);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);

    // TODO: PopupMenu width only increases in steps of 56.0
    //  not by width of childs. Find another way to make it look good
    return PopupMenuButton<NoteMenuEntry>(
      itemBuilder: (context) => [
        PopupMenuItem(
          value: NoteMenuEntry.clear,
          child: NoteMenuItem(
            label: l10n.noteMenuClearLabel,
            icon: Icons.clear_all_rounded,
          ),
        ),
        PopupMenuItem(
          value: NoteMenuEntry.share,
          child: NoteMenuItem(
            label: l10n.noteMenuShareLabel,
            icon: Icons.share_rounded,
          ),
        ),
        PopupMenuItem(
          value: NoteMenuEntry.delete,
          child: NoteMenuItem(
            label: l10n.noteMenuDeleteLabel,
            icon: Icons.delete_outline_rounded,
            iconColor: Theme.of(context).colorScheme.error,
          ),
        ),
      ],
      onSelected: (value) => _onSelected(context, value),
    );
  }
}
