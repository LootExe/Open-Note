import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/widget/widgets.dart';
import '../../../config/app_design.dart';

import '../../bloc/note_bloc.dart';
import 'note_menu/note_menu.dart';
import 'note_app_bar_title.dart';

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
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: const [NoteAppBarTitle()],
      ),
      actions: [
        // TODO: React to bloc state changes (implement isUndoAvailable / isRedoAvailable)
        //  scale in and out buttons
        /* AnimatedSize(
          curve: Curves.easeInOut,
          duration: const Duration(seconds: 1),
          child: FlutterLogo(size: _size),
        ), */
        IconButton(
            onPressed: () => context.read<NoteBloc>().undo(),
            icon: const Icon(Icons.undo)),
        IconButton(
            onPressed: () => context.read<NoteBloc>().redo(),
            icon: const Icon(Icons.redo)),
        const Padding(
          padding: AppDesign.appBarActionPadding,
          child: NoteMenu(),
        ),
      ],
    );
  }
}
