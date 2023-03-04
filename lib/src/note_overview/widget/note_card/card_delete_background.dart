import 'package:flutter/material.dart';

class CardDeleteBackground extends StatelessWidget {
  const CardDeleteBackground({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final backgroundColor = colorScheme.errorContainer;
    final iconColor = colorScheme.onErrorContainer;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16.0),
      color: backgroundColor,
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: 24.0),
        child: Icon(Icons.delete_outline, color: iconColor),
      ),
    );
  }
}
