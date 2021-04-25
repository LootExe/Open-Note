import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import './rename_dialog.dart';
import '../repository/notes_repository.dart';
import '../bloc/note_bloc.dart';
import '../model/note_data.dart';
import '../model/text_data.dart';
import '../model/todo_data.dart';

class NoteScreen extends StatefulWidget {
  final NoteData _noteData;

  NoteScreen(NoteData noteData) : this._noteData = noteData;

  @override
  _NoteState createState() => _NoteState(_noteData);
}

class _NoteState extends State<NoteScreen> {
  final NoteData _noteData;

  _NoteState(NoteData noteData) : this._noteData = noteData;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NoteBloc(
        repository: RepositoryProvider.of<NotesRepository>(context),
        note: _noteData,
      ),
      child: BlocBuilder<NoteBloc, NoteState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text(state.note.title),
              centerTitle: true,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  BlocProvider.of<NoteBloc>(context).add(NoteUpdated());
                  Navigator.pop(context);
                },
              ),
              actions: [
                PopupMenuButton(
                  itemBuilder: (context) => <PopupMenuEntry>[
                    PopupMenuItem(
                      child: const ListTile(
                        leading: const Icon(Icons.edit),
                        title: const Text('Rename'),
                      ),
                      value: 'Rename',
                    ),
                    PopupMenuItem(
                      child: const ListTile(
                        leading: const Icon(Icons.delete),
                        title: const Text('Delete'),
                      ),
                      value: 'Delete',
                    ),
                  ],
                  onSelected: (value) async {
                    // TODO: Add maybe enum as value for popup buttons
                    // Add rename dialog
                    if (value == 'Rename') {
                      String? s = await RenameDialog.show(
                        context: context,
                        currentName: state.note.title,
                      );

                      // TODO: Take care of return value, could be null
                      print(s);
                    }
                  },
                ),
              ],
            ),
            body: state.note is TextData
                ? _TextNote(state.note as TextData)
                : _TodoNote(state.note as TodoData),
          );
        },
      ),
    );
  }
}

class _TextNote extends StatefulWidget {
  final TextData _data;

  _TextNote(TextData data) : this._data = data;

  @override
  State<StatefulWidget> createState() => _TextNoteState(_data);
}

class _TextNoteState extends State<_TextNote> {
  final TextEditingController _controller = TextEditingController();
  final TextData _data;

  _TextNoteState(TextData data) : this._data = data;

  @override
  void initState() {
    super.initState();
    _controller.text = _data.text;
    _controller.addListener(() {
      _data.text = _controller.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
      child: ScrollConfiguration(
        behavior: TextEditorScrollBehavior(),
        child: Scrollbar(
          child: TextField(
            keyboardType: TextInputType.multiline,
            maxLines: null,
            decoration: null,
            controller: _controller,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class _TodoNote extends StatelessWidget {
  final TodoData _data;

  _TodoNote(TodoData data) : this._data = data;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}

class TextEditorScrollBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
