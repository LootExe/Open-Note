import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/note_list_bloc.dart';
import '../../model/note_list_file.dart';

class FileImportDialog {
  static void show({
    required BuildContext context,
    required List<NoteListFile> files,
  }) {
    showDialog<void>(
      context: context,
      builder: (context) => SimpleDialog(
        title: const Center(child: Text('Select file to import')),
        children: [
          const Center(child: Text('Current notes will be deleted!')),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.3,
            width: MediaQuery.of(context).size.width * 0.75,
            child: ListView.builder(
              itemCount: files.length,
              itemBuilder: (context, index) => ListTile(
                title: Text(
                  files[index].name,
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
                onTap: () {
                  BlocProvider.of<NoteListBloc>(context)
                      .add(NoteListImported(files[index].uri));
                  Navigator.pop(context);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
