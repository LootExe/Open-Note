import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_note/common/utils.dart';
import 'package:open_note/l10n/generated/l10n.dart';
import 'package:open_note/settings/bloc/settings_bloc.dart';
import 'package:open_note/settings/widget/widget.dart';

class LocaleSetting extends StatelessWidget {
  const LocaleSetting({super.key});

  bool _buildWhen(SettingsState previous, SettingsState current) =>
      previous.settings.language != current.settings.language;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(
      buildWhen: _buildWhen,
      builder: (context, state) => ListTile(
        leading: const TileIcon(icon: Icons.translate_rounded),
        title: Text(S.of(context).settingLocaleLanguageButton),
        subtitle: Text(getLanguageName(state.settings.language)),
        onTap: () => LocaleDialog.show(context),
      ),
    );
  }
}
