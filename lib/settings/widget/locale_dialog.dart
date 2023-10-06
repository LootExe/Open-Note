import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_note/common/utils.dart';
import 'package:open_note/l10n/generated/l10n.dart';
import 'package:open_note/settings/bloc/settings_bloc.dart';
import 'package:settings_repository/settings_repository.dart';

class LocaleDialog {
  static void show(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(S.of(context).settingLocaleLanguageButton),
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
    void onChanged(String? value) {
      final changedSettings = settings.copyWith(language: () => value);
      context.read<SettingsBloc>().add(SettingsChanged(changedSettings));
    }

    final values = _generateLanguageList();

    return values
        .map(
          (code) => RadioListTile<String?>(
            title: Text(getLanguageName(code)),
            groupValue: settings.language,
            value: code,
            onChanged: onChanged,
          ),
        )
        .toList(growable: false);
  }

  static List<String?> _generateLanguageList() {
    // First value should be system default.
    final values = <String?>[null];

    for (final locale in S.delegate.supportedLocales) {
      values.add(locale.toString());
    }

    // Sort alphabetically.
    values.sort((a, b) {
      if (a == null) {
        return -1;
      }
      if (b == null) {
        return 1;
      }

      return a.compareTo(b);
    });

    return values;
  }
}
