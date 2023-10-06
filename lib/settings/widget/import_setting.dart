import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_note/common/extension/extension.dart';
import 'package:open_note/l10n/generated/l10n.dart';
import 'package:open_note/note_list/note_list.dart';
import 'package:open_note/settings/widget/widget.dart';

class ImportSetting extends StatelessWidget {
  const ImportSetting({super.key});

  Future<void> _onPressed(BuildContext context) async {
    final bloc = context.read<NoteListBloc>();
    final messenger = ScaffoldMessenger.of(context);
    final l10n = S.of(context);
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['txt'],
    );

    final filePath = result?.files.first.path ?? '';

    if (result == null || filePath.isEmpty) {
      messenger.showSnackMessage(l10n.settingImportCancelled);

      return;
    }

    bloc.add(NoteListImported(filePath));
    messenger.showSnackMessage(l10n.settingImportSuccess);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);

    return ListTile(
      leading: const TileIcon(icon: Icons.get_app_rounded),
      title: Text(l10n.settingImportTitle),
      subtitle: Text(l10n.settingImportSubtitle),
      onTap: () => _onPressed(context),
    );
  }
}
