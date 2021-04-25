import 'package:flutter/material.dart';

class DeleteDialog {
  static Future<bool> show({required BuildContext context}) async {
    final bool? canDelete = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Card'),
          content: const Text('Are you sure you want to delete the card?'),
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
        );
      },
    );

    if (canDelete == null) {
      return false;
    }

    return canDelete;
  }
}
