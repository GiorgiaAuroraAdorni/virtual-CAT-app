import 'package:cross_array_task_app/Activity/GestureBased/analyzer.dart';
import 'package:cross_array_task_app/Activity/GestureBased/cross_button.dart';
import 'package:cross_array_task_app/Activity/GestureBased/parameters.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tuple/tuple.dart';

void main() {
  group('Analyze pattern', () {
    final Map buttons = {};

    for (String y in ['a', 'b', 'c', 'd', 'e', 'f']) {
      buttons[y] = {};
      List<int> possibleXs = [];
      if (['a', 'b', 'e', 'f'].contains(y)) {
        possibleXs = [3, 4];
        buttons[y][1] = null;
        buttons[y][2] = null;
        buttons[y][5] = null;
        buttons[y][6] = null;
      } else {
        possibleXs = [1, 2, 3, 4, 5, 6];
      }
      for (int x in possibleXs) {
        buttons[y][x] = CrossButton(
            globalKey: GlobalKey<CrossButtonState>(),
            position: Tuple2<String, int>(y, x),
            params: Parameters.forAnalyzerTest(),
            buttonDimension: 10.0);
      }
    }

    final List<CupertinoDynamicColor> nextColors = [CupertinoColors.systemBlue, CupertinoColors.systemRed, CupertinoColors.systemGreen, CupertinoColors.systemYellow];
    group('Empty result', () {
      test('Empty List', () {
        expect(Analyzer().analyzePattern([], nextColors), []);
      });
      test('One element List', () {
        expect(Analyzer().analyzePattern([buttons['a'][3]], nextColors), []);
      });
      test('No existing command', () {
        expect(
            Analyzer().analyzePattern(
                [buttons['a'][3], buttons['b'][3], buttons['c'][4]], nextColors),
            []);
      });
    });

    group('Horizontal', () {
      group('right', () {
        test('2', () {
          expect(Analyzer().analyzePattern([buttons['f'][3], buttons['f'][4]], nextColors),
              ['right']);
        });
        test('3', () {
          expect(
              Analyzer().analyzePattern(
                  [buttons['c'][1], buttons['c'][2], buttons['c'][3]], nextColors),
              ['right']);
        });
        test('4', () {
          expect(
              Analyzer().analyzePattern([
                buttons['c'][1],
                buttons['c'][2],
                buttons['c'][3],
                buttons['c'][4]
              ], nextColors),
              ['right']);
        });
        test('5', () {
          expect(
              Analyzer().analyzePattern([
                buttons['c'][1],
                buttons['c'][2],
                buttons['c'][3],
                buttons['c'][4],
                buttons['c'][5]
              ], nextColors),
              ['right']);
        });
        test('6', () {
          expect(
              Analyzer().analyzePattern([
                buttons['c'][1],
                buttons['c'][2],
                buttons['c'][3],
                buttons['c'][4],
                buttons['c'][5],
                buttons['c'][6]
              ], nextColors),
              ['right']);
          expect(
              Analyzer().analyzeNumberOfCell([
                buttons['c'][1],
                buttons['c'][2],
                buttons['c'][3],
                buttons['c'][4],
                buttons['c'][5],
                buttons['c'][6]
              ], 'right'),
              ':');
        });
      });
      group('left', () {
        test('2', () {
          expect(Analyzer().analyzePattern([buttons['a'][4], buttons['a'][3]], nextColors),
              ['left']);
        });
        test('3', () {
          expect(
              Analyzer().analyzePattern(
                  [buttons['d'][3], buttons['d'][2], buttons['d'][1]], nextColors),
              ['left']);
        });
        test('4', () {
          expect(
              Analyzer().analyzePattern([
                buttons['d'][4],
                buttons['d'][3],
                buttons['d'][2],
                buttons['d'][1]
              ], nextColors),
              ['left']);
        });
        test('5', () {
          expect(
              Analyzer().analyzePattern([
                buttons['d'][5],
                buttons['d'][4],
                buttons['d'][3],
                buttons['d'][2],
                buttons['d'][1]
              ], nextColors),
              ['left']);
        });
        test('6', () {
          expect(
              Analyzer().analyzePattern([
                buttons['d'][6],
                buttons['d'][5],
                buttons['d'][4],
                buttons['d'][3],
                buttons['d'][2],
                buttons['d'][1]
              ], nextColors),
              ['left']);
          expect(
              Analyzer().analyzeNumberOfCell([
                buttons['d'][6],
                buttons['d'][5],
                buttons['d'][4],
                buttons['d'][3],
                buttons['d'][2],
                buttons['d'][1]
              ], 'left'),
              ':');
        });
      });
    });

    group('Vertical', () {
      group('up', () {
        test('2', () {
          expect(Analyzer().analyzePattern([buttons['a'][3], buttons['b'][3]], nextColors),
              ['up']);
        });
        test('3', () {
          expect(
              Analyzer().analyzePattern(
                  [buttons['a'][3], buttons['b'][3], buttons['c'][3]], nextColors),
              ['up']);
        });
        test('4', () {
          expect(
              Analyzer().analyzePattern([
                buttons['a'][3],
                buttons['b'][3],
                buttons['c'][3],
                buttons['d'][3]
              ], nextColors),
              ['up']);
        });
        test('5', () {
          expect(
              Analyzer().analyzePattern([
                buttons['a'][3],
                buttons['b'][3],
                buttons['c'][3],
                buttons['d'][3],
                buttons['e'][3]
              ], nextColors),
              ['up']);
        });
        test('6', () {
          expect(
              Analyzer().analyzePattern([
                buttons['a'][3],
                buttons['b'][3],
                buttons['c'][3],
                buttons['d'][3],
                buttons['e'][3],
                buttons['f'][3]
              ], nextColors),
              ['up']);
          expect(
              Analyzer().analyzeNumberOfCell([
                buttons['a'][3],
                buttons['b'][3],
                buttons['c'][3],
                buttons['d'][3],
                buttons['e'][3],
                buttons['f'][3]
              ], 'up'),
              ':');
        });
      });
      group('down', () {
        test('2', () {
          expect(Analyzer().analyzePattern([buttons['d'][1], buttons['c'][1]], nextColors),
              ['down']);
        });
        test('3', () {
          expect(
              Analyzer().analyzePattern(
                  [buttons['f'][4], buttons['e'][4], buttons['d'][4]], nextColors),
              ['down']);
        });
        test('4', () {
          expect(
              Analyzer().analyzePattern([
                buttons['f'][4],
                buttons['e'][4],
                buttons['d'][4],
                buttons['c'][4]
              ], nextColors),
              ['down']);
        });
        test('5', () {
          expect(
              Analyzer().analyzePattern([
                buttons['f'][4],
                buttons['e'][4],
                buttons['d'][4],
                buttons['c'][4],
                buttons['b'][4]
              ], nextColors),
              ['down']);
        });
        test('6', () {
          expect(
              Analyzer().analyzePattern([
                buttons['f'][4],
                buttons['e'][4],
                buttons['d'][4],
                buttons['c'][4],
                buttons['b'][4],
                buttons['a'][4]
              ], nextColors),
              ['down']);
          expect(
              Analyzer().analyzeNumberOfCell([
                buttons['f'][4],
                buttons['e'][4],
                buttons['d'][4],
                buttons['c'][4],
                buttons['b'][4],
                buttons['a'][4]
              ], 'down'),
              ':');
        });
      });
    });

    group('diagonal', () {
      group('up left', () {
        test('2', () {
          expect(Analyzer().analyzePattern([buttons['a'][3], buttons['c'][1]], nextColors),
              ['diagonal up left']);
          expect(
              Analyzer().analyzeNumberOfCell(
                  [buttons['a'][3], buttons['c'][1]], 'diagonal up left'),
              ':');
        });
        test('3', () {
          expect(
              Analyzer().analyzePattern(
                  [buttons['b'][4], buttons['c'][3], buttons['d'][2]], nextColors),
              ['diagonal up left']);
          expect(
              Analyzer().analyzeNumberOfCell([
                buttons['b'][4],
                buttons['c'][3],
                buttons['d'][2],
              ], 'diagonal up left'),
              ':');
        });
        test('4', () {
          expect(
              Analyzer().analyzePattern([
                buttons['c'][6],
                buttons['d'][5],
                buttons['e'][4],
                buttons['f'][3]
              ], nextColors),
              ['diagonal up left']);
          expect(
              Analyzer().analyzeNumberOfCell([
                buttons['c'][6],
                buttons['d'][5],
                buttons['e'][4],
                buttons['f'][3]
              ], 'diagonal up left'),
              ':');
        });
      });
      group('up right', () {
        test('2', () {
          expect(Analyzer().analyzePattern([buttons['d'][1], buttons['f'][3]], nextColors),
              ['diagonal up right']);
          expect(
              Analyzer().analyzeNumberOfCell(
                  [buttons['d'][1], buttons['f'][3]], 'diagonal up right'),
              ':');
        });
        test('3', () {
          expect(
              Analyzer().analyzePattern(
                  [buttons['c'][2], buttons['d'][3], buttons['e'][4]], nextColors),
              ['diagonal up right']);
          expect(
              Analyzer().analyzeNumberOfCell(
                  [buttons['c'][2], buttons['d'][3], buttons['e'][4]],
                  'diagonal up right'),
              ':');
        });
        test('4', () {
          expect(
              Analyzer().analyzePattern([
                buttons['a'][3],
                buttons['b'][4],
                buttons['c'][5],
                buttons['d'][6]
              ], nextColors),
              ['diagonal up right']);
          expect(
              Analyzer().analyzeNumberOfCell([
                buttons['a'][3],
                buttons['b'][4],
                buttons['c'][5],
                buttons['d'][6]
              ], 'diagonal up right'),
              ':');
        });
      });
      group('down left', () {
        test('2', () {
          expect(Analyzer().analyzePattern([buttons['c'][6], buttons['a'][4]], nextColors),
              ['diagonal down left']);
          expect(
              Analyzer().analyzeNumberOfCell(
                  [buttons['c'][6], buttons['a'][4]], 'diagonal down left'),
              ':');
        });
        test('3', () {
          expect(
              Analyzer().analyzePattern(
                  [buttons['d'][5], buttons['c'][4], buttons['b'][3]], nextColors),
              ['diagonal down left']);
          expect(
              Analyzer().analyzeNumberOfCell(
                  [buttons['d'][5], buttons['c'][4], buttons['b'][3]],
                  'diagonal down left'),
              ':');
        });
        test('4', () {
          expect(
              Analyzer().analyzePattern([
                buttons['f'][4],
                buttons['e'][3],
                buttons['d'][2],
                buttons['c'][1]
              ], nextColors),
              ['diagonal down left']);
          expect(
              Analyzer().analyzeNumberOfCell([
                buttons['f'][4],
                buttons['e'][3],
                buttons['d'][2],
                buttons['c'][1]
              ], 'diagonal down left'),
              ':');
        });
      });
      group('down right', () {
        test('2', () {
          expect(Analyzer().analyzePattern([buttons['c'][1], buttons['a'][3]], nextColors),
              ['diagonal down right']);
          expect(
              Analyzer().analyzeNumberOfCell(
                  [buttons['c'][1], buttons['a'][3]], 'diagonal down right'),
              ':');
        });
        test('3', () {
          expect(
              Analyzer().analyzePattern(
                  [buttons['e'][3], buttons['d'][4], buttons['c'][5]], nextColors),
              ['diagonal down right']);
          expect(
              Analyzer().analyzeNumberOfCell(
                  [buttons['e'][3], buttons['d'][4], buttons['c'][5]],
                  'diagonal down right'),
              ':');
        });
        test('4', () {
          expect(
              Analyzer().analyzePattern([
                buttons['f'][3],
                buttons['e'][4],
                buttons['d'][5],
                buttons['c'][6]
              ], nextColors),
              ['diagonal down right']);
          expect(
              Analyzer().analyzeNumberOfCell([
                buttons['f'][3],
                buttons['e'][4],
                buttons['d'][5],
                buttons['c'][6]
              ], 'diagonal down right'),
              ':');
        });
      });
    });

    group('square', () {
      group('counterclockwise', () {
        test('right up left down', () {
          expect(
              Analyzer().analyzePattern([
                buttons['a'][3],
                buttons['a'][4],
                buttons['b'][4],
                buttons['b'][3]
              ], nextColors),
              ['square']);
          expect(
              Analyzer().analyzePattern([
                buttons['b'][3],
                buttons['b'][4],
                buttons['c'][4],
                buttons['c'][3]
              ], nextColors),
              ['square']);
          expect(
              Analyzer().analyzePattern([
                buttons['c'][1],
                buttons['c'][2],
                buttons['d'][2],
                buttons['d'][1]
              ], nextColors),
              ['square']);
          expect(
              Analyzer().analyzePattern([
                buttons['c'][2],
                buttons['c'][3],
                buttons['d'][3],
                buttons['d'][2]
              ], nextColors),
              ['square']);
          expect(
              Analyzer().analyzePattern([
                buttons['c'][3],
                buttons['c'][4],
                buttons['d'][4],
                buttons['d'][3]
              ], nextColors),
              ['square']);
          expect(
              Analyzer().analyzePattern([
                buttons['c'][4],
                buttons['c'][5],
                buttons['d'][5],
                buttons['d'][4]
              ], nextColors),
              ['square']);
          expect(
              Analyzer().analyzePattern([
                buttons['c'][5],
                buttons['c'][6],
                buttons['d'][6],
                buttons['d'][5]
              ], nextColors),
              ['square']);
          expect(
              Analyzer().analyzePattern([
                buttons['d'][3],
                buttons['d'][4],
                buttons['e'][4],
                buttons['e'][3]
              ], nextColors),
              ['square']);
          expect(
              Analyzer().analyzePattern([
                buttons['e'][3],
                buttons['e'][4],
                buttons['f'][4],
                buttons['f'][3]
              ], nextColors),
              ['square']);
          expect(
              Analyzer().analyzeNumberOfCell([
                buttons['e'][3],
                buttons['e'][4],
                buttons['f'][4],
                buttons['f'][3]
              ], 'square'),
              ':');
        });
        test('up left down right', () {
          expect(
              Analyzer().analyzePattern([
                buttons['a'][4],
                buttons['b'][4],
                buttons['b'][3],
                buttons['a'][3]
              ], nextColors),
              ['square']);
          expect(
              Analyzer().analyzePattern([
                buttons['b'][4],
                buttons['c'][4],
                buttons['c'][3],
                buttons['b'][3]
              ], nextColors),
              ['square']);
          expect(
              Analyzer().analyzePattern([
                buttons['c'][2],
                buttons['d'][2],
                buttons['d'][1],
                buttons['c'][1]
              ], nextColors),
              ['square']);
          expect(
              Analyzer().analyzePattern([
                buttons['c'][3],
                buttons['d'][3],
                buttons['d'][2],
                buttons['c'][2]
              ], nextColors),
              ['square']);
          expect(
              Analyzer().analyzePattern([
                buttons['c'][4],
                buttons['d'][4],
                buttons['d'][3],
                buttons['c'][3]
              ], nextColors),
              ['square']);
          expect(
              Analyzer().analyzePattern([
                buttons['c'][5],
                buttons['d'][5],
                buttons['d'][4],
                buttons['c'][4]
              ], nextColors),
              ['square']);
          expect(
              Analyzer().analyzePattern([
                buttons['c'][6],
                buttons['d'][6],
                buttons['d'][5],
                buttons['c'][5]
              ], nextColors),
              ['square']);
          expect(
              Analyzer().analyzePattern([
                buttons['d'][4],
                buttons['e'][4],
                buttons['e'][3],
                buttons['d'][3]
              ], nextColors),
              ['square']);
          expect(
              Analyzer().analyzePattern([
                buttons['e'][4],
                buttons['f'][4],
                buttons['f'][3],
                buttons['e'][3]
              ], nextColors),
              ['square']);
          expect(
              Analyzer().analyzeNumberOfCell([
                buttons['e'][4],
                buttons['f'][4],
                buttons['f'][3],
                buttons['e'][3]
              ], 'square'),
              ':');
        });
        test('left down right up', () {
          expect(
              Analyzer().analyzePattern([
                buttons['b'][4],
                buttons['b'][3],
                buttons['a'][3],
                buttons['a'][4]
              ], nextColors),
              ['square']);
          expect(
              Analyzer().analyzePattern([
                buttons['c'][4],
                buttons['c'][3],
                buttons['b'][3],
                buttons['b'][4]
              ], nextColors),
              ['square']);
          expect(
              Analyzer().analyzePattern([
                buttons['d'][2],
                buttons['d'][1],
                buttons['c'][1],
                buttons['c'][2]
              ], nextColors),
              ['square']);
          expect(
              Analyzer().analyzePattern([
                buttons['d'][3],
                buttons['d'][2],
                buttons['c'][2],
                buttons['c'][3]
              ], nextColors),
              ['square']);
          expect(
              Analyzer().analyzePattern([
                buttons['d'][4],
                buttons['d'][3],
                buttons['c'][3],
                buttons['c'][4]
              ], nextColors),
              ['square']);
          expect(
              Analyzer().analyzePattern([
                buttons['d'][5],
                buttons['d'][4],
                buttons['c'][4],
                buttons['c'][5]
              ], nextColors),
              ['square']);
          expect(
              Analyzer().analyzePattern([
                buttons['d'][6],
                buttons['d'][5],
                buttons['c'][5],
                buttons['c'][6]
              ], nextColors),
              ['square']);
          expect(
              Analyzer().analyzePattern([
                buttons['e'][4],
                buttons['e'][3],
                buttons['d'][3],
                buttons['d'][4]
              ], nextColors),
              ['square']);
          expect(
              Analyzer().analyzePattern([
                buttons['f'][4],
                buttons['f'][3],
                buttons['e'][3],
                buttons['e'][4]
              ], nextColors),
              ['square']);
          expect(
              Analyzer().analyzeNumberOfCell([
                buttons['f'][4],
                buttons['f'][3],
                buttons['e'][3],
                buttons['e'][4]
              ], 'square'),
              ':');
        });
        test('down right up left', () {
          expect(
              Analyzer().analyzePattern([
                buttons['b'][3],
                buttons['a'][3],
                buttons['a'][4],
                buttons['b'][4]
              ], nextColors),
              ['square']);
          expect(
              Analyzer().analyzePattern([
                buttons['c'][3],
                buttons['b'][3],
                buttons['b'][4],
                buttons['c'][4]
              ], nextColors),
              ['square']);
          expect(
              Analyzer().analyzePattern([
                buttons['d'][1],
                buttons['c'][1],
                buttons['c'][2],
                buttons['d'][2]
              ], nextColors),
              ['square']);
          expect(
              Analyzer().analyzePattern([
                buttons['d'][2],
                buttons['c'][2],
                buttons['c'][3],
                buttons['d'][3]
              ], nextColors),
              ['square']);
          expect(
              Analyzer().analyzePattern([
                buttons['d'][3],
                buttons['c'][3],
                buttons['c'][4],
                buttons['d'][4]
              ], nextColors),
              ['square']);
          expect(
              Analyzer().analyzePattern([
                buttons['d'][4],
                buttons['c'][4],
                buttons['c'][5],
                buttons['d'][5]
              ], nextColors),
              ['square']);
          expect(
              Analyzer().analyzePattern([
                buttons['d'][5],
                buttons['c'][5],
                buttons['c'][6],
                buttons['d'][6]
              ], nextColors),
              ['square']);
          expect(
              Analyzer().analyzePattern([
                buttons['e'][3],
                buttons['d'][3],
                buttons['d'][4],
                buttons['e'][4]
              ], nextColors),
              ['square']);
          expect(
              Analyzer().analyzePattern([
                buttons['f'][3],
                buttons['e'][3],
                buttons['e'][4],
                buttons['f'][4]
              ], nextColors),
              ['square']);
          expect(
              Analyzer().analyzeNumberOfCell([
                buttons['f'][3],
                buttons['e'][3],
                buttons['e'][4],
                buttons['f'][4]
              ], 'square'),
              ':');
        });
      });
      group('clockwise', () {
        test('right down left up', () {
          expect(
              Analyzer().analyzePattern([
                buttons['b'][3],
                buttons['b'][4],
                buttons['a'][4],
                buttons['a'][3]
              ], nextColors),
              ['square']);
          expect(
              Analyzer().analyzePattern([
                buttons['c'][3],
                buttons['c'][4],
                buttons['b'][4],
                buttons['b'][3]
              ], nextColors),
              ['square']);
          expect(
              Analyzer().analyzePattern([
                buttons['d'][1],
                buttons['d'][2],
                buttons['c'][2],
                buttons['c'][1]
              ], nextColors),
              ['square']);
          expect(
              Analyzer().analyzePattern([
                buttons['d'][2],
                buttons['d'][3],
                buttons['c'][3],
                buttons['c'][2]
              ], nextColors),
              ['square']);
          expect(
              Analyzer().analyzePattern([
                buttons['d'][3],
                buttons['d'][4],
                buttons['c'][4],
                buttons['c'][3]
              ], nextColors),
              ['square']);
          expect(
              Analyzer().analyzePattern([
                buttons['d'][4],
                buttons['d'][5],
                buttons['c'][5],
                buttons['c'][4]
              ], nextColors),
              ['square']);
          expect(
              Analyzer().analyzePattern([
                buttons['d'][5],
                buttons['d'][6],
                buttons['c'][6],
                buttons['c'][5]
              ], nextColors),
              ['square']);
          expect(
              Analyzer().analyzePattern([
                buttons['e'][3],
                buttons['e'][4],
                buttons['d'][4],
                buttons['d'][3]
              ], nextColors),
              ['square']);
          expect(
              Analyzer().analyzePattern([
                buttons['f'][3],
                buttons['f'][4],
                buttons['e'][4],
                buttons['e'][3]
              ], nextColors),
              ['square']);
          expect(
              Analyzer().analyzeNumberOfCell([
                buttons['f'][3],
                buttons['f'][4],
                buttons['e'][4],
                buttons['e'][3]
              ], 'square'),
              ':');
        });
        test('down left up right', () {
          expect(
              Analyzer().analyzePattern([
                buttons['b'][4],
                buttons['a'][4],
                buttons['a'][3],
                buttons['b'][3]
              ], nextColors),
              ['square']);
          expect(
              Analyzer().analyzePattern([
                buttons['c'][4],
                buttons['b'][4],
                buttons['b'][3],
                buttons['c'][3]
              ], nextColors),
              ['square']);
          expect(
              Analyzer().analyzePattern([
                buttons['d'][2],
                buttons['c'][2],
                buttons['c'][1],
                buttons['d'][1]
              ], nextColors),
              ['square']);
          expect(
              Analyzer().analyzePattern([
                buttons['d'][3],
                buttons['c'][3],
                buttons['c'][2],
                buttons['d'][2]
              ], nextColors),
              ['square']);
          expect(
              Analyzer().analyzePattern([
                buttons['d'][4],
                buttons['c'][4],
                buttons['c'][3],
                buttons['d'][3]
              ], nextColors),
              ['square']);
          expect(
              Analyzer().analyzePattern([
                buttons['d'][5],
                buttons['c'][5],
                buttons['c'][4],
                buttons['d'][4]
              ], nextColors),
              ['square']);
          expect(
              Analyzer().analyzePattern([
                buttons['d'][6],
                buttons['c'][6],
                buttons['c'][5],
                buttons['d'][5]
              ], nextColors),
              ['square']);
          expect(
              Analyzer().analyzePattern([
                buttons['e'][4],
                buttons['d'][4],
                buttons['d'][3],
                buttons['e'][3]
              ], nextColors),
              ['square']);
          expect(
              Analyzer().analyzePattern([
                buttons['f'][4],
                buttons['e'][4],
                buttons['e'][3],
                buttons['f'][3]
              ], nextColors),
              ['square']);
          expect(
              Analyzer().analyzeNumberOfCell([
                buttons['f'][4],
                buttons['e'][4],
                buttons['e'][3],
                buttons['f'][3]
              ], 'square'),
              ':');
        });
        test('left up right down', () {
          expect(
              Analyzer().analyzePattern([
                buttons['a'][4],
                buttons['a'][3],
                buttons['b'][3],
                buttons['b'][4]
              ], nextColors),
              ['square']);
          expect(
              Analyzer().analyzePattern([
                buttons['b'][4],
                buttons['b'][3],
                buttons['c'][3],
                buttons['c'][4]
              ], nextColors),
              ['square']);
          expect(
              Analyzer().analyzePattern([
                buttons['c'][2],
                buttons['c'][1],
                buttons['d'][1],
                buttons['d'][2]
              ], nextColors),
              ['square']);
          expect(
              Analyzer().analyzePattern([
                buttons['c'][3],
                buttons['c'][2],
                buttons['d'][2],
                buttons['d'][3]
              ], nextColors),
              ['square']);
          expect(
              Analyzer().analyzePattern([
                buttons['c'][4],
                buttons['c'][3],
                buttons['d'][3],
                buttons['d'][4]
              ], nextColors),
              ['square']);
          expect(
              Analyzer().analyzePattern([
                buttons['c'][5],
                buttons['c'][4],
                buttons['d'][4],
                buttons['d'][5]
              ], nextColors),
              ['square']);
          expect(
              Analyzer().analyzePattern([
                buttons['c'][6],
                buttons['c'][5],
                buttons['d'][5],
                buttons['d'][6]
              ], nextColors),
              ['square']);
          expect(
              Analyzer().analyzePattern([
                buttons['d'][4],
                buttons['d'][3],
                buttons['e'][3],
                buttons['e'][4]
              ], nextColors),
              ['square']);
          expect(
              Analyzer().analyzePattern([
                buttons['e'][4],
                buttons['e'][3],
                buttons['f'][3],
                buttons['f'][4]
              ], nextColors),
              ['square']);
          expect(
              Analyzer().analyzeNumberOfCell([
                buttons['e'][4],
                buttons['e'][3],
                buttons['f'][3],
                buttons['f'][4]
              ], 'square'),
              ':');
        });
        test('up right down left', () {
          expect(
              Analyzer().analyzePattern([
                buttons['a'][3],
                buttons['b'][3],
                buttons['b'][4],
                buttons['a'][4]
              ], nextColors),
              ['square']);
          expect(
              Analyzer().analyzePattern([
                buttons['b'][3],
                buttons['c'][3],
                buttons['c'][4],
                buttons['b'][4]
              ], nextColors),
              ['square']);
          expect(
              Analyzer().analyzePattern([
                buttons['c'][1],
                buttons['d'][1],
                buttons['d'][2],
                buttons['c'][2]
              ], nextColors),
              ['square']);
          expect(
              Analyzer().analyzePattern([
                buttons['c'][2],
                buttons['d'][2],
                buttons['d'][3],
                buttons['c'][3]
              ], nextColors),
              ['square']);
          expect(
              Analyzer().analyzePattern([
                buttons['c'][3],
                buttons['d'][3],
                buttons['d'][4],
                buttons['c'][4]
              ], nextColors),
              ['square']);
          expect(
              Analyzer().analyzePattern([
                buttons['c'][4],
                buttons['d'][4],
                buttons['d'][5],
                buttons['c'][5]
              ], nextColors),
              ['square']);
          expect(
              Analyzer().analyzePattern([
                buttons['c'][5],
                buttons['d'][5],
                buttons['d'][6],
                buttons['c'][6]
              ], nextColors),
              ['square']);
          expect(
              Analyzer().analyzePattern([
                buttons['d'][3],
                buttons['e'][3],
                buttons['e'][4],
                buttons['d'][4]
              ], nextColors),
              ['square']);
          expect(
              Analyzer().analyzePattern([
                buttons['e'][3],
                buttons['f'][3],
                buttons['f'][4],
                buttons['e'][4]
              ], nextColors),
              ['square']);
          expect(
              Analyzer().analyzeNumberOfCell([
                buttons['e'][3],
                buttons['f'][3],
                buttons['f'][4],
                buttons['e'][4]
              ], 'square'),
              ':');
        });
      });
    });

    group('L', () {
      test('up left', () {
        expect(
            Analyzer().analyzePattern([
              buttons['a'][3],
              buttons['b'][3],
              buttons['c'][3],
              buttons['c'][2],
              buttons['c'][1]
            ], nextColors),
            ['L up left']);
        expect(
            Analyzer().analyzeNumberOfCell([
              buttons['a'][3],
              buttons['b'][3],
              buttons['c'][3],
              buttons['c'][2],
              buttons['c'][1]
            ], 'L up left'),
            ':');
      });
      test('up right', () {
        expect(
            Analyzer().analyzePattern([
              buttons['a'][4],
              buttons['b'][4],
              buttons['c'][4],
              buttons['c'][5],
              buttons['c'][6]
            ], nextColors),
            ['L up right']);
        expect(
            Analyzer().analyzeNumberOfCell([
              buttons['a'][4],
              buttons['b'][4],
              buttons['c'][4],
              buttons['c'][5],
              buttons['c'][6]
            ], 'L up right'),
            ':');
      });
      test('down left', () {
        expect(
            Analyzer().analyzePattern([
              buttons['f'][3],
              buttons['e'][3],
              buttons['d'][3],
              buttons['d'][2],
              buttons['d'][1]
            ], nextColors),
            ['L down left']);
        expect(
            Analyzer().analyzeNumberOfCell([
              buttons['f'][3],
              buttons['e'][3],
              buttons['d'][3],
              buttons['d'][2],
              buttons['d'][1]
            ], 'L down left'),
            ':');
      });
      test('down right', () {
        expect(
            Analyzer().analyzePattern([
              buttons['f'][4],
              buttons['e'][4],
              buttons['d'][4],
              buttons['d'][5],
              buttons['d'][6]
            ], nextColors),
            ['L down right']);
        expect(
            Analyzer().analyzeNumberOfCell([
              buttons['f'][4],
              buttons['e'][4],
              buttons['d'][4],
              buttons['d'][5],
              buttons['d'][6]
            ], 'L down right'),
            ':');
      });
      test('left up', () {
        expect(
            Analyzer().analyzePattern([
              buttons['d'][6],
              buttons['d'][5],
              buttons['d'][4],
              buttons['e'][4],
              buttons['f'][4]
            ], nextColors),
            ['L left up']);
        expect(
            Analyzer().analyzeNumberOfCell([
              buttons['d'][6],
              buttons['d'][5],
              buttons['d'][4],
              buttons['e'][4],
              buttons['f'][4]
            ], 'L left up'),
            ':');
      });
      test('left down', () {
        expect(
            Analyzer().analyzePattern([
              buttons['c'][6],
              buttons['c'][5],
              buttons['c'][4],
              buttons['b'][4],
              buttons['a'][4]
            ], nextColors),
            ['L left down']);
        expect(
            Analyzer().analyzeNumberOfCell([
              buttons['c'][6],
              buttons['c'][5],
              buttons['c'][4],
              buttons['b'][4],
              buttons['a'][4]
            ], 'L left down'),
            ':');
      });
      test('right up', () {
        expect(
            Analyzer().analyzePattern([
              buttons['d'][1],
              buttons['d'][2],
              buttons['d'][3],
              buttons['e'][3],
              buttons['f'][3]
            ], nextColors),
            ['L right up']);
        expect(
            Analyzer().analyzeNumberOfCell([
              buttons['d'][1],
              buttons['d'][2],
              buttons['d'][3],
              buttons['e'][3],
              buttons['f'][3]
            ], 'L right up'),
            ':');
      });
      test('right down', () {
        expect(
            Analyzer().analyzePattern([
              buttons['c'][1],
              buttons['c'][2],
              buttons['c'][3],
              buttons['b'][3],
              buttons['a'][3]
            ], nextColors),
            ['L right down']);
        expect(
            Analyzer().analyzeNumberOfCell([
              buttons['c'][1],
              buttons['c'][2],
              buttons['c'][3],
              buttons['b'][3],
              buttons['a'][3]
            ], 'L right down'),
            ':');
      });
    });

    group('zig-zag', () {
      group('left up down', () {
        test('3', () {
          expect(
              Analyzer().analyzePattern(
                  [buttons['c'][6], buttons['d'][5], buttons['c'][4]], nextColors),
              ['zig-zag left up down']);
          expect(
              Analyzer().analyzePattern(
                  [buttons['c'][5], buttons['d'][4], buttons['c'][3]], nextColors),
              ['zig-zag left up down']);
          expect(
              Analyzer().analyzePattern(
                  [buttons['c'][4], buttons['d'][3], buttons['c'][2]], nextColors),
              ['zig-zag left up down']);
          expect(
              Analyzer().analyzePattern(
                  [buttons['c'][3], buttons['d'][2], buttons['c'][1]], nextColors),
              ['zig-zag left up down']);
        });
        test('4', () {
          expect(
              Analyzer().analyzePattern([
                buttons['c'][6],
                buttons['d'][5],
                buttons['c'][4],
                buttons['d'][3]
              ], nextColors),
              ['zig-zag left up down']);
          expect(
              Analyzer().analyzePattern([
                buttons['c'][5],
                buttons['d'][4],
                buttons['c'][3],
                buttons['d'][2]
              ], nextColors),
              ['zig-zag left up down']);
          expect(
              Analyzer().analyzePattern([
                buttons['c'][4],
                buttons['d'][3],
                buttons['c'][2],
                buttons['d'][1]
              ], nextColors),
              ['zig-zag left up down']);
        });
        test('5', () {
          expect(
              Analyzer().analyzePattern([
                buttons['c'][6],
                buttons['d'][5],
                buttons['c'][4],
                buttons['d'][3],
                buttons['c'][2]
              ], nextColors),
              ['zig-zag left up down']);
          expect(
              Analyzer().analyzePattern([
                buttons['c'][5],
                buttons['d'][4],
                buttons['c'][3],
                buttons['d'][2],
                buttons['c'][1]
              ], nextColors),
              ['zig-zag left up down']);
        });
        test('6', () {
          expect(
              Analyzer().analyzePattern([
                buttons['c'][6],
                buttons['d'][5],
                buttons['c'][4],
                buttons['d'][3],
                buttons['c'][2],
                buttons['d'][1]
              ], nextColors),
              ['zig-zag left up down']);
        });
      });
      group('left down up', () {
        test('3', () {
          expect(
              Analyzer().analyzePattern(
                  [buttons['d'][6], buttons['c'][5], buttons['d'][4]], nextColors),
              ['zig-zag left down up']);
          expect(
              Analyzer().analyzePattern(
                  [buttons['d'][5], buttons['c'][4], buttons['d'][3]], nextColors),
              ['zig-zag left down up']);
          expect(
              Analyzer().analyzePattern(
                  [buttons['d'][4], buttons['c'][3], buttons['d'][2]], nextColors),
              ['zig-zag left down up']);
          expect(
              Analyzer().analyzePattern(
                  [buttons['d'][3], buttons['c'][2], buttons['d'][1]], nextColors),
              ['zig-zag left down up']);
        });
        test('4', () {
          expect(
              Analyzer().analyzePattern([
                buttons['d'][6],
                buttons['c'][5],
                buttons['d'][4],
                buttons['c'][3]
              ], nextColors),
              ['zig-zag left down up']);
          expect(
              Analyzer().analyzePattern([
                buttons['d'][5],
                buttons['c'][4],
                buttons['d'][3],
                buttons['c'][2]
              ], nextColors),
              ['zig-zag left down up']);
          expect(
              Analyzer().analyzePattern([
                buttons['d'][4],
                buttons['c'][3],
                buttons['d'][2],
                buttons['c'][1]
              ], nextColors),
              ['zig-zag left down up']);
        });
        test('5', () {
          expect(
              Analyzer().analyzePattern([
                buttons['d'][6],
                buttons['c'][5],
                buttons['d'][4],
                buttons['c'][3],
                buttons['d'][2]
              ], nextColors),
              ['zig-zag left down up']);
          expect(
              Analyzer().analyzePattern([
                buttons['d'][5],
                buttons['c'][4],
                buttons['d'][3],
                buttons['c'][2],
                buttons['d'][1]
              ], nextColors),
              ['zig-zag left down up']);
        });
        test('6', () {
          expect(
              Analyzer().analyzePattern([
                buttons['d'][6],
                buttons['c'][5],
                buttons['d'][4],
                buttons['c'][3],
                buttons['d'][2],
                buttons['c'][1]
              ], nextColors),
              ['zig-zag left down up']);
        });
      });
      group('right up down', () {
        test('3', () {
          expect(
              Analyzer().analyzePattern(
                  [buttons['c'][1], buttons['d'][2], buttons['c'][3]], nextColors),
              ['zig-zag right up down']);
          expect(
              Analyzer().analyzePattern(
                  [buttons['c'][2], buttons['d'][3], buttons['c'][4]], nextColors),
              ['zig-zag right up down']);
          expect(
              Analyzer().analyzePattern(
                  [buttons['c'][3], buttons['d'][4], buttons['c'][5]], nextColors),
              ['zig-zag right up down']);
          expect(
              Analyzer().analyzePattern(
                  [buttons['c'][4], buttons['d'][5], buttons['c'][6]], nextColors),
              ['zig-zag right up down']);
        });
        test('4', () {
          expect(
              Analyzer().analyzePattern([
                buttons['c'][1],
                buttons['d'][2],
                buttons['c'][3],
                buttons['d'][4]
              ], nextColors),
              ['zig-zag right up down']);
          expect(
              Analyzer().analyzePattern([
                buttons['c'][2],
                buttons['d'][3],
                buttons['c'][4],
                buttons['d'][5]
              ], nextColors),
              ['zig-zag right up down']);
          expect(
              Analyzer().analyzePattern([
                buttons['c'][3],
                buttons['d'][4],
                buttons['c'][5],
                buttons['d'][6]
              ], nextColors),
              ['zig-zag right up down']);
        });
        test('5', () {
          expect(
              Analyzer().analyzePattern([
                buttons['c'][1],
                buttons['d'][2],
                buttons['c'][3],
                buttons['d'][4],
                buttons['c'][5]
              ], nextColors),
              ['zig-zag right up down']);
          expect(
              Analyzer().analyzePattern([
                buttons['c'][2],
                buttons['d'][3],
                buttons['c'][4],
                buttons['d'][5],
                buttons['c'][6]
              ], nextColors),
              ['zig-zag right up down']);
        });
        test('6', () {
          expect(
              Analyzer().analyzePattern([
                buttons['c'][1],
                buttons['d'][2],
                buttons['c'][3],
                buttons['d'][4],
                buttons['c'][5],
                buttons['d'][6]
              ], nextColors),
              ['zig-zag right up down']);
        });
      });
      group('right down up', () {
        test('3', () {
          expect(
              Analyzer().analyzePattern(
                  [buttons['d'][1], buttons['c'][2], buttons['d'][3]], nextColors),
              ['zig-zag right down up']);
          expect(
              Analyzer().analyzePattern(
                  [buttons['d'][2], buttons['c'][3], buttons['d'][4]], nextColors),
              ['zig-zag right down up']);
          expect(
              Analyzer().analyzePattern(
                  [buttons['d'][3], buttons['c'][4], buttons['d'][5]], nextColors),
              ['zig-zag right down up']);
          expect(
              Analyzer().analyzePattern(
                  [buttons['d'][4], buttons['c'][5], buttons['d'][6]], nextColors),
              ['zig-zag right down up']);
        });
        test('4', () {
          expect(
              Analyzer().analyzePattern([
                buttons['d'][1],
                buttons['c'][2],
                buttons['d'][3],
                buttons['c'][4]
              ], nextColors),
              ['zig-zag right down up']);
          expect(
              Analyzer().analyzePattern([
                buttons['d'][2],
                buttons['c'][3],
                buttons['d'][4],
                buttons['c'][5]
              ], nextColors),
              ['zig-zag right down up']);
          expect(
              Analyzer().analyzePattern([
                buttons['d'][3],
                buttons['c'][4],
                buttons['d'][5],
                buttons['c'][6]
              ], nextColors),
              ['zig-zag right down up']);
        });
        test('5', () {
          expect(
              Analyzer().analyzePattern([
                buttons['d'][1],
                buttons['c'][2],
                buttons['d'][3],
                buttons['c'][4],
                buttons['d'][5]
              ], nextColors),
              ['zig-zag right down up']);
          expect(
              Analyzer().analyzePattern([
                buttons['d'][2],
                buttons['c'][3],
                buttons['d'][4],
                buttons['c'][5],
                buttons['d'][6]
              ], nextColors),
              ['zig-zag right down up']);
        });
        test('6', () {
          expect(
              Analyzer().analyzePattern([
                buttons['d'][1],
                buttons['c'][2],
                buttons['d'][3],
                buttons['c'][4],
                buttons['d'][5],
                buttons['c'][6]
              ], nextColors),
              ['zig-zag right down up']);
        });
      });
      group('up left right', () {
        test('3', () {
          expect(
              Analyzer().analyzePattern(
                  [buttons['a'][4], buttons['b'][3], buttons['c'][4]], nextColors),
              ['zig-zag up left right']);
          expect(
              Analyzer().analyzePattern(
                  [buttons['b'][4], buttons['c'][3], buttons['d'][4]], nextColors),
              ['zig-zag up left right']);
          expect(
              Analyzer().analyzePattern(
                  [buttons['c'][4], buttons['d'][3], buttons['e'][4]], nextColors),
              ['zig-zag up left right']);
          expect(
              Analyzer().analyzePattern(
                  [buttons['d'][4], buttons['e'][3], buttons['f'][4]], nextColors),
              ['zig-zag up left right']);
        });
        test('4', () {
          expect(
              Analyzer().analyzePattern([
                buttons['a'][4],
                buttons['b'][3],
                buttons['c'][4],
                buttons['d'][3]
              ], nextColors),
              ['zig-zag up left right']);
          expect(
              Analyzer().analyzePattern([
                buttons['b'][4],
                buttons['c'][3],
                buttons['d'][4],
                buttons['e'][3]
              ], nextColors),
              ['zig-zag up left right']);
          expect(
              Analyzer().analyzePattern([
                buttons['c'][4],
                buttons['d'][3],
                buttons['e'][4],
                buttons['f'][3]
              ], nextColors),
              ['zig-zag up left right']);
        });
        test('5', () {
          expect(
              Analyzer().analyzePattern([
                buttons['a'][4],
                buttons['b'][3],
                buttons['c'][4],
                buttons['d'][3],
                buttons['e'][4]
              ], nextColors),
              ['zig-zag up left right']);
          expect(
              Analyzer().analyzePattern([
                buttons['b'][4],
                buttons['c'][3],
                buttons['d'][4],
                buttons['e'][3],
                buttons['f'][4]
              ], nextColors),
              ['zig-zag up left right']);
        });
        test('6', () {
          expect(
              Analyzer().analyzePattern([
                buttons['a'][4],
                buttons['b'][3],
                buttons['c'][4],
                buttons['d'][3],
                buttons['e'][4],
                buttons['f'][3]
              ], nextColors),
              ['zig-zag up left right']);
        });
      });
      group('up right left', () {
        test('3', () {
          expect(
              Analyzer().analyzePattern(
                  [buttons['a'][3], buttons['b'][4], buttons['c'][3]], nextColors),
              ['zig-zag up right left']);
          expect(
              Analyzer().analyzePattern(
                  [buttons['b'][3], buttons['c'][4], buttons['d'][3]], nextColors),
              ['zig-zag up right left']);
          expect(
              Analyzer().analyzePattern(
                  [buttons['c'][3], buttons['d'][4], buttons['e'][3]], nextColors),
              ['zig-zag up right left']);
          expect(
              Analyzer().analyzePattern(
                  [buttons['d'][3], buttons['e'][4], buttons['f'][3]], nextColors),
              ['zig-zag up right left']);
        });
        test('4', () {
          expect(
              Analyzer().analyzePattern([
                buttons['a'][3],
                buttons['b'][4],
                buttons['c'][3],
                buttons['d'][4]
              ], nextColors),
              ['zig-zag up right left']);
          expect(
              Analyzer().analyzePattern([
                buttons['b'][3],
                buttons['c'][4],
                buttons['d'][3],
                buttons['e'][4]
              ], nextColors),
              ['zig-zag up right left']);
          expect(
              Analyzer().analyzePattern([
                buttons['c'][3],
                buttons['d'][4],
                buttons['e'][3],
                buttons['f'][4]
              ], nextColors),
              ['zig-zag up right left']);
        });
        test('5', () {
          expect(
              Analyzer().analyzePattern([
                buttons['a'][3],
                buttons['b'][4],
                buttons['c'][3],
                buttons['d'][4],
                buttons['e'][3]
              ], nextColors),
              ['zig-zag up right left']);
          expect(
              Analyzer().analyzePattern([
                buttons['b'][3],
                buttons['c'][4],
                buttons['d'][3],
                buttons['e'][4],
                buttons['f'][3]
              ], nextColors),
              ['zig-zag up right left']);
        });
        test('6', () {
          expect(
              Analyzer().analyzePattern([
                buttons['a'][3],
                buttons['b'][4],
                buttons['c'][3],
                buttons['d'][4],
                buttons['e'][3],
                buttons['f'][4]
              ], nextColors),
              ['zig-zag up right left']);
        });
      });
      group('down left right', () {
        test('3', () {
          expect(
              Analyzer().analyzePattern(
                  [buttons['f'][4], buttons['e'][3], buttons['d'][4]], nextColors),
              ['zig-zag down left right']);
          expect(
              Analyzer().analyzePattern(
                  [buttons['e'][4], buttons['d'][3], buttons['c'][4]], nextColors),
              ['zig-zag down left right']);
          expect(
              Analyzer().analyzePattern(
                  [buttons['d'][4], buttons['c'][3], buttons['b'][4]], nextColors),
              ['zig-zag down left right']);
          expect(
              Analyzer().analyzePattern(
                  [buttons['c'][4], buttons['b'][3], buttons['a'][4]], nextColors),
              ['zig-zag down left right']);
        });
        test('4', () {
          expect(
              Analyzer().analyzePattern([
                buttons['f'][4],
                buttons['e'][3],
                buttons['d'][4],
                buttons['c'][3]
              ], nextColors),
              ['zig-zag down left right']);
          expect(
              Analyzer().analyzePattern([
                buttons['e'][4],
                buttons['d'][3],
                buttons['c'][4],
                buttons['b'][3]
              ], nextColors),
              ['zig-zag down left right']);
          expect(
              Analyzer().analyzePattern([
                buttons['d'][4],
                buttons['c'][3],
                buttons['b'][4],
                buttons['a'][3]
              ], nextColors),
              ['zig-zag down left right']);
        });
        test('5', () {
          expect(
              Analyzer().analyzePattern([
                buttons['f'][4],
                buttons['e'][3],
                buttons['d'][4],
                buttons['c'][3],
                buttons['b'][4]
              ], nextColors),
              ['zig-zag down left right']);
          expect(
              Analyzer().analyzePattern([
                buttons['e'][4],
                buttons['d'][3],
                buttons['c'][4],
                buttons['b'][3],
                buttons['a'][4]
              ], nextColors),
              ['zig-zag down left right']);
        });
        test('6', () {
          expect(
              Analyzer().analyzePattern([
                buttons['f'][4],
                buttons['e'][3],
                buttons['d'][4],
                buttons['c'][3],
                buttons['b'][4],
                buttons['a'][3]
              ], nextColors),
              ['zig-zag down left right']);
        });
      });
      group('down right left', () {
        test('3', () {
          expect(
              Analyzer().analyzePattern(
                  [buttons['f'][3], buttons['e'][4], buttons['d'][3]], nextColors),
              ['zig-zag down right left']);
          expect(
              Analyzer().analyzePattern(
                  [buttons['e'][3], buttons['d'][4], buttons['c'][3]], nextColors),
              ['zig-zag down right left']);
          expect(
              Analyzer().analyzePattern(
                  [buttons['d'][3], buttons['c'][4], buttons['b'][3]], nextColors),
              ['zig-zag down right left']);
          expect(
              Analyzer().analyzePattern(
                  [buttons['c'][3], buttons['b'][4], buttons['a'][3]], nextColors),
              ['zig-zag down right left']);
        });
        test('4', () {
          expect(
              Analyzer().analyzePattern([
                buttons['f'][3],
                buttons['e'][4],
                buttons['d'][3],
                buttons['c'][4]
              ], nextColors),
              ['zig-zag down right left']);
          expect(
              Analyzer().analyzePattern([
                buttons['e'][3],
                buttons['d'][4],
                buttons['c'][3],
                buttons['b'][4]
              ], nextColors),
              ['zig-zag down right left']);
          expect(
              Analyzer().analyzePattern([
                buttons['d'][3],
                buttons['c'][4],
                buttons['b'][3],
                buttons['a'][4]
              ], nextColors),
              ['zig-zag down right left']);
        });
        test('5', () {
          expect(
              Analyzer().analyzePattern([
                buttons['f'][3],
                buttons['e'][4],
                buttons['d'][3],
                buttons['c'][4],
                buttons['b'][3]
              ], nextColors),
              ['zig-zag down right left']);
          expect(
              Analyzer().analyzePattern([
                buttons['e'][3],
                buttons['d'][4],
                buttons['c'][3],
                buttons['b'][4],
                buttons['a'][3]
              ], nextColors),
              ['zig-zag down right left']);
        });
        test('6', () {
          expect(
              Analyzer().analyzePattern([
                buttons['f'][3],
                buttons['e'][4],
                buttons['d'][3],
                buttons['c'][4],
                buttons['b'][3],
                buttons['a'][4]
              ], nextColors),
              ['zig-zag down right left']);
        });
      });
    });
  });

  group('Analyze colors', () {
    var blue = CupertinoColors.systemBlue;
    var red = CupertinoColors.systemRed;
    var green = CupertinoColors.systemGreen;
    var yellow = CupertinoColors.systemYellow;
    var grey = CupertinoColors.systemGrey;
    test('single color', () {
      expect(Analyzer().analyzeColor([blue]), '{blue}');
      expect(Analyzer().analyzeColor([red]), '{red}');
      expect(Analyzer().analyzeColor([green]), '{green}');
      expect(Analyzer().analyzeColor([yellow]), '{yellow}');
      expect(
          () => {
                Analyzer().analyzeColor([grey])
              },
          throwsA(isA<Exception>()));
    });
    group('multiple colors', () {
      test('2', () {
        expect(Analyzer().analyzeColor([blue, green]), '{blue, green}');
        expect(Analyzer().analyzeColor([green, blue]), '{green, blue}');
        expect(Analyzer().analyzeColor([red, yellow]), '{red, yellow}');
        expect(Analyzer().analyzeColor([yellow, red]), '{yellow, red}');
      });
      test('3', () {
        expect(
            Analyzer().analyzeColor([blue, green, red]), '{blue, green, red}');
        expect(Analyzer().analyzeColor([green, yellow, blue]),
            '{green, yellow, blue}');
        expect(Analyzer().analyzeColor([blue, red, yellow]),
            '{blue, red, yellow}');
        expect(Analyzer().analyzeColor([yellow, red, green]),
            '{yellow, red, green}');
      });
      test('4', () {
        expect(Analyzer().analyzeColor([blue, green, red, yellow]),
            '{blue, green, red, yellow}');
        expect(Analyzer().analyzeColor([green, red, yellow, blue]),
            '{green, red, yellow, blue}');
        expect(Analyzer().analyzeColor([red, yellow, blue, green]),
            '{red, yellow, blue, green}');
        expect(Analyzer().analyzeColor([yellow, blue, green, red]),
            '{yellow, blue, green, red}');
      });
      test('invalid color', () {
        expect(
            () => {
                  Analyzer().analyzeColor([blue, green, grey, red, yellow])
                },
            throwsA(isA<Exception>()));
      });
    });
  });

  group('Analyze movement', () {
    test('a3 -> d2', () {
      expect(
          Analyzer()
              .analyzeMovement(const Tuple2('a', 3), const Tuple2('d', 2)),
          ['GO(1 left)', 'GO(3 up)']);
    });
  });
}