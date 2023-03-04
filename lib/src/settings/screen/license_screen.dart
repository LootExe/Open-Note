import 'package:flutter/material.dart';
import 'package:settings_view/settings_view.dart';

import '../../../l10n/generated/l10n.dart';
import '../../config/app_config.dart';
import '../widget/tile_icon.dart';

class LicenseScreen extends StatelessWidget {
  const LicenseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);

    return SettingsTile(
      leading: const TileIcon(icon: Icons.lock),
      title: Text(l10n.settingLicenseTitle),
      subtitle: Text(l10n.settingLicenseSubtitle),
      onPressed: () => showLicensePage(
        context: context,
        applicationName: AppConfig.name,
        applicationVersion: AppConfig.version,
        applicationIcon:
            const Image(image: AppConfig.iconAsset, width: 64.0, height: 64.0),
      ),
    );
  }
}
