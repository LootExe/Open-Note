import 'package:flutter/material.dart';
import 'package:note_repository/note_repository.dart';

import '../../../common/widget/widgets.dart';
import 'card_content.dart';
import 'card_delete_background.dart';

class NoteCard extends StatelessWidget {
  const NoteCard({
    super.key,
    required this.note,
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
        margin: const EdgeInsets.symmetric(vertical: 6.0),
        elevation: elevation,
        child: InkWell(
          onTap: onPressed,
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 24.0,
              vertical: 16.0,
            ),
            child: CardContent(note: note),
          ),
        ),
      ),
    );
  }
}
