import 'package:flutter/material.dart';
import 'package:note_repository/note_repository.dart';
import 'package:open_note/common/widget/widget.dart';
import 'package:open_note/note_list/widget/note_card/card_content.dart';
import 'package:open_note/note_list/widget/note_card/card_delete_background.dart';

class NoteCard extends StatelessWidget {
  const NoteCard({
    required this.note,
    super.key,
    this.elevation,
    this.onPressed,
    this.onDismissed,
  });

  final Note note;
  final double? elevation;
  final VoidCallback? onPressed;
  final VoidCallback? onDismissed;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.startToEnd,
      confirmDismiss: (_) => DeleteDialog.show(context),
      onDismissed: (_) => onDismissed?.call(),
      background: const CardDeleteBackground(),
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 6),
        elevation: elevation,
        child: InkWell(
          onTap: onPressed,
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 16,
            ),
            child: CardContent(note: note),
          ),
        ),
      ),
    );
  }
}
