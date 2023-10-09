import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:open_note/common/extension/extension.dart';

void main() {
  group('ScaffoldExtension', () {
    const helloSnackBar = 'Hello SnackBar';
    const tapTarget = Key('tap-target');

    Widget buildSubject() {
      return MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (BuildContext context) {
              return GestureDetector(
                key: tapTarget,
                onTap: () => ScaffoldMessenger.of(context)
                    .showSnackMessage(helloSnackBar),
                behavior: HitTestBehavior.opaque,
                child: const SizedBox(height: 100, width: 100),
              );
            },
          ),
        ),
      );
    }

    testWidgets('snackBar can be rendered', (tester) async {
      await tester.pumpWidget(buildSubject());

      expect(find.text(helloSnackBar), findsNothing);
      await tester.tap(find.byKey(tapTarget));

      expect(find.text(helloSnackBar), findsNothing);
      await tester.pump(); // schedule animation

      expect(find.text(helloSnackBar), findsOneWidget);
    });
  });
}
