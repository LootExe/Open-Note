import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_repository/note_repository.dart';

import '../../../config/app_design.dart';
import '../../bloc/note_bloc.dart';
import '../../bloc/scroll_bloc.dart';

import 'note_title.dart';
import 'text_content.dart';
import 'todo_content/todo_content.dart';

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
        context.read<ScrollBloc>().add(const ScrollContentScrolled(true));
      } else if (!_isTitleVisible && _isExpanded) {
        _isExpanded = false;
        context.read<ScrollBloc>().add(const ScrollContentScrolled(false));
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
            const SizedBox(height: 20.0),
            note is TextNote ? const TextContent() : const TodoContent(),
          ],
        ),
      ),
    );
  }
}
