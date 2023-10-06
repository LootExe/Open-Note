import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_repository/note_repository.dart';
import 'package:open_note/note_list/widget/note_card/note_card.dart';
import 'package:open_note/note_list/widget/note_list/reorder_proxy.dart';
import 'package:open_note/settings/settings.dart';

class ReorderableNoteList extends StatelessWidget {
  const ReorderableNoteList({
    required this.notes,
    required this.order,
    super.key,
    this.padding,
    this.onNotePressed,
    this.onNoteDismissed,
  });

  final EdgeInsets? padding;
  final List<Note> notes;
  final List<String> order;
  final ValueSetter<Note>? onNotePressed;
  final ValueSetter<String>? onNoteDismissed;

  void _onNoteReordered(BuildContext context, int oldIndex, int newIndex) {
    final newOrder = _updateOrderList(order);
    var index = newIndex;

    if (oldIndex < index) {
      // Decrement newIndex by 1 because all items are shifting there index
      // after removing the item.
      index -= 1;
    }

    final noteId = newOrder.removeAt(oldIndex);
    newOrder.insert(index, noteId);

    // Save update sort Order.
    final bloc = context.read<SettingsBloc>();
    final settings = bloc.state.settings;
    bloc.add(SettingsChanged(settings.copyWith(noteSortIds: newOrder)));
  }

  List<String> _updateOrderList(List<String> order) {
    final newOrder = List.of(order)
      ..removeWhere(
        // Remove ids that have no corresponding note.
        (id) => notes.indexWhere((note) => note.id == id) == -1,
      );

    // Add ids that are not part of order list.
    for (final note in notes) {
      if (!newOrder.contains(note.id)) {
        newOrder.add(note.id);
      }
    }

    return newOrder;
  }

  @override
  Widget build(BuildContext context) {
    return ReorderableListView(
      padding: padding,
      onReorder: (oldIndex, newIndex) =>
          _onNoteReordered(context, oldIndex, newIndex),
      proxyDecorator: (child, index, animation) => ReorderProxy(
        draggedNote: notes[index],
        animation: animation,
        child: child,
      ),
      children: [
        for (final note in notes)
          NoteCard(
            key: Key(note.id),
            note: note,
            onPressed: () => onNotePressed?.call(note),
            onDismissed: () => onNoteDismissed?.call(note.id),
          ),
      ],
    );
  }
}
