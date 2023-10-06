import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:open_note/common/widget/widget.dart';

void main() {
  testWidgets('onPressed is called after tapping the button', (tester) async {
    var result = false;
    void onPressed() => result = true;

    await tester.pumpWidget(buildButton(onPressed));

    await tester.tap(find.byType(ArrowBackButton));
    await tester.pumpAndSettle();

    expect(result, true);
  });
}

MaterialApp buildButton(VoidCallback onPressed) {
  return MaterialApp(
    home: Material(
      child: ArrowBackButton(
        onPressed: onPressed,
      ),
    ),
  );
}
