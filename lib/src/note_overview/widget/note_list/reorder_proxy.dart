import 'dart:ui' show lerpDouble;

import 'package:flutter/material.dart';
import 'package:note_repository/note_repository.dart';

import '../note_card/note_card.dart';

class ReorderProxy extends StatelessWidget {
  const ReorderProxy({
    super.key,
    required this.draggedNote,
    required this.animation,
    this.child,
  });

  final Note draggedNote;
  final Animation<double> animation;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        final animValue = Curves.easeInOut.transform(animation.value);
        final elevation = lerpDouble(0, 6, animValue) ?? 0.0;

        return NoteCard(note: draggedNote, elevation: elevation);
      },
      child: child,
    );
  }
}
