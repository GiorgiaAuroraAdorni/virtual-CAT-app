import 'package:cross_array_task_app/Activity/GestureBased/cross.dart';
import 'package:cross_array_task_app/Activity/GestureBased/gesture_based_home.dart';
import 'package:cross_array_task_app/Activity/GestureBased/parameters.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Test home creation', (WidgetTester tester) async {
    await initializeTest(tester);

    expect(find.byType(GestureImplementation), findsOneWidget);
    expect(find.byType(CrossWidget), findsOneWidget);

    final imageWidget = find.byType(Image).evaluate().single.widget as Image;
    if (imageWidget.image is AssetImage) {
      final temp = imageWidget.image as AssetImage;
      expect(temp.assetName, 'resources/sequence/image/S1.png');
    }
  });

  testWidgets('Test color selection button', (WidgetTester tester) async {
    await initializeTest(tester);

    var finderColorButtons = {
      'blue': find.byKey(const Key('ColorButtonBlue')),
      'red': find.byKey(const Key('ColorButtonRed')),
      'green': find.byKey(const Key('ColorButtonGreen')),
      'yellow': find.byKey(const Key('ColorButtonYellow')),
    };

    var i = 0;
    for (var k in finderColorButtons.keys) {
      Finder finder = finderColorButtons[k] as Finder;
      var current = finder.evaluate().single.widget as CupertinoButton;
      expect(finder, findsOneWidget);
      expect(current.child.toString(), const Text('').toString());
      await tester.tap(finder);
      await tester.pump();
      i += 1;
      current = finder.evaluate().single.widget as CupertinoButton;
      expect(find.byIcon(CupertinoIcons.circle_fill), findsNWidgets(i));
    }
  });

  // testWidgets('Reset cross test', (WidgetTester tester) async {
  //   await initializeTest(tester);
  //   expect(find.byType(CrossWidget), findsOneWidget);
  //   var cross = find.byType(CrossWidget).evaluate().single.widget as CrossWidget;
  //   var crossKeyNumber = cross.key.toString().split(' ')[1].split(']')[0];
  //   expect(crossKeyNumber, '1');
  //
  //   await tester.tap(find.widgetWithText(CupertinoButton, 'Reset cross'));
  //   await tester.pump();
  //   cross = find.byType(CrossWidget).evaluate().single.widget as CrossWidget;
  //   expect(find.byType(CrossWidget), findsOneWidget);
  //   crossKeyNumber = cross.key.toString().split(' ')[1].split(']')[0];
  //   expect(crossKeyNumber, '2');
  // });

  // testWidgets('Change selection mode test', (WidgetTester tester) async {
  //   await initializeTest(tester);
  //   var buttonFinder =find.byKey(const Key('Selection mode'));
  //   expect(buttonFinder, findsOneWidget);
  //   var button = buttonFinder.evaluate().single.widget as CupertinoButton;
  //   var text = button.child;
  //   expect(text.toString(), const Text('Multiple selection').toString());
  //
  //   await tester.tap(buttonFinder);
  //   await tester.pump();
  //   button = buttonFinder.evaluate().single.widget as CupertinoButton;
  //   text = button.child;
  //   expect(buttonFinder, findsOneWidget);
  //   expect(text.toString(), const Text('Single selection').toString());
  // });

  testWidgets('Change visibility test', (WidgetTester tester) async {
    await initializeTest(tester);
    var buttonFinder = find.byKey(const Key('Visibility Button'));
    expect(buttonFinder, findsOneWidget);
    var button = buttonFinder.evaluate().single.widget as CupertinoButton;
    expect(button.child.toString(),
        const Icon(CupertinoIcons.eye_fill, size: 40.0).toString());

    await tester.tap(buttonFinder);
    await tester.pump();
    expect(buttonFinder, findsOneWidget);
    button = buttonFinder.evaluate().single.widget as CupertinoButton;
    expect(button.child.toString(),
        const Icon(CupertinoIcons.eye_slash_fill, size: 40.0).toString());
  });

  testWidgets('Confirm e delete selection button test',
      (WidgetTester tester) async {
    // expect(actual, matcher);
  });
}

/// It sets the size of the screen to the size of an iPad Pro, and then it pumps a
/// CupertinoApp with a GestureImplementation widget as its home
///
/// Args:
///   tester (WidgetTester): The WidgetTester object that is used to test the
/// widget.
Future<void> initializeTest(WidgetTester tester) async {
  await tester.binding.setSurfaceSize(const Size(2224, 1668));
  await tester.pumpWidget(CupertinoApp(
      home: GestureImplementation(
        globalKey: GlobalKey<GestureImplementationState>(debugLabel: 'testing'),
        params: Parameters(),
      ),
      theme: const CupertinoThemeData(
        brightness: Brightness.light,
        primaryColor: CupertinoColors.systemOrange,
      )));
}