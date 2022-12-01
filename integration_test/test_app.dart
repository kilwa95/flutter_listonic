import 'package:flutter/material.dart';
import 'package:flutter_listonic/main.dart' as app;
import 'package:flutter_test/flutter_test.dart';

void testApp(String provider) {
  testWidgets("full app test $provider", (WidgetTester tester) async {
    app.main(provider: provider);
    await tester.pumpAndSettle(
      const Duration(seconds: 3),
    );
    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle(
      const Duration(seconds: 2),
    );

    final Finder titleInput = find.byType(TextField).first;
    final Finder descriptionInput = find.byType(TextField).last;
    final Finder addButton = find.byType(TextButton).first;

    await tester.enterText(titleInput, "taskA ");
    await tester.pumpAndSettle();
    await tester.enterText(descriptionInput, "description A");
    await tester.pumpAndSettle();
    await tester.tap(addButton);
    await tester.pumpAndSettle(
      const Duration(seconds: 2),
    );

    final Finder checkbox = find.byType(Checkbox).first;
    final Finder task = find.byType(ListTile).first;

    await tester.tap(checkbox);
    await tester.pumpAndSettle();

    await tester.longPress(task);
    await tester.pumpAndSettle(
      const Duration(seconds: 2),
    );

    await tester.enterText(titleInput, "pizza");
    await tester.pumpAndSettle();
    await tester.enterText(descriptionInput, "this my pizza");
    await tester.pumpAndSettle();
    await tester.tap(addButton);
    await tester.pumpAndSettle(
      const Duration(seconds: 3),
    );

    final Finder closeButton = find.byIcon(Icons.close).first;
    await tester.tap(closeButton);
    await tester.pumpAndSettle(
      const Duration(seconds: 2),
    );
  });
}
