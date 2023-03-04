import 'package:flutter/material.dart';

class CardPreview extends StatelessWidget {
  const CardPreview({super.key, this.content = ''});

  final String content;

  @override
  Widget build(BuildContext context) {
    final regExp = RegExp('[\\t\\n\\r]+');
    final text = content.replaceAll(regExp, ' ');
    final theme = Theme.of(context);
    var style = theme.textTheme.labelLarge ?? const TextStyle(fontSize: 14.0);
    style = style.copyWith(color: theme.hintColor);

    return Text(
      text,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: style,
    );
  }
}
