import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_repository/note_repository.dart';

import '../../config/app_design.dart';
import '../../note_editor/screen/note_screen.dart';
import '../../settings/bloc/settings_bloc.dart';
import '../bloc/note_list_bloc.dart';

import '../widget/empty_list_info.dart';
import '../widget/home_app_bar.dart';
import '../widget/home_menu.dart';
import '../widget/note_list/note_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Future<void> _onNotePressed(BuildContext context, Note note) async {
    final noteBloc = context.read<NoteListBloc>();
    await NoteScreen.push(context, note);
    noteBloc.add(const NoteListUpdated());
  }

  void _onNoteDismissed(BuildContext context, String id) =>
      context.read<NoteListBloc>().add(NoteListItemDeleted(id));

  bool _buildWhen(SettingsState previous, SettingsState current) =>
      previous.settings.noteSortMode != current.settings.noteSortMode ||
      previous.settings.noteSortOrder != current.settings.noteSortOrder;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HomeAppBar(),
      floatingActionButton: const HomeMenu(),
      body: BlocBuilder<NoteListBloc, NoteListState>(
        builder: (context, noteState) =>
            BlocBuilder<SettingsBloc, SettingsState>(
          buildWhen: _buildWhen,
          builder: (context, settingState) {
            final notes = noteState.notes;

            if (notes.isEmpty) {
              return const EmptyListInfo();
            }

            return NoteList(
              padding: AppDesign.mainContentPadding,
              notes: notes,
              sortMode: settingState.settings.noteSortMode,
              sortOrder: settingState.settings.noteSortOrder,
              onNotePressed: (note) => _onNotePressed(context, note),
              onNoteDismissed: (id) => _onNoteDismissed(context, id),
            );
          },
        ),
      ),
    );
  }
}
