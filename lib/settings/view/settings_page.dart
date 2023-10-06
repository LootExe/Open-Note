import 'package:flutter/material.dart';
import 'package:open_note/common/widget/widget.dart';
import 'package:open_note/l10n/generated/l10n.dart';
import 'package:open_note/settings/widget/widget.dart';
import 'package:settings_list/settings_list.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute(builder: (_) => const SettingsPage());
  }

  @override
  Widget build(BuildContext context) {
    return const SettingsView();
  }
}

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.settingsAppbar),
        leading: ArrowBackButton(onPressed: () => Navigator.of(context).pop()),
      ),
      body: SettingsList(
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
              LicenseSetting(),
              RepositoryLink(),
            ],
          ),
        ],
      ),
    );
  }
}
