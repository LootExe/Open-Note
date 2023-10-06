import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:open_note/common/widget/widget.dart';
import 'package:open_note/l10n/generated/l10n.dart';

void main() {
  testWidgets('Result should be true after clicking Delete', (tester) async {
    var result = false;

    Future<void> showDeleteDialog(BuildContext context) async {
      result = await DeleteDialog.show(context);
    }

    await tester.pumpWidget(buildAppWithDialog(showDeleteDialog));

    await tester.tap(find.text('X'));
    await tester.pumpAndSettle();

    expect(result, false);
    await tester.tap(find.text('Delete'));
    expect(result, true);
  });

  testWidgets('Result should be false after clicking Cancel', (tester) async {
    var result = true;

    Future<void> showDeleteDialog(BuildContext context) async {
      result = await DeleteDialog.show(context);
    }

    await tester.pumpWidget(buildAppWithDialog(showDeleteDialog));

    await tester.tap(find.text('X'));
    await tester.pumpAndSettle();

    expect(result, true);
    await tester.tap(find.text('Cancel'));
    expect(result, false);
  });
}

MaterialApp buildAppWithDialog(ValueSetter<BuildContext> dialogMethod) {
  return MaterialApp(
    localizationsDelegates: const [
      S.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    supportedLocales: S.delegate.supportedLocales,
    home: Material(
      child: Builder(
        builder: (context) => ElevatedButton(
          onPressed: () => dialogMethod(context),
          child: const Text('X'),
        ),
      ),
    ),
  );
}
