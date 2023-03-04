import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_repository/note_repository.dart';

import '../../../settings/bloc/settings_bloc.dart';
import '../note_card/note_card.dart';
import 'reorder_proxy.dart';

class ReorderableNoteList extends StatelessWidget {
  const ReorderableNoteList({
    super.key,
    this.padding,
    required this.notes,
    required this.order,
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

    if (oldIndex < newIndex) {
      // Decrement newIndex by 1 because all items are shifting there index
      // after removing the item.
      newIndex -= 1;
    }

    final noteId = newOrder.removeAt(oldIndex);
    newOrder.insert(newIndex, noteId);

    // Save update sort Order.
    final bloc = context.read<SettingsBloc>();
    final settings = bloc.state.settings;
    bloc.add(SettingsUpdated(settings.copyWith(noteSortOrder: newOrder)));
  }

  List<String> _updateOrderList(List<String> order) {
    final newOrder = List.of(order);

    // Remove ids that have no corresponding note.
    newOrder.removeWhere(
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
