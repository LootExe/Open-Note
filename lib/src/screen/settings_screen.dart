import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../bloc/note_list_bloc.dart';
import '../bloc/settings_bloc.dart';
import 'widget/file_import_dialog.dart';
import 'widget/settings_tile.dart';
import 'widget/theme_settings_dialog.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String _themeModeToText(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.system:
        return 'System default theme';
      case ThemeMode.light:
        return 'Always light theme';
      case ThemeMode.dark:
        return 'Always dark theme';
    }
  }

  void _showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: Container(
        padding: const EdgeInsets.only(top: 10.0, bottom: 10.0, left: 4.0),
        child: BlocBuilder<SettingsBloc, SettingsState>(
          builder: (context, state) => ListView(
            itemExtent: 70.0,
            children: [
              SettingsTile(
                title: 'Appearance',
                subtitle: _themeModeToText(state.settings.themeMode),
                onTap: () => ThemeSettingsDialog.show(context: context),
              ),
              BlocListener<NoteListBloc, NoteListState>(
                listener: (context, state) {
                  if (state is NoteListExportSuccess) {
                    _showToast('Notes export successful');
                  } else {
                    _showToast('Notes export failed');
                  }
                },
                listenWhen: (previous, current) =>
                    current is NoteListExportSuccess ||
                    current is NoteListExportFailure,
                child: SettingsTile(
                  title: 'Export Notes',
                  subtitle: 'Export all notes into a file',
                  onTap: () => BlocProvider.of<NoteListBloc>(context)
                    ..add(NoteListExported()),
                ),
              ),
              BlocListener<NoteListBloc, NoteListState>(
                listener: (context, state) {
                  if (state is NoteListImportFileStartFailure) {
                    _showToast('Import cancelled');
                  } else if (state is NoteListImportFileLoadSuccess) {
                    if (state.files.isEmpty) {
                      _showToast('No files found');
                    } else {
                      FileImportDialog.show(
                          context: context, files: state.files);
                    }
                  } else if (state is NoteListImportSuccess) {
                    _showToast('Import successful');
                  } else if (state is NoteListImportFailure) {
                    _showToast('Import failed');
                  }
                },
                listenWhen: (previous, current) =>
                    current is NoteListImportFileLoadSuccess ||
                    current is NoteListImportFileStartFailure ||
                    current is NoteListImportSuccess ||
                    current is NoteListImportFailure,
                child: SettingsTile(
                  title: 'Import Notes',
                  subtitle: 'Import notes from a file',
                  onTap: () => BlocProvider.of<NoteListBloc>(context)
                    ..add(NoteListImportFilesStarted()),
                ),
              ),
              SettingsTile(
                title: 'Licenses',
                subtitle: 'Show licenses and app details',
                onTap: () => showLicensePage(
                  context: context,
                  applicationName: 'Note App',
                  applicationVersion: 'v2.0.1',
                  applicationIcon: const Image(
                    image: AssetImage('asset/icon/launcher_icon.png'),
                    width: 64.0,
                    height: 64.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
