import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_note/common/extension/extension.dart';
import 'package:open_note/common/utils.dart';
import 'package:open_note/config/config.dart';
import 'package:open_note/l10n/generated/l10n.dart';
import 'package:open_note/note_editor/bloc/note_bloc.dart';
import 'package:open_note/note_editor/bloc/scroll_bloc.dart';

class NoteAppBarTitle extends StatelessWidget {
  const NoteAppBarTitle({super.key});

  bool _buildWhen(NoteState previous, NoteState current) =>
      previous.note.editTime != current.note.editTime ||
      previous.note.title != current.note.title;

  String _formatText(DateTime editTime) {
    final dateTime = getDateTime(editTime);

    if (editTime.isToday) {
      return '${S.current.noteAppBarDateToday} - $dateTime';
    } else if (editTime.isYesterday) {
      return '${S.current.noteAppBarDateYesterday} - $dateTime';
    } else {
      return dateTime;
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle.merge(
      style: AppDesign.appBarDateTextStyle,
      child: BlocBuilder<NoteBloc, NoteState>(
        buildWhen: _buildWhen,
        builder: (context, noteState) {
          final title = Text(
            noteState.note.title,
            key: const ValueKey('title'),
          );
          final date = Text(
            _formatText(noteState.note.editTime),
            key: const ValueKey('date'),
          );

          return BlocBuilder<ScrollBloc, ScrollState>(
            builder: (context, scrollState) => AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: scrollState.titleVisible ? date : title,
            ),
          );
        },
      ),
    );
  }
}
