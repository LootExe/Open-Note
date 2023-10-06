import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_note/config/config.dart';
import 'package:open_note/l10n/generated/l10n.dart';
import 'package:open_note/note_editor/bloc/note_bloc.dart';

class NoteTitle extends StatefulWidget {
  const NoteTitle({super.key});

  @override
  State<NoteTitle> createState() => _NoteTitleState();
}

class _NoteTitleState extends State<NoteTitle> {
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.text = context.read<NoteBloc>().state.note.title;
  }

  void _onTextChanged(String value) =>
      context.read<NoteBloc>().add(NoteTitleChanged(value));

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      autofocus: _controller.text.isEmpty,
      textInputAction: TextInputAction.done,
      maxLength: 64,
      minLines: 1,
      maxLines: 4,
      style: Theme.of(context).textTheme.headlineSmall,
      decoration: AppDesign.emptyTextFieldDecoration.copyWith(
        hintText: S.of(context).noteTitleHint,
      ),
      onChanged: _onTextChanged,
    );
  }
}
