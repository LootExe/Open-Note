import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_note/common/utils.dart';
import 'package:open_note/l10n/generated/l10n.dart';
import 'package:open_note/settings/cubit/settings_cubit.dart';
import 'package:open_note/settings/widget/widget.dart';
import 'package:settings_repository/settings_repository.dart';

class SortingSetting extends StatelessWidget {
  const SortingSetting({super.key});

  bool _buildWhen(Settings previous, Settings current) =>
      previous.noteSortMode != current.noteSortMode;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, Settings>(
      buildWhen: _buildWhen,
      builder: (context, settings) => ListTile(
        leading: const TileIcon(icon: Icons.sort_rounded),
        title: Text(S.of(context).settingSortTitle),
        subtitle: Text(getSortingModeText(settings.noteSortMode)),
        onTap: () => SortModeDialog.show(context),
      ),
    );
  }
}
