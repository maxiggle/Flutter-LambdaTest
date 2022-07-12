import 'package:code_magic_test/app.dart';
import 'package:code_magic_test/home/view/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  testWidgets(
      "When a authors name is clicked "
      "I am routed to see the full detailds of the author",
      (WidgetTester tester) async {
    await tester.pumpWidget(App());
    await tester.tap(find.byWidget(ListTile()));

    expect(find.by, matcher)
  });
}
