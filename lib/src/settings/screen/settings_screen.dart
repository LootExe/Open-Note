import 'package:flutter/material.dart';
import 'package:settings_view/settings_view.dart';

import '../../../l10n/generated/l10n.dart';
import '../../common/widget/widgets.dart';

import 'license_screen.dart';
import 'export_setting.dart';
import 'import_setting.dart';
import 'locale_setting.dart';
import 'monet_setting.dart';
import 'repository_link.dart';
import 'sorting_setting.dart';
import 'theme_setting.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  static Future<void> push(BuildContext context) {
    return Navigator.push<void>(
      context,
      MaterialPageRoute(builder: (_) => const SettingsScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.settingsAppbar),
        leading: ArrowBackButton(onPressed: () => Navigator.of(context).pop()),
      ),
      body: SettingsView(
        children: [
          SettingsCategory(
            title: Text(l10n.settingsAppearanceHeader),
            children: const [
              ThemeSetting(),
              MonetSetting(),
              LocaleSetting(),
            ],
          ),
          SettingsCategory(
            title: Text(l10n.settingsNotesHeader),
            children: const [
              SortingSetting(),
              ExportSetting(),
              ImportSetting(),
            ],
          ),
          SettingsCategory(
            title: Text(l10n.settingsAboutHeader),
            children: const [
              LicenseScreen(),
              RepositoryLink(),
            ],
          ),
        ],
      ),
    );
  }
}
