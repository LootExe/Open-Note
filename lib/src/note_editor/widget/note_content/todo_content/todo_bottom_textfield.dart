import 'package:flutter/material.dart';

import '../../../../config/app_design.dart';

class TodoBottomTextField extends StatefulWidget {
  const TodoBottomTextField({
    super.key,
    required this.focusNode,
    this.onAdded,
    this.onDeleted,
  });

  final FocusNode focusNode;
  final ValueChanged<String>? onAdded;
  final VoidCallback? onDeleted;

  @override
  State<TodoBottomTextField> createState() => _TodoBottomTextFieldState();
}

class _TodoBottomTextFieldState extends State<TodoBottomTextField> {
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.text =
        widget.onDeleted != null ? AppDesign.kZeroWidthSpace : '';
  }

  void _onTextChanged(String value) {
    if (widget.onDeleted != null && value.isEmpty) {
      widget.onDeleted?.call();

      _controller.value = const TextEditingValue(
        text: AppDesign.kZeroWidthSpace,
        selection: TextSelection.collapsed(offset: 1),
      );
    }

    if (widget.onAdded != null) {
      if (value.length > 1 && value.startsWith(AppDesign.kZeroWidthSpace)) {
        final text = value.substring(1, value.length);
        widget.onAdded?.call(text);
        _controller.text = AppDesign.kZeroWidthSpace;
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      focusNode: widget.focusNode,
      maxLines: 1,
      textInputAction: TextInputAction.done,
      decoration: AppDesign.emptyTextFieldDecoration,
      onChanged: _onTextChanged,
    );
  }
}
