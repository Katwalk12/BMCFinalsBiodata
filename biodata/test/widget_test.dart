import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:biodata/main.dart';

void main() {
  testWidgets('Biodata sheet renders sections without input fields',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(900, 1400);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(const MyApp());

    expect(find.text('BIO-DATA'), findsOneWidget);
    expect(find.text('EDUCATIONAL BACKGROUND'), findsOneWidget);
    expect(find.text('WORK EXPERIENCE'), findsOneWidget);
    expect(find.byType(TextField), findsNothing);
  });

  testWidgets('Biodata sheet fits a phone-width screen',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(const MyApp());

    expect(find.text('Signature'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
