import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:settings_view/settings_view.dart';

import '../../../l10n/generated/l10n.dart';
import '../../common/utils.dart';
import '../bloc/settings_bloc.dart';
import '../widget/sort_mode_dialog.dart';
import '../widget/tile_icon.dart';

class SortingSetting extends StatelessWidget {
  const SortingSetting({super.key});

  bool _buildWhen(SettingsState previous, SettingsState current) =>
      previous.settings.noteSortMode != current.settings.noteSortMode;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(
      buildWhen: _buildWhen,
      builder: (context, state) => SettingsTile(
        leading: const TileIcon(icon: Icons.sort_rounded),
        title: Text(S.of(context).settingSortTitle),
        subtitle: Text(Utils.getSortingModeText(state.settings.noteSortMode)),
        onPressed: () => SortModeDialog.show(context),
      ),
    );
  }
}
