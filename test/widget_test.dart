// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobilproje/app/ui/pages/createads_page/createads_page.dart';
import 'package:mobilproje/app/ui/pages/home_page/home_page.dart';

void main() {
  testWidgets('CreateAds Sayfasına Tıklanma Widget Testi', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: HomePage(),
      ),
    );

    final iconButton = find.byIcon(Icons.arrow_forward);

    await tester.tap(iconButton);
    await tester.pumpAndSettle();

    expect(find.byType(CreateadsPage), findsOneWidget);
  });
}
