import 'package:flutter/material.dart';
import 'package:open_note/config/config.dart';
import 'package:open_note/l10n/generated/l10n.dart';
import 'package:open_note/settings/widget/tile_icon.dart';

class LicenseSetting extends StatelessWidget {
  const LicenseSetting({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);

    return ListTile(
      leading: const TileIcon(icon: Icons.lock),
      title: Text(l10n.settingLicenseTitle),
      subtitle: Text(l10n.settingLicenseSubtitle),
      onTap: () => showLicensePage(
        context: context,
        applicationName: AppConfig.name,
        applicationVersion: AppConfig.version,
        applicationIcon:
            const Image(image: AppConfig.iconAsset, width: 64, height: 64),
      ),
    );
  }
}
