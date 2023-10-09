// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:open_note/common/widget/widget.dart';

import '../../helper/pump_app.dart';

void main() {
  group('ArrowBackButton', () {
    Widget buildSubject({VoidCallback? onPressed}) => ArrowBackButton(
          onPressed: onPressed,
        );

    group('constructor', () {
      test('works properly', () {
        expect(
          buildSubject,
          returnsNormally,
        );
      });
    });

    group('arrow back button', () {
      testWidgets('is rendered', (tester) async {
        await tester.pumpApp(buildSubject());

        expect(find.byIcon(Icons.arrow_back_ios_new_rounded), findsOneWidget);
      });

      testWidgets('onPressed is called after tapping the button',
          (tester) async {
        var result = false;

        await tester.pumpApp(buildSubject(onPressed: () => result = true));

        await tester.tap(find.byType(ArrowBackButton));
        await tester.pumpAndSettle();

        expect(result, true);
      });
    });
  });
}
