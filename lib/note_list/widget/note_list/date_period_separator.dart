import 'package:flutter/material.dart';

class DatePeriodSeparator extends StatelessWidget {
  const DatePeriodSeparator({required this.date, super.key});

  final String date;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 24,
        bottom: 10,
      ),
      child: Text(
        date,
        style: Theme.of(context).textTheme.titleLarge,
      ),
    );
  }
}
