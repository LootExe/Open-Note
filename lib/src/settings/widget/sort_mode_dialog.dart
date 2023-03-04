import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:settings_repository/settings_repository.dart';

import '../../../l10n/generated/l10n.dart';
import '../../common/utils.dart';
import '../bloc/settings_bloc.dart';

class SortModeDialog {
  static void show(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(S.of(context).settingSortTitle),
        content: BlocBuilder<SettingsBloc, SettingsState>(
          builder: (context, state) => Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: _buildRadioGroup(
              context: context,
              settings: state.settings,
            ),
          ),
        ),
      ),
    );
  }

  static List<Widget> _buildRadioGroup({
    required BuildContext context,
    required Settings settings,
  }) {
    void onChanged(NoteSortMode? value) {
      final updatedSettings = settings.copyWith(
        noteSortMode: value ?? NoteSortMode.editDate,
      );

      context.read<SettingsBloc>().add(SettingsUpdated(updatedSettings));
    }

    return NoteSortMode.values
        .map(
          (mode) => RadioListTile(
            title: Text(Utils.getSortingModeText(mode)),
            groupValue: settings.noteSortMode,
            value: mode,
            onChanged: onChanged,
          ),
        )
        .toList(growable: false);
  }
}
