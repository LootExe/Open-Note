import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:note/src/screen/widget/delete_dialog.dart';

void main() {
  testWidgets('Result is True after clicking Yes', (WidgetTester tester) async {
    bool result = false;

    void showDeleteDialog(BuildContext context) async {
      result = await DeleteDialog.show(context: context);
    }

    await tester.pumpWidget(_buildAppWithDialog(showDeleteDialog));

    await tester.tap(find.text('X'));
    await tester.pumpAndSettle();

    expect(result, false);
    await tester.tap(find.text('Yes'));
    expect(result, true);
  });

  testWidgets('Result is False after clicking Cancel',
      (WidgetTester tester) async {
    bool result = true;

    void showDeleteDialog(BuildContext context) async {
      result = await DeleteDialog.show(context: context);
    }

    await tester.pumpWidget(_buildAppWithDialog(showDeleteDialog));

    await tester.tap(find.text('X'));
    await tester.pumpAndSettle();

    expect(result, true);
    await tester.tap(find.text('Cancel'));
    expect(result, false);
  });
}

MaterialApp _buildAppWithDialog(Function dialogMethod) {
  return MaterialApp(
    home: Material(
      child: Builder(builder: (BuildContext context) {
        return Scaffold(
          appBar: AppBar(),
          body: Center(
            child: ElevatedButton(
              child: const Text('X'),
              onPressed: () => dialogMethod(context),
            ),
          ),
        );
      }),
    ),
  );
}
