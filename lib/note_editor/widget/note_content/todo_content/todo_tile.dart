import 'package:flutter/material.dart';
import 'package:open_note/config/config.dart';

class TodoTile extends StatefulWidget {
  const TodoTile({
    required this.value,
    required this.text,
    super.key,
    this.onValueChanged,
    this.onTextChanged,
    this.onSubmitted,
    this.onDeleted,
  });

  final bool value;
  final String text;
  final ValueChanged<bool>? onValueChanged;
  final ValueChanged<String>? onTextChanged;
  final VoidCallback? onSubmitted;
  final VoidCallback? onDeleted;

  @override
  State<TodoTile> createState() => _TodoTileState();
}

class _TodoTileState extends State<TodoTile> {
  final _controller = TextEditingController();
  String _textCache = '';

  @override
  void initState() {
    super.initState();
    _controller.text = widget.text;
    _textCache = widget.text;
  }

  void _onCheckboxChanged(bool? value) =>
      widget.onValueChanged?.call(value ?? false);

  void _onTextFieldChanged(String value) {
    widget.onTextChanged?.call(value);

    if (widget.onDeleted != null) {
      // Backspace key pressed on an empty textfield.
      if (value.isEmpty && _textCache.startsWith(AppDesign.kZeroWidthSpace)) {
        widget.onDeleted?.call();
      } else if (value.isEmpty) {
        // Texfield is empty, replace with zws.
        _controller.value = const TextEditingValue(
          text: AppDesign.kZeroWidthSpace,
          selection: TextSelection.collapsed(offset: 1),
        );

        value = AppDesign.kZeroWidthSpace;
      }
    }

    _textCache = value;
  }

  void _onTextFieldSubmitted(String _) => widget.onSubmitted?.call();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ExcludeFocus(
          child: Checkbox(
            value: widget.value,
            onChanged: _onCheckboxChanged,
          ),
        ),
        Expanded(
          child: TextField(
            controller: _controller,
            minLines: 1,
            maxLines: 10,
            textInputAction: TextInputAction.done,
            decoration: AppDesign.emptyTextFieldDecoration,
            onChanged: _onTextFieldChanged,
            onSubmitted: _onTextFieldSubmitted,
          ),
        ),
      ],
    );
  }
}
