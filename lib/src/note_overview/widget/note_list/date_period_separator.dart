import 'package:flutter/material.dart';

class DatePeriodSeparator extends StatelessWidget {
  const DatePeriodSeparator({super.key, required this.date});

  final String date;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 24.0,
        bottom: 10.0,
      ),
      child: Text(
        date,
        style: Theme.of(context).textTheme.titleLarge,
      ),
    );
  }
}
