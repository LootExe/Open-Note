import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../bloc/note_bloc.dart';
import '../model/note_data.dart';
import '../model/text_data.dart';
import '../model/todo_data.dart';
import '../repository/notes_repository.dart';

import 'widget/note_app_bar.dart';
import 'widget/text_note.dart';
import 'widget/todo_note.dart';

class NoteScreen extends StatefulWidget {
  const NoteScreen({Key? key, required this.data}) : super(key: key);

  final NoteData data;

  @override
  State<StatefulWidget> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> with WidgetsBindingObserver {
  Widget _buildBody(NoteData data) {
    switch (data.type) {
      case NoteType.todo:
        return TodoNote(data: data as TodoData);
      case NoteType.text:
        return TextNote(data: data as TextData);
    }
  }

  Future<bool> _navigateBackToHome(BuildContext context) {
    BlocProvider.of<NoteBloc>(context).add(NoteUpdated());
    Navigator.pop(context);
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NoteBloc(
        repository: RepositoryProvider.of<NotesRepository>(context),
        note: widget.data,
      ),
      child: BlocBuilder<NoteBloc, NoteState>(
        builder: (context, state) => WillPopScope(
          onWillPop: () => _navigateBackToHome(context),
          child: Scaffold(
            appBar: NoteAppBar(data: widget.data),
            body: _buildBody(state.note),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.inactive) {
      Fluttertoast.showToast(
        msg: "Note saved",
        toastLength: Toast.LENGTH_SHORT,
      );

      RepositoryProvider.of<NotesRepository>(context).writeNotes();
    }
  }
}
