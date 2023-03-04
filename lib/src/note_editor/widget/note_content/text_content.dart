import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_repository/note_repository.dart';

import '../../../../l10n/generated/l10n.dart';
import '../../bloc/gesture_bloc.dart';
import '../../bloc/note_bloc.dart';

class TextContent extends StatefulWidget {
  const TextContent({super.key});

  @override
  State<TextContent> createState() => _TextContentState();
}

class _TextContentState extends State<TextContent> {
  final _textController = TextEditingController();
  final _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    final note = (context.read<NoteBloc>().state.note as TextNote);
    _textController.text = note.content;
  }

  void _blocListener(BuildContext _, NoteState state) {
    final note = state.note as TextNote;

    if (_textController.text != note.content) {
      _textController.text = note.content;
    }
  }

  void _onTextChanged(String value) =>
      context.read<NoteBloc>().add(NoteTextContentChanged(content: value));

  @override
  void dispose() {
    _textController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<NoteBloc, NoteState>(listener: _blocListener),
        BlocListener<GestureBloc, GestureState>(
          listener: (context, state) => _focusNode.requestFocus(),
        ),
      ],
      child: TextField(
        controller: _textController,
        focusNode: _focusNode,
        keyboardType: TextInputType.multiline,
        maxLines: null,
        style: TextStyle(color: Theme.of(context).hintColor),
        decoration: InputDecoration(
          hintText: S.of(context).noteContentTextHint,
          isCollapsed: true,
          filled: false,
          contentPadding: EdgeInsets.zero,
          border: InputBorder.none,
        ),
        onChanged: _onTextChanged,
      ),
    );
  }
}
