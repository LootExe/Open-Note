import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/note_bloc.dart';
import '../widget/content_tap_detector.dart';
import '../widget/note_app_bar/note_app_bar.dart';
import '../widget/note_content/note_content.dart';

class NoteScreenView extends StatefulWidget {
  const NoteScreenView({super.key});

  @override
  State<NoteScreenView> createState() => _NoteScreenViewState();
}

class _NoteScreenViewState extends State<NoteScreenView>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  void _saveNote(BuildContext context) =>
      context.read<NoteBloc>().add(const NoteSaved());

  void _onScreenPop(BuildContext context) {
    _saveNote(context);
    Navigator.pop(context);
  }

  Future<bool> _onWillPop() async {
    _onScreenPop(context);

    return true;
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.inactive) {
      _saveNote(context);
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: NoteAppBar(onBackPressed: () => _onScreenPop(context)),
        body: Stack(
          children: const [
            ContentTapDetector(),
            NoteContent(),
          ],
        ),
      ),
    );
  }
}
