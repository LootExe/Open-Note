import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

import '../../model/todo_data.dart';

class TodoTaskCreator extends StatefulWidget {
  const TodoTaskCreator({
    Key? key,
    this.keepFocusAfterSubmit = true,
    this.clearTextAfterFocusLoss = true,
    this.loseFocusAfterKeyboardDismiss = true,
    required this.onCreated,
  }) : super(key: key);

  final bool keepFocusAfterSubmit;
  final bool clearTextAfterFocusLoss;
  final bool loseFocusAfterKeyboardDismiss;
  final ValueChanged<TodoItemData> onCreated;

  @override
  State<StatefulWidget> createState() => _TodoTaskCreatorState();
}

class _TodoTaskCreatorState extends State<TodoTaskCreator> {
  final _textController = TextEditingController();
  final _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Material(
        elevation: 6,
        shadowColor: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(24.0),
        child: TextField(
          decoration: const InputDecoration(
            hintText: 'New task',
            prefixIcon: Icon(Icons.add_circle_outline_rounded),
            border: InputBorder.none,
            filled: false,
          ),
          controller: _textController,
          focusNode: _focusNode,
          onEditingComplete: () {
            if (_textController.text.isNotEmpty) {
              widget.onCreated(TodoItemData(
                isChecked: false,
                text: _textController.text,
              ));
            }

            _textController.clear();

            if (widget.keepFocusAfterSubmit) {
              _focusNode.requestFocus();
            }
          },
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (!_focusNode.hasPrimaryFocus && widget.clearTextAfterFocusLoss) {
        WidgetsBinding.instance!
            .addPostFrameCallback((_) => _textController.clear());
      }
    });

    final keyboardController = KeyboardVisibilityController();

    keyboardController.onChange.listen((bool isVisible) {
      if (!isVisible && widget.loseFocusAfterKeyboardDismiss) {
        _focusNode.unfocus();
      }
    });
  }

  @override
  void dispose() {
    _textController.dispose();
    _focusNode.dispose();
    super.dispose();
  }
}
