import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:note/src/screen/widget/rename_dialog.dart';

void main() {
  testWidgets(
      'Result is same as initial name when saving and without changing text',
      (WidgetTester tester) async {
    final initialName = 'Test Note';
    String? result = '';

    void showRenameDialog(BuildContext context) async {
      result = await RenameDialog.show(
        context: context,
        currentName: initialName,
      );
    }

    await tester.pumpWidget(_buildAppWithDialog(showRenameDialog));

    await tester.tap(find.text('X'));
    await tester.pumpAndSettle();

    expect(result, '');
    await tester.tap(find.text('Save'));
    expect(result, initialName);
  });

  testWidgets('Result is null when canceling', (WidgetTester tester) async {
    final initialName = 'Test Note';
    String? result = '';

    void showRenameDialog(BuildContext context) async {
      result = await RenameDialog.show(
        context: context,
        currentName: initialName,
      );
    }

    await tester.pumpWidget(_buildAppWithDialog(showRenameDialog));

    await tester.tap(find.text('X'));
    await tester.pumpAndSettle();

    expect(result, '');
    await tester.tap(find.text('Cancel'));
    expect(result, null);
  });

  testWidgets('Result is different after changing text',
      (WidgetTester tester) async {
    final initialName = 'Test Note';
    final newName = 'New Test Name';
    String? result = '';

    void showRenameDialog(BuildContext context) async {
      result = await RenameDialog.show(
        context: context,
        currentName: initialName,
      );
    }

    await tester.pumpWidget(_buildAppWithDialog(showRenameDialog));

    await tester.tap(find.text('X'));
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextFormField), newName);

    expect(result, '');
    await tester.tap(find.text('Save'));
    expect(result, newName);
  });

  testWidgets('Result is null after clicking on barrier',
      (WidgetTester tester) async {
    final initialName = 'Test Note';
    String? result = '';

    void showRenameDialog(BuildContext context) async {
      result = await RenameDialog.show(
        context: context,
        currentName: initialName,
      );
    }

    await tester.pumpWidget(_buildAppWithDialog(showRenameDialog));

    await tester.tap(find.text('X'));
    await tester.pumpAndSettle();

    expect(result, '');
    await tester.tap(find.byType(AppBar));
    expect(result, null);
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
