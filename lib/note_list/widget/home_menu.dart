import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:note_repository/note_repository.dart';
import 'package:open_note/note_editor/view/note_editor_page.dart';
import 'package:open_note/note_list/bloc/note_list_bloc.dart';

enum _MenuEntry { text, todo }

class HomeMenu extends StatelessWidget {
  const HomeMenu({super.key});

  Future<void> _onChildTap(BuildContext context, _MenuEntry entry) async {
    final bloc = context.read<NoteListBloc>();
    Note note;

    switch (entry) {
      case _MenuEntry.text:
        note = TextNote();
      case _MenuEntry.todo:
        note = TodoNote();
    }

    await Navigator.of(context).push(NoteEditorPage.route(note));
    bloc.add(const NoteListLoaded());
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final foregroundColor = scheme.onSecondaryContainer;
    final backgroundColor = scheme.secondaryContainer;

    const childLabelStyle = TextStyle(fontSize: 18);

    const border = RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(16)),
    );

    return SpeedDial(
      icon: Icons.add,
      activeIcon: Icons.close,
      foregroundColor: foregroundColor,
      backgroundColor: backgroundColor,
      shape: border,
      spaceBetweenChildren: 20,
      childMargin: const EdgeInsets.all(8),
      childPadding: EdgeInsets.zero,
      children: [
        SpeedDialChild(
          label: 'Todo',
          labelStyle: childLabelStyle,
          shape: border,
          foregroundColor: foregroundColor,
          backgroundColor: backgroundColor,
          onTap: () => _onChildTap(context, _MenuEntry.todo),
          child: const Icon(Icons.rule),
        ),
        SpeedDialChild(
          label: 'Text',
          labelStyle: childLabelStyle,
          shape: border,
          foregroundColor: foregroundColor,
          backgroundColor: backgroundColor,
          onTap: () => _onChildTap(context, _MenuEntry.text),
          child: const Icon(Icons.description_outlined),
        ),
      ],
    );
  }
}
