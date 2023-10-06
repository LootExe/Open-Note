import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_note/common/utils.dart';
import 'package:open_note/l10n/generated/l10n.dart';
import 'package:open_note/settings/bloc/settings_bloc.dart';
import 'package:open_note/settings/widget/widget.dart';

class SortingSetting extends StatelessWidget {
  const SortingSetting({super.key});

  bool _buildWhen(SettingsState previous, SettingsState current) =>
      previous.settings.noteSortMode != current.settings.noteSortMode;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(
      buildWhen: _buildWhen,
      builder: (context, state) => ListTile(
        leading: const TileIcon(icon: Icons.sort_rounded),
        title: Text(S.of(context).settingSortTitle),
        subtitle: Text(getSortingModeText(state.settings.noteSortMode)),
        onTap: () => SortModeDialog.show(context),
      ),
    );
  }
}
