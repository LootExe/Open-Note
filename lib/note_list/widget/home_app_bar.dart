import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_note/config/config.dart';
import 'package:open_note/l10n/generated/l10n.dart';
import 'package:open_note/note_list/bloc/note_list_bloc.dart';
import 'package:open_note/settings/settings.dart';

class HomeAppBar extends StatefulWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  State<HomeAppBar> createState() => _HomeAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _HomeAppBarState extends State<HomeAppBar> {
  Future<void> _onSettingsPressed(BuildContext context) async {
    final bloc = context.read<NoteListBloc>();

    await Navigator.of(context).push(SettingsPage.route());

    bloc.add(const NoteListLoaded());
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        S.of(context).appTitle,
        style: Theme.of(context).textTheme.displaySmall,
      ),
      titleSpacing: 22,
      actions: [
        Padding(
          padding: AppDesign.appBarActionPadding,
          child: IconButton(
            icon: const Icon(Icons.settings_rounded),
            onPressed: () => _onSettingsPressed(context),
          ),
        ),
      ],
    );
  }
}
