import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_note/note_editor/bloc/gesture_bloc.dart';

class ContentTapDetector extends StatelessWidget {
  const ContentTapDetector({super.key, this.child});

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.read<GestureBloc>().add(const GestureScreenTapped()),
      child: child,
    );
  }
}
