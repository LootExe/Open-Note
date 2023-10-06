import 'package:flutter/material.dart';
import 'package:open_note/config/config.dart';
import 'package:open_note/settings/widget/widget.dart';
import 'package:url_launcher/url_launcher.dart';

class RepositoryLink extends StatelessWidget {
  const RepositoryLink({super.key});

  void _launchUrl() {
    final url = Uri.parse(AppConfig.codeRepository);
    launchUrl(url, mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const TileIcon(icon: Icons.code_rounded),
      trailing: const Icon(Icons.open_in_new_rounded),
      title: const Text(AppConfig.version),
      subtitle: const Text(AppConfig.codeRepository),
      onTap: _launchUrl,
    );
  }
}
