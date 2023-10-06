import 'package:flutter/material.dart';
import 'package:open_note/config/config.dart';
import 'package:open_note/l10n/generated/l10n.dart';

class EmptyListInfo extends StatelessWidget {
  const EmptyListInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.tertiaryContainer;
    final text = S.of(context).emptyListInfo;

    return Card(
      margin: AppDesign.mainContentPadding.copyWith(top: 60),
      color: color,
      child: Row(
        children: [
          const Padding(
            padding: EdgeInsets.all(24),
            child: Icon(Icons.lightbulb),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 36, top: 24, bottom: 24),
              child: Text(text, style: const TextStyle(fontSize: 16)),
            ),
          ),
        ],
      ),
    );
  }
}
