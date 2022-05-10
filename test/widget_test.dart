// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// Utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:cross_array_task_app/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Test tab bar elements', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Amministrazione'), findsOneWidget);
    expect(find.byIcon(CupertinoIcons.lock_circle), findsOneWidget);
    expect(find.text('Tutorial'), findsOneWidget);
    expect(find.byIcon(CupertinoIcons.play_rectangle), findsOneWidget);
    expect(find.text('Attività'), findsOneWidget);
    expect(find.byIcon(CupertinoIcons.game_controller), findsOneWidget);

    // // Tap the '+' icon and trigger a frame.
    // await tester.tap(find.byIcon(Icons.add));
    // await tester.pump();
    //
    // // Verify that our counter has incremented.
    // expect(find.text('0'), findsNothing);
    // expect(find.text('1'), findsOneWidget);
  });

  testWidgets('Test school form elements', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    expect(find.text('Inserire i dati della sessione'), findsOneWidget);

    expect(find.text('Scuola:'), findsOneWidget);
    expect(
        find.widgetWithText(
            CupertinoTextFormFieldRow, 'Inserire il nome della scuola'),
        findsOneWidget);

    expect(find.text('Classe:'), findsOneWidget);
    expect(find.widgetWithText(CupertinoTextFormFieldRow, 'Inserire la classe'),
        findsOneWidget);

    expect(find.text('Sezione:'), findsOneWidget);
    expect(
        find.widgetWithText(CupertinoTextFormFieldRow, 'Inserire la sezione'),
        findsOneWidget);
  });
}
