import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:open_note/common/widget/widget.dart';

import '../../helper/pump_app.dart';

void main() {
  group('ArrowBackButton', () {
    var dialogResult = false;

    Future<void> showDeleteDialog(BuildContext context) async {
      dialogResult = await DeleteDialog.show(context);
    }

    Widget buildSubject() {
      return Builder(
        builder: (context) => ElevatedButton(
          onPressed: () => showDeleteDialog(context),
          child: const Text('X'),
        ),
      );
    }

    testWidgets('renderes cancel and delete buttons', (tester) async {
      await tester.pumpApp(buildSubject());

      await tester.tap(find.widgetWithText(ElevatedButton, 'X'));
      await tester.pumpAndSettle();

      expect(find.text('Cancel'), findsOneWidget);
      expect(find.text('Delete'), findsOneWidget);
    });

    testWidgets('result is false after tapping cancel', (tester) async {
      dialogResult = true;

      await tester.pumpApp(buildSubject());

      await tester.tap(find.widgetWithText(ElevatedButton, 'X'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Cancel'));
      expect(dialogResult, false);
    });

    testWidgets('result is true after tapping delete', (tester) async {
      dialogResult = false;

      await tester.pumpApp(buildSubject());

      await tester.tap(find.widgetWithText(ElevatedButton, 'X'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Delete'));
      expect(dialogResult, true);
    });
  });
}
