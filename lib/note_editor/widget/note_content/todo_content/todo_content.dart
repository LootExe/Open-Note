import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_repository/note_repository.dart';
import 'package:open_note/note_editor/bloc/gesture_bloc.dart';
import 'package:open_note/note_editor/bloc/note_bloc.dart';
import 'package:open_note/note_editor/widget/note_content/todo_content/todo_bottom_textfield.dart';
import 'package:open_note/note_editor/widget/note_content/todo_content/todo_tile.dart';

class TodoContent extends StatefulWidget {
  const TodoContent({super.key});

  @override
  State<TodoContent> createState() => _TodoContentState();
}

class _TodoContentState extends State<TodoContent> {
  final _itemsNode = FocusScopeNode();
  final _bottomTextNode = FocusNode();

  void _onBottomFieldAdded(String value) {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => _itemsNode.previousFocus(),
    );

    context.read<NoteBloc>().add(NoteTodoItemAdded(TodoItem(text: value)));
  }

  void _onBottomFieldDeleted() => _itemsNode.previousFocus();

  void _onItemSubmitted(List<TodoItem> items, TodoItem item) {
    final index = items.indexOf(item);

    if (index == items.length - 1) {
      _bottomTextNode.requestFocus();
    }
  }

  void _onItemDeleted(List<TodoItem> items, TodoItem item) {
    final index = items.indexOf(item);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (index > 0) {
        _itemsNode.previousFocus();
      } else if (items.length > 1) {
        _itemsNode.nextFocus();
      }
    });

    context.read<NoteBloc>().add(NoteTodoItemDeleted(item.id));
  }

  bool _buildWhen(NoteState previous, NoteState current) {
    final prevNote = previous.note as TodoNote;
    final currNote = current.note as TodoNote;

    return prevNote.items != currNote.items;
  }

  @override
  void dispose() {
    _itemsNode.dispose();
    _bottomTextNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<GestureBloc, GestureState>(
      listener: (context, state) => _bottomTextNode.requestFocus(),
      child: BlocBuilder<NoteBloc, NoteState>(
        buildWhen: _buildWhen,
        builder: (context, state) {
          final items = (state.note as TodoNote).items;

          return FocusScope(
            node: _itemsNode,
            child: ListView(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              children: [
                for (final item in items)
                  TodoTile(
                    key: ValueKey(item.id),
                    value: item.isChecked,
                    text: item.text,
                    onValueChanged: (value) => context.read<NoteBloc>().add(
                          NoteTodoItemChanged(item.copyWith(isChecked: value)),
                        ),
                    onTextChanged: (text) => context
                        .read<NoteBloc>()
                        .add(NoteTodoItemChanged(item.copyWith(text: text))),
                    onSubmitted: () => _onItemSubmitted(items, item),
                    onDeleted: () => _onItemDeleted(items, item),
                  ),
                TodoBottomTextField(
                  key: ValueKey(_bottomTextNode),
                  focusNode: _bottomTextNode,
                  onAdded: _onBottomFieldAdded,
                  onDeleted: _onBottomFieldDeleted,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
