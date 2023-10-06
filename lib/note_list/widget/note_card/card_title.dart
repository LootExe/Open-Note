import 'package:flutter/material.dart';

class CardTitle extends StatelessWidget {
  const CardTitle({super.key, this.title = ''});

  final String title;

  @override
  Widget build(BuildContext context) {
    var style = Theme.of(context).textTheme.titleMedium ??
        const TextStyle(fontSize: 18);
    style = style.copyWith(fontWeight: FontWeight.bold);

    return Text(title, style: style);
  }
}
