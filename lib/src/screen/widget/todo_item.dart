import 'package:flutter/material.dart';

import '../../model/todo_data.dart';
import 'round_checkbox_list_tile.dart';
import 'text_field_sheet.dart';

class TodoItem extends StatefulWidget {
  const TodoItem({
    Key? key,
    required this.animation,
    required this.data,
    this.onChanged,
    this.onDeleted,
    this.tileColor,
  }) : super(key: key);

  final Animation<double> animation;
  final TodoItemData data;
  final ValueChanged<bool>? onChanged;
  final VoidCallback? onDeleted;
  final Color? tileColor;

  @override
  State<StatefulWidget> createState() => _TodoItemState();
}

class _TodoItemState extends State<TodoItem> {
  static final _sizeTween = Tween<double>(
    begin: 0.0,
    end: 1.0,
  ).chain(CurveTween(
    curve: const Interval(
      0.0,
      0.3,
      curve: Curves.easeInOutSine,
    ),
  ));

  static final _slideTween =
      Tween<Offset>(begin: const Offset(1.0, 0.0), end: Offset.zero).chain(
    CurveTween(
      curve: const Interval(
        0.3,
        1.0,
        curve: Curves.easeOutBack,
      ),
    ),
  );

  Widget _buildSlidable() {
    return Dismissible(
      key: ValueKey(widget.data),
      direction: DismissDirection.horizontal,
      background: const ColoredBox(
        color: Colors.red,
        child: Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Icon(Icons.delete_outline),
          ),
        ),
      ),
      secondaryBackground: const ColoredBox(
        color: Colors.indigo,
        child: Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Icon(Icons.edit),
          ),
        ),
      ),
      onDismissed: (DismissDirection direction) async {
        if (direction == DismissDirection.startToEnd) {
          if (widget.onDeleted != null) {
            widget.onDeleted!();
          }
        }
      },
      confirmDismiss: (DismissDirection direction) async {
        if (direction == DismissDirection.startToEnd) {
          return true;
        } else {
          String? text = await TextFieldSheet.show(
            context: context,
            labelText: 'Task name',
            initialText: widget.data.text,
          );

          if (text != null && text != widget.data.text) {
            setState(() {
              widget.data.text = text;

              if (widget.onChanged != null) {
                widget.onChanged!(widget.data.isChecked);
              }
            });
          }
          return false;
        }
      },
      child: _buildCheckboxListTile(),
    );
  }

  Widget _buildCheckboxListTile() {
    return RoundCheckboxListTile(
      title: AnimatedDefaultTextStyle(
        style: widget.data.isChecked
            ? DefaultTextStyle.of(context).style.copyWith(
                  decoration: TextDecoration.lineThrough,
                  color: Colors.grey,
                )
            : DefaultTextStyle.of(context).style,
        duration: const Duration(milliseconds: 200),
        child: Text(widget.data.text),
      ),
      value: widget.data.isChecked,
      onChanged: (bool? value) {
        setState(() {
          widget.data.isChecked = value ?? false;

          if (widget.onChanged != null) {
            widget.onChanged!(widget.data.isChecked);
          }
        });
      },
      tileColor: widget.tileColor,
      checkColor: Theme.of(context).backgroundColor,
      controlAffinity: ListTileControlAffinity.leading,
      contentPadding: const EdgeInsets.only(left: 30.0, right: 30.0),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      axis: Axis.vertical,
      axisAlignment: 1.0,
      sizeFactor: widget.animation.drive(_sizeTween),
      child: SlideTransition(
        position: widget.animation.drive(_slideTween),
        child: _buildSlidable(),
      ),
    );
  }
}
