import 'package:flutter/material.dart';

class NoteTitle extends StatelessWidget {
  const NoteTitle({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
      child: Text(
        title,
        textAlign: TextAlign.left,
        style: Theme.of(context).textTheme.headlineSmall,
      ),
    );
  }
}
