import 'package:flutter/material.dart';

class DeleteDialog {
  static Future<bool> show({
    required BuildContext context,
  }) async {
    final bool? canDelete = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('Delete Note'),
        content: const Text('Are you sure you want to delete this note?'),
        actions: <Widget>[
          TextButton(
            child: const Text('Yes'),
            onPressed: () => Navigator.of(context).pop(true),
          ),
          TextButton(
            child: const Text('Cancel'),
            onPressed: () => Navigator.of(context).pop(false),
          ),
        ],
      ),
    );

    return canDelete ?? false;
  }
}
