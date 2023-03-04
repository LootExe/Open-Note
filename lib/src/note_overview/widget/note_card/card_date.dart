import 'package:flutter/material.dart';

import '../../../common/utils.dart';

class CardDate extends StatelessWidget {
  const CardDate({super.key, required this.dateTime});

  final DateTime dateTime;

  @override
  Widget build(BuildContext context) {
    return Text(
      Utils.parseDateTime(dateTime),
      style: Theme.of(context).textTheme.labelLarge,
    );
  }
}
