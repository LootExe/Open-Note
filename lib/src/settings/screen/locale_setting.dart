import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:settings_view/settings_view.dart';

import '../../../l10n/generated/l10n.dart';
import '../../common/utils.dart';
import '../bloc/settings_bloc.dart';
import '../widget/locale_dialog.dart';
import '../widget/tile_icon.dart';

class LocaleSetting extends StatelessWidget {
  const LocaleSetting({super.key});

  bool _buildWhen(SettingsState previous, SettingsState current) =>
      previous.settings.language != current.settings.language;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(
      buildWhen: _buildWhen,
      builder: (context, state) => SettingsTile(
        leading: const TileIcon(icon: Icons.translate_rounded),
        title: Text(S.of(context).settingLocaleLanguageButton),
        subtitle: Text(Utils.getLanguageName(state.settings.language)),
        onPressed: () => LocaleDialog.show(context),
      ),
    );
  }
}
