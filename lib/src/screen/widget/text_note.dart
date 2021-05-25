import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/note_bloc.dart';
import '../../model/text_data.dart';

class TextNote extends StatefulWidget {
  const TextNote({Key? key, required this.data}) : super(key: key);

  final TextData data;

  @override
  State<StatefulWidget> createState() => _TextNoteState();
}

class _TextNoteState extends State<TextNote> {
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.text = widget.data.text;
    _controller.addListener(() => widget.data.text = _controller.text);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<NoteBloc, NoteState>(
      listener: (context, state) {
        if (state is NoteUpdateSuccess) {
          _controller.text = widget.data.text;
        }
      },
      child: Column(
        children: [
          Expanded(
            child: ScrollConfiguration(
              behavior: TextEditorScrollBehavior(),
              child: Scrollbar(
                child: TextField(
                  controller: _controller,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  minLines: null,
                  expands: true,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.only(left: 20.0, right: 20.0),
                    isCollapsed: true,
                    filled: false,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class TextEditorScrollBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
