import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_repository/note_repository.dart';

import '../bloc/gesture_bloc.dart';
import '../bloc/note_bloc.dart';

import '../bloc/scroll_bloc.dart';
import 'note_screen_view.dart';

class NoteScreen extends StatelessWidget {
  const NoteScreen({super.key, required this.note});

  static Future<void> push(BuildContext context, Note note) {
    return Navigator.push<void>(
      context,
      MaterialPageRoute(builder: (context) => NoteScreen(note: note)),
    );
  }

  final Note note;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => NoteBloc(
            repository: context.read<NoteRepository>(),
            note: note,
          ),
        ),
        BlocProvider(create: (_) => GestureBloc()),
        BlocProvider(create: (_) => ScrollBloc()),
      ],
      child: const NoteScreenView(),
    );
  }
}
