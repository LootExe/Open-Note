import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/note_bloc.dart';
import '../../model/todo_data.dart';
import 'note_title.dart';
import 'todo_item.dart';
import 'todo_task_creator.dart';

class TodoNote extends StatefulWidget {
  const TodoNote({Key? key, required this.data}) : super(key: key);

  final TodoData data;

  @override
  State<StatefulWidget> createState() => _TodoNoteState();
}

class _TodoNoteState extends State<TodoNote>
    with SingleTickerProviderStateMixin {
  final _listKey = GlobalKey<AnimatedListState>();
  final _scrollController = ScrollController();
  final List<TodoItemData> _itemsCache = [];

  void _addItem(TodoItemData item) {
    widget.data.items.add(item);

    _listKey.currentState!.insertItem(
      widget.data.items.length - 1,
      duration: const Duration(milliseconds: 400),
    );

    Timer(
      const Duration(milliseconds: 420),
      () => _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      ),
    );

    BlocProvider.of<NoteBloc>(context).add(NoteUpdated());
  }

  void _removeItem(int index) {
    widget.data.items.removeAt(index);

    _listKey.currentState!.removeItem(
      index,
      (context, animation) => Container(),
      duration: const Duration(milliseconds: 0),
    );

    BlocProvider.of<NoteBloc>(context).add(NoteUpdated());
  }

  void _animateRemoveOfCompletedItems() {
    if (_itemsCache.length == widget.data.items.length) {
      return;
    }

    for (int index = _itemsCache.length - 1; index >= 0; index--) {
      if (widget.data.items.contains(_itemsCache[index])) {
        continue;
      }

      final data = _itemsCache[index];

      _listKey.currentState!.removeItem(
        index,
        (context, animation) => TodoItem(
          animation: animation,
          data: data,
        ),
        duration: const Duration(milliseconds: 400),
      );

      _itemsCache.removeAt(index);
    }
  }

  void _changedItem() {
    primaryFocus!.unfocus();
    BlocProvider.of<NoteBloc>(context).add(NoteUpdated());
  }

  @override
  void initState() {
    super.initState();
    _itemsCache.clear();
    _itemsCache.addAll(widget.data.items);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => primaryFocus!.unfocus(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          NoteTitle(title: widget.data.title),
          Expanded(
            child: BlocListener<NoteBloc, NoteState>(
              listener: (context, state) {
                if (state is NoteUpdateSuccess) {
                  _itemsCache.clear();
                  _itemsCache.addAll((state.note as TodoData).items);
                }

                if (state is NoteClearCompletedSuccess) {
                  _animateRemoveOfCompletedItems();
                }
              },
              child: AnimatedList(
                key: _listKey,
                controller: _scrollController,
                initialItemCount: widget.data.items.length,
                itemBuilder: (context, index, animation) => TodoItem(
                  animation: animation,
                  data: widget.data.items[index],
                  onChanged: (_) => _changedItem(),
                  onDeleted: () => _removeItem(index),
                ),
              ),
            ),
          ),
          TodoTaskCreator(onCreated: _addItem),
        ],
      ),
    );
  }
}
