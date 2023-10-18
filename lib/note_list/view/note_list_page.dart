import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_repository/note_repository.dart';
import 'package:open_note/config/config.dart';
import 'package:open_note/note_editor/view/note_editor_page.dart';
import 'package:open_note/note_list/bloc/note_list_bloc.dart';
import 'package:open_note/note_list/widget/widget.dart';
import 'package:open_note/settings/settings.dart';
import 'package:settings_repository/settings_repository.dart';

class NoteListPage extends StatelessWidget {
  const NoteListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NoteListBloc(repository: context.read<NoteRepository>()),
      child: const NoteListView(),
    );
  }
}

class NoteListView extends StatelessWidget {
  const NoteListView({super.key});

  bool _buildWhen(Settings previous, Settings current) =>
      previous.noteSortMode != current.noteSortMode ||
      previous.noteSortIds != current.noteSortIds;

  Future<void> _onNotePressed(BuildContext context, Note note) async {
    final noteBloc = context.read<NoteListBloc>();

    await Navigator.of(context).push(NoteEditorPage.route(note));

    noteBloc.add(const NoteListChanged());
  }

  void _onNoteDismissed(BuildContext context, String id) =>
      context.read<NoteListBloc>().add(NoteListItemDeleted(id));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HomeAppBar(),
      floatingActionButton: const HomeMenu(),
      body: BlocBuilder<NoteListBloc, NoteListState>(
        builder: (context, noteState) {
          final notes = noteState.notes;

          if (notes.isEmpty) {
            return const EmptyListInfo();
          }

          return BlocBuilder<SettingsCubit, Settings>(
            buildWhen: _buildWhen,
            builder: (_, settings) => NoteList(
              padding: AppDesign.mainContentPadding,
              notes: notes,
              sortMode: settings.noteSortMode,
              sortOrder: settings.noteSortIds,
              onNotePressed: (note) => _onNotePressed(context, note),
              onNoteDismissed: (id) => _onNoteDismissed(context, id),
            ),
          );
        },
      ),
    );
  }
}
