import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_repository/note_repository.dart';
import 'package:open_note/note_editor/bloc/gesture_bloc.dart';
import 'package:open_note/note_editor/bloc/note_bloc.dart';
import 'package:open_note/note_editor/bloc/scroll_bloc.dart';
import 'package:open_note/note_editor/widget/widget.dart';

class NoteEditorPage extends StatelessWidget {
  const NoteEditorPage({required this.note, super.key});

  final Note note;

  static Route<void> route(Note note) {
    return MaterialPageRoute(builder: (_) => NoteEditorPage(note: note));
  }

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
      child: const NoteEditorView(),
    );
  }
}

class NoteEditorView extends StatefulWidget {
  const NoteEditorView({super.key});

  @override
  State<NoteEditorView> createState() => _NoteEditorViewState();
}

class _NoteEditorViewState extends State<NoteEditorView>
    with WidgetsBindingObserver {
  void _saveNote(BuildContext context) =>
      context.read<NoteBloc>().add(const NoteSaved());

  void _onScreenPop(BuildContext context) {
    _saveNote(context);
    Navigator.pop(context);
  }

  Future<bool> _onWillPop() async {
    _onScreenPop(context);

    return true;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.inactive) {
      _saveNote(context);
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: NoteAppBar(onBackPressed: () => _onScreenPop(context)),
        body: const Stack(
          children: [
            ContentTapDetector(),
            NoteContent(),
          ],
        ),
      ),
    );
  }
}
