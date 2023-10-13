import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_note/l10n/generated/l10n.dart';
import 'package:open_note/settings/cubit/settings_cubit.dart';
import 'package:settings_repository/settings_repository.dart';

class SortModeDialog {
  static void show(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (context) {
        final l10n = S.of(context);
        final settings = context.watch<SettingsCubit>().state;

        void onChanged(NoteSortMode? value) =>
            context.read<SettingsCubit>().save(
                  settings.copyWith(
                    noteSortMode: value ?? NoteSortMode.editDate,
                  ),
                );

        return AlertDialog(
          title: Text(l10n.settingSortTitle),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RadioListTile(
                title: Text(l10n.settingSortEditDate),
                value: NoteSortMode.editDate,
                groupValue: settings.noteSortMode,
                onChanged: onChanged,
              ),
              RadioListTile(
                title: Text(l10n.settingSortAscending),
                value: NoteSortMode.alphabeticalAscending,
                groupValue: settings.noteSortMode,
                onChanged: onChanged,
              ),
              RadioListTile(
                title: Text(l10n.settingSortDescending),
                value: NoteSortMode.alphabeticalDescending,
                groupValue: settings.noteSortMode,
                onChanged: onChanged,
              ),
              RadioListTile(
                title: Text(l10n.settingSortManual),
                value: NoteSortMode.manual,
                groupValue: settings.noteSortMode,
                onChanged: onChanged,
              ),
            ],
          ),
        );
      },
    );
  }
}
