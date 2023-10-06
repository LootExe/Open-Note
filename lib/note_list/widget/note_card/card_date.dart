import 'package:flutter/material.dart';
import 'package:open_note/common/utils.dart';

class CardDate extends StatelessWidget {
  const CardDate({required this.dateTime, super.key});

  final DateTime dateTime;

  @override
  Widget build(BuildContext context) {
    return Text(
      getDateTime(dateTime),
      style: Theme.of(context).textTheme.labelLarge,
    );
  }
}
