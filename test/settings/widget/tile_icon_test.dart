// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:open_note/settings/widget/widget.dart';

import '../../helper/pump_app.dart';

void main() {
  group('TileIcon', () {
    const iconData = Icons.light_mode_outlined;

    Widget buildSubject() => TileIcon(icon: iconData);

    group('constructor', () {
      test('works properly', () {
        expect(
          buildSubject,
          returnsNormally,
        );
      });
    });

    group('tile icon', () {
      testWidgets('is rendered', (tester) async {
        await tester.pumpApp(buildSubject());

        expect(find.byIcon(iconData), findsOneWidget);
      });
    });
  });
}
