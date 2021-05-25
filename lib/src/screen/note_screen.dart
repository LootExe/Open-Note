import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../bloc/note_bloc.dart';
import '../model/note_data.dart';
import '../model/text_data.dart';
import '../model/todo_data.dart';
import '../repository/notes_repository.dart';

import 'widget/text_note.dart';
import 'widget/text_note_menu.dart';
import 'widget/todo_note.dart';
import 'widget/todo_note_menu.dart';

class NoteScreen extends StatefulWidget {
  const NoteScreen({
    Key? key,
    required this.data,
  }) : super(key: key);

  final NoteData data;

  @override
  _NoteScreenState createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> with WidgetsBindingObserver {
  List<Widget> _buildMenu(BuildContext context, NoteData data) {
    switch (data.type) {
      case NoteType.Todo:
        return [TodoNoteMenu(data: data as TodoData)];
      case NoteType.Text:
        return [TextNoteMenu(data: data as TextData)];
    }
  }

  Widget _buildBody(NoteData data) {
    switch (data.type) {
      case NoteType.Todo:
        return TodoNote(data: data as TodoData);
      case NoteType.Text:
        return TextNote(data: data as TextData);
    }
  }

  void _navigateBackToHome(BuildContext context) {
    BlocProvider.of<NoteBloc>(context).add(NoteUpdated());
    Navigator.pop(context);
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
          onWillPop: () {
            _navigateBackToHome(context);
            return Future.value(true);
          },
          child: Scaffold(
            appBar: AppBar(
              title: Text(state.note.title),
              centerTitle: true,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => _navigateBackToHome(context),
              ),
              actions: _buildMenu(context, state.note),
            ),
            body: _buildBody(state.note),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
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
