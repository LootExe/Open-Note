import 'package:flutter/material.dart';
import 'package:open_note/common/widget/widget.dart';
import 'package:open_note/config/config.dart';
import 'package:open_note/note_editor/widget/note_app_bar/note_app_bar_title.dart';
import 'package:open_note/note_editor/widget/note_app_bar/note_menu/note_menu.dart';

class NoteAppBar extends StatefulWidget implements PreferredSizeWidget {
  const NoteAppBar({super.key, this.onBackPressed});

  final VoidCallback? onBackPressed;

  @override
  State<NoteAppBar> createState() => _NoteAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _NoteAppBarState extends State<NoteAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: ArrowBackButton(onPressed: widget.onBackPressed),
      title: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [NoteAppBarTitle()],
      ),
      actions: const [
        Padding(
          padding: AppDesign.appBarActionPadding,
          child: NoteMenu(),
        ),
      ],
    );
  }
}
