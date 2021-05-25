import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

class RenameDialog {
  static Future<String?> show({
    required BuildContext context,
    required String currentName,
  }) async {
    /* final String? newName = await showDialog<String>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        String name = currentName;

        return AlertDialog(
          title: const Text('Rename Note'),
          content: Row(
            children: [
              Expanded(
                child: TextFormField(
                  initialValue: currentName,
                  autofocus: true,
                  decoration: const InputDecoration(
                    labelText: 'New Title',
                    filled: false,
                  ),
                  onChanged: (value) => name = value,
                  onFieldSubmitted: (value) => Navigator.of(context).pop(value),
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
              onPressed: () => Navigator.of(context).pop(null),
            ),
          ],
        ); 
      },
    ); */

    final String? newName = await showModal(
      context: context,
      configuration: FadeScaleTransitionConfiguration(),
      builder: (context) {
        String name = currentName;

        return AlertDialog(
          title: const Text('Rename Note'),
          content: Row(
            children: [
              Expanded(
                child: TextFormField(
                  initialValue: currentName,
                  autofocus: true,
                  decoration: const InputDecoration(
                    labelText: 'New Title',
                    filled: false,
                  ),
                  onChanged: (value) => name = value,
                  onFieldSubmitted: (value) => Navigator.of(context).pop(value),
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
              onPressed: () => Navigator.of(context).pop(null),
            ),
          ],
        );
      },
    );

    if (newName == null) {
      return null;
    }
    if (newName.isEmpty) {
      return currentName;
    }

    return newName;
  }
}
