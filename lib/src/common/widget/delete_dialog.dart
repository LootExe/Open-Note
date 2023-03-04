import 'package:flutter/material.dart';

import '../../../l10n/generated/l10n.dart';

class DeleteDialog {
  static Future<bool> show(BuildContext context) async {
    final bool? canDelete = await showDialog<bool>(
      context: context,
      builder: (context) {
        final l10n = S.of(context);
        final title = l10n.deleteDialogTitle;
        final content = l10n.deleteDialogContent;
        final cancel = l10n.deleteDialogActionCancel;
        final delete = l10n.deleteDialogActionDelete;

        return AlertDialog(
          title: Text(title, textAlign: TextAlign.center),
          content: Text(content, textAlign: TextAlign.center),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text(cancel),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text(delete),
            ),
          ],
        );
      },
    );

    return canDelete ?? false;
  }
}
