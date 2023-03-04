import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:note_repository/note_repository.dart';

import '../bloc/note_list_bloc.dart';
import '../../note_editor/screen/note_screen.dart';

enum _MenuEntry { text, todo }

class HomeMenu extends StatelessWidget {
  const HomeMenu({super.key});

  Future<void> _onChildTap(BuildContext context, _MenuEntry entry) async {
    final bloc = context.read<NoteListBloc>();
    Note note;

    switch (entry) {
      case _MenuEntry.text:
        note = TextNote();
        break;
      case _MenuEntry.todo:
        note = TodoNote();
        break;
    }

    await NoteScreen.push(context, note);
    bloc.add(const NoteListUpdated());
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final foregroundColor = scheme.onSecondaryContainer;
    final backgroundColor = scheme.secondaryContainer;

    const childLabelStyle = TextStyle(fontSize: 18.0);

    const border = RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16.0)));

    return SpeedDial(
      icon: Icons.add,
      activeIcon: Icons.close,
      foregroundColor: foregroundColor,
      backgroundColor: backgroundColor,
      shape: border,
      spaceBetweenChildren: 20.0,
      childMargin: const EdgeInsets.all(8.0),
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
