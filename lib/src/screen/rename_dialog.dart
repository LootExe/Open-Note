import 'package:flutter/material.dart';

class RenameDialog {
  static Future<String> show({
    required BuildContext context,
    required String currentName,
  }) async {
    final String? newName = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        final initialName = currentName.isEmpty ? 'New Note' : currentName;
        String name = initialName;

        return AlertDialog(
          title: const Text('Rename Note'),
          content: Row(
            children: [
              Expanded(
                child: TextFormField(
                  initialValue: initialName,
                  autofocus: true,
                  decoration: const InputDecoration(labelText: 'New Title'),
                  onChanged: (value) => name = value,
                ),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Save'),
              onPressed: () => Navigator.of(context).pop(name),
            ),
            TextButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(initialName),
            ),
          ],
        );
      },
    );

    if (newName == null || newName.isEmpty) {
      return currentName;
    }

    return newName;
  }
}
