import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_repository/note_repository.dart';
import 'package:open_note/config/config.dart';
import 'package:open_note/note_editor/bloc/note_bloc.dart';
import 'package:open_note/note_editor/bloc/scroll_bloc.dart';
import 'package:open_note/note_editor/widget/note_content/note_title.dart';
import 'package:open_note/note_editor/widget/note_content/text_content.dart';
import 'package:open_note/note_editor/widget/note_content/todo_content/todo_content.dart';

class NoteContent extends StatefulWidget {
  const NoteContent({super.key});

  @override
  State<NoteContent> createState() => _NoteContentState();
}

class _NoteContentState extends State<NoteContent> {
  static const kTitleHeightOffset = 110;

  final _controller = ScrollController();
  bool _isExpanded = true;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      if (_isTitleVisible && !_isExpanded) {
        _isExpanded = true;
        context
            .read<ScrollBloc>()
            .add(const ScrollContentScrolled(titleVisible: true));
      } else if (!_isTitleVisible && _isExpanded) {
        _isExpanded = false;
        context
            .read<ScrollBloc>()
            .add(const ScrollContentScrolled(titleVisible: false));
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool get _isTitleVisible =>
      _controller.hasClients &&
      _controller.offset < (kTitleHeightOffset - kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final note = context.read<NoteBloc>().state.note;

    return Scrollbar(
      child: SingleChildScrollView(
        controller: _controller,
        padding: AppDesign.mainContentPadding,
        child: Column(
          children: [
            const NoteTitle(),
            const SizedBox(height: 20),
            if (note is TextNote) const TextContent() else const TodoContent(),
          ],
        ),
      ),
    );
  }
}
