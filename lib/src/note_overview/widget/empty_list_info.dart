import 'package:flutter/material.dart';

import '../../../l10n/generated/l10n.dart';
import '../../config/app_design.dart';

class EmptyListInfo extends StatelessWidget {
  const EmptyListInfo({super.key});

  static const _iconPadding = EdgeInsets.all(24.0);
  static const _textPadding =
      EdgeInsets.only(right: 36.0, top: 24.0, bottom: 24.0);
  static const _textStyle = TextStyle(fontSize: 16.0);

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
            padding: _iconPadding,
            child: Icon(Icons.lightbulb),
          ),
          Expanded(
            child: Padding(
              padding: _textPadding,
              child: Text(text, style: _textStyle),
            ),
          ),
        ],
      ),
    );
  }
}
