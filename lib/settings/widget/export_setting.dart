import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_note/common/extension/extension.dart';
import 'package:open_note/l10n/generated/l10n.dart';
//import 'package:open_note/note_list/note_list.dart';
import 'package:open_note/settings/widget/widget.dart';

class ExportSetting extends StatelessWidget {
  const ExportSetting({super.key});

  Future<void> _onPressed(BuildContext context) async {
    //final bloc = context.read<NoteListBloc>();
    final messenger = ScaffoldMessenger.of(context);
    final l10n = S.of(context);
    final directory = await FilePicker.platform.getDirectoryPath();

    if (directory == null) {
      messenger.showSnackMessage(l10n.settingExportCancelled);

      return;
    }

    //bloc.add(NoteListExported(directory));
    messenger.showSnackMessage(l10n.settingExportSuccess);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);

    return ListTile(
      leading: const TileIcon(icon: Icons.save),
      title: Text(l10n.settingExportTitle),
      subtitle: Text(l10n.settingExportSubtitle),
      onTap: () => _onPressed(context),
    );
  }
}
