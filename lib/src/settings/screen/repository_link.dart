import 'package:flutter/material.dart';
import 'package:settings_view/settings_view.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../config/app_config.dart';
import '../widget/tile_icon.dart';

class RepositoryLink extends StatelessWidget {
  const RepositoryLink({super.key});

  void _launchUrl() {
    final url = Uri.parse(AppConfig.codeRepository);
    launchUrl(url, mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    return SettingsTile.navigation(
      leading: const TileIcon(icon: Icons.code_rounded),
      title: const Text(AppConfig.version),
      subtitle: const Text(AppConfig.codeRepository),
      onPressed: _launchUrl,
    );
  }
}
