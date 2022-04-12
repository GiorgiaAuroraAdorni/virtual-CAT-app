import 'package:cross_array_task_app/Activity/GestureBased/analyzer.dart';
import 'package:cross_array_task_app/Activity/GestureBased/cross_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tuple/tuple.dart';

void main() {
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
          params: const {});
    }
  }

  group('Empty result', () {
    test('Empty List', () {
      expect(Analyzer().analyze([]), []);
    });
    test('One element List', () {
      expect(Analyzer().analyze([buttons['a'][3]]), []);
    });
    test('No existing command', () {
      expect(
          Analyzer()
              .analyze([buttons['a'][3], buttons['b'][3], buttons['c'][4]]),
          []);
    });
  });

  group('Horizontal', () {
    group('right', () {
      test('2', () {
        expect(
            Analyzer().analyze([buttons['f'][3], buttons['f'][4]]), ['right']);
      });
      test('3', () {
        expect(
            Analyzer()
                .analyze([buttons['c'][1], buttons['c'][2], buttons['c'][3]]),
            ['right']);
      });
      test('4', () {
        expect(
            Analyzer().analyze([
              buttons['c'][1],
              buttons['c'][2],
              buttons['c'][3],
              buttons['c'][4]
            ]),
            ['right']);
      });
      test('5', () {
        expect(
            Analyzer().analyze([
              buttons['c'][1],
              buttons['c'][2],
              buttons['c'][3],
              buttons['c'][4],
              buttons['c'][5]
            ]),
            ['right']);
      });
      test('6', () {
        expect(
            Analyzer().analyze([
              buttons['c'][1],
              buttons['c'][2],
              buttons['c'][3],
              buttons['c'][4],
              buttons['c'][5],
              buttons['c'][6]
            ]),
            ['right']);
      });
    });
    group('left', () {
      test('2', () {
        expect(
            Analyzer().analyze([buttons['a'][4], buttons['a'][3]]), ['left']);
      });
      test('3', () {
        expect(
            Analyzer()
                .analyze([buttons['d'][3], buttons['d'][2], buttons['d'][1]]),
            ['left']);
      });
      test('4', () {
        expect(
            Analyzer().analyze([
              buttons['d'][4],
              buttons['d'][3],
              buttons['d'][2],
              buttons['d'][1]
            ]),
            ['left']);
      });
      test('5', () {
        expect(
            Analyzer().analyze([
              buttons['d'][5],
              buttons['d'][4],
              buttons['d'][3],
              buttons['d'][2],
              buttons['d'][1]
            ]),
            ['left']);
      });
      test('6', () {
        expect(
            Analyzer().analyze([
              buttons['d'][6],
              buttons['d'][5],
              buttons['d'][4],
              buttons['d'][3],
              buttons['d'][2],
              buttons['d'][1]
            ]),
            ['left']);
      });
    });
  });

  group('Vertical', () {
    group('up', () {
      test('2', () {
        expect(Analyzer().analyze([buttons['a'][3], buttons['b'][3]]), ['up']);
      });
      test('3', () {
        expect(
            Analyzer()
                .analyze([buttons['a'][3], buttons['b'][3], buttons['c'][3]]),
            ['up']);
      });
      test('4', () {
        expect(
            Analyzer().analyze([
              buttons['a'][3],
              buttons['b'][3],
              buttons['c'][3],
              buttons['d'][3]
            ]),
            ['up']);
      });
      test('5', () {
        expect(
            Analyzer().analyze([
              buttons['a'][3],
              buttons['b'][3],
              buttons['c'][3],
              buttons['d'][3],
              buttons['e'][3]
            ]),
            ['up']);
      });
      test('6', () {
        expect(
            Analyzer().analyze([
              buttons['a'][3],
              buttons['b'][3],
              buttons['c'][3],
              buttons['d'][3],
              buttons['e'][3],
              buttons['f'][3]
            ]),
            ['up']);
      });
    });
    group('down', () {
      test('2', () {
        expect(
            Analyzer().analyze([buttons['d'][1], buttons['c'][1]]), ['down']);
      });
      test('3', () {
        expect(
            Analyzer()
                .analyze([buttons['f'][4], buttons['e'][4], buttons['d'][4]]),
            ['down']);
      });
      test('4', () {
        expect(
            Analyzer().analyze([
              buttons['f'][4],
              buttons['e'][4],
              buttons['d'][4],
              buttons['c'][4]
            ]),
            ['down']);
      });
      test('5', () {
        expect(
            Analyzer().analyze([
              buttons['f'][4],
              buttons['e'][4],
              buttons['d'][4],
              buttons['c'][4],
              buttons['b'][4]
            ]),
            ['down']);
      });
      test('6', () {
        expect(
            Analyzer().analyze([
              buttons['f'][4],
              buttons['e'][4],
              buttons['d'][4],
              buttons['c'][4],
              buttons['b'][4],
              buttons['a'][4]
            ]),
            ['down']);
      });
    });
  });

  group('diagonal', () {
    group('up left', () {
      test('2', () {
        expect(Analyzer().analyze([buttons['a'][3], buttons['c'][1]]),
            ['diagonal up left']);
      });
      test('3', () {
        expect(
            Analyzer()
                .analyze([buttons['b'][4], buttons['c'][3], buttons['d'][2]]),
            ['diagonal up left']);
      });
      test('4', () {
        expect(
            Analyzer().analyze([
              buttons['c'][6],
              buttons['d'][5],
              buttons['e'][4],
              buttons['f'][3]
            ]),
            ['diagonal up left']);
      });
    });
    group('up right', () {
      test('2', () {
        expect(Analyzer().analyze([buttons['d'][1], buttons['f'][3]]),
            ['diagonal up right']);
      });
      test('3', () {
        expect(
            Analyzer()
                .analyze([buttons['c'][2], buttons['d'][3], buttons['e'][4]]),
            ['diagonal up right']);
      });
      test('4', () {
        expect(
            Analyzer().analyze([
              buttons['a'][3],
              buttons['b'][4],
              buttons['c'][5],
              buttons['d'][6]
            ]),
            ['diagonal up right']);
      });
    });
    group('down left', () {
      test('2', () {
        expect(Analyzer().analyze([buttons['c'][6], buttons['a'][4]]),
            ['diagonal down left']);
      });
      test('3', () {
        expect(
            Analyzer()
                .analyze([buttons['d'][5], buttons['c'][4], buttons['b'][3]]),
            ['diagonal down left']);
      });
      test('4', () {
        expect(
            Analyzer().analyze([
              buttons['f'][4],
              buttons['e'][3],
              buttons['d'][2],
              buttons['c'][1]
            ]),
            ['diagonal down left']);
      });
    });
    group('down right', () {
      test('2', () {
        expect(Analyzer().analyze([buttons['c'][1], buttons['a'][3]]),
            ['diagonal down right']);
      });
      test('3', () {
        expect(
            Analyzer()
                .analyze([buttons['e'][3], buttons['d'][4], buttons['c'][5]]),
            ['diagonal down right']);
      });
      test('4', () {
        expect(
            Analyzer().analyze([
              buttons['f'][3],
              buttons['e'][4],
              buttons['d'][5],
              buttons['c'][6]
            ]),
            ['diagonal down right']);
      });
    });
  });

  group('square', () {
    group('counterclockwise', () {
      test('right up left down', () {
        expect(
            Analyzer().analyze([
              buttons['a'][3],
              buttons['a'][4],
              buttons['b'][4],
              buttons['b'][3]
            ]),
            ['square']);
        expect(
            Analyzer().analyze([
              buttons['b'][3],
              buttons['b'][4],
              buttons['c'][4],
              buttons['c'][3]
            ]),
            ['square']);
        expect(
            Analyzer().analyze([
              buttons['c'][1],
              buttons['c'][2],
              buttons['d'][2],
              buttons['d'][1]
            ]),
            ['square']);
        expect(
            Analyzer().analyze([
              buttons['c'][2],
              buttons['c'][3],
              buttons['d'][3],
              buttons['d'][2]
            ]),
            ['square']);
        expect(
            Analyzer().analyze([
              buttons['c'][3],
              buttons['c'][4],
              buttons['d'][4],
              buttons['d'][3]
            ]),
            ['square']);
        expect(
            Analyzer().analyze([
              buttons['c'][4],
              buttons['c'][5],
              buttons['d'][5],
              buttons['d'][4]
            ]),
            ['square']);
        expect(
            Analyzer().analyze([
              buttons['c'][5],
              buttons['c'][6],
              buttons['d'][6],
              buttons['d'][5]
            ]),
            ['square']);
        expect(
            Analyzer().analyze([
              buttons['d'][3],
              buttons['d'][4],
              buttons['e'][4],
              buttons['e'][3]
            ]),
            ['square']);
        expect(
            Analyzer().analyze([
              buttons['e'][3],
              buttons['e'][4],
              buttons['f'][4],
              buttons['f'][3]
            ]),
            ['square']);
      });
      test('up left down right', () {
        expect(
            Analyzer().analyze([
              buttons['a'][4],
              buttons['b'][4],
              buttons['b'][3],
              buttons['a'][3]
            ]),
            ['square']);
        expect(
            Analyzer().analyze([
              buttons['b'][4],
              buttons['c'][4],
              buttons['c'][3],
              buttons['b'][3]
            ]),
            ['square']);
        expect(
            Analyzer().analyze([
              buttons['c'][2],
              buttons['d'][2],
              buttons['d'][1],
              buttons['c'][1]
            ]),
            ['square']);
        expect(
            Analyzer().analyze([
              buttons['c'][3],
              buttons['d'][3],
              buttons['d'][2],
              buttons['c'][2]
            ]),
            ['square']);
        expect(
            Analyzer().analyze([
              buttons['c'][4],
              buttons['d'][4],
              buttons['d'][3],
              buttons['c'][3]
            ]),
            ['square']);
        expect(
            Analyzer().analyze([
              buttons['c'][5],
              buttons['d'][5],
              buttons['d'][4],
              buttons['c'][4]
            ]),
            ['square']);
        expect(
            Analyzer().analyze([
              buttons['c'][6],
              buttons['d'][6],
              buttons['d'][5],
              buttons['c'][5]
            ]),
            ['square']);
        expect(
            Analyzer().analyze([
              buttons['d'][4],
              buttons['e'][4],
              buttons['e'][3],
              buttons['d'][3]
            ]),
            ['square']);
        expect(
            Analyzer().analyze([
              buttons['e'][4],
              buttons['f'][4],
              buttons['f'][3],
              buttons['e'][3]
            ]),
            ['square']);
      });
      test('left down right up', () {
        expect(
            Analyzer().analyze([
              buttons['b'][4],
              buttons['b'][3],
              buttons['a'][3],
              buttons['a'][4]
            ]),
            ['square']);
        expect(
            Analyzer().analyze([
              buttons['c'][4],
              buttons['c'][3],
              buttons['b'][3],
              buttons['b'][4]
            ]),
            ['square']);
        expect(
            Analyzer().analyze([
              buttons['d'][2],
              buttons['d'][1],
              buttons['c'][1],
              buttons['c'][2]
            ]),
            ['square']);
        expect(
            Analyzer().analyze([
              buttons['d'][3],
              buttons['d'][2],
              buttons['c'][2],
              buttons['c'][3]
            ]),
            ['square']);
        expect(
            Analyzer().analyze([
              buttons['d'][4],
              buttons['d'][3],
              buttons['c'][3],
              buttons['c'][4]
            ]),
            ['square']);
        expect(
            Analyzer().analyze([
              buttons['d'][5],
              buttons['d'][4],
              buttons['c'][4],
              buttons['c'][5]
            ]),
            ['square']);
        expect(
            Analyzer().analyze([
              buttons['d'][6],
              buttons['d'][5],
              buttons['c'][5],
              buttons['c'][6]
            ]),
            ['square']);
        expect(
            Analyzer().analyze([
              buttons['e'][4],
              buttons['e'][3],
              buttons['d'][3],
              buttons['d'][4]
            ]),
            ['square']);
        expect(
            Analyzer().analyze([
              buttons['f'][4],
              buttons['f'][3],
              buttons['e'][3],
              buttons['e'][4]
            ]),
            ['square']);
      });
      test('down right up left', () {
        expect(
            Analyzer().analyze([
              buttons['b'][3],
              buttons['a'][3],
              buttons['a'][4],
              buttons['b'][4]
            ]),
            ['square']);
        expect(
            Analyzer().analyze([
              buttons['c'][3],
              buttons['b'][3],
              buttons['b'][4],
              buttons['c'][4]
            ]),
            ['square']);
        expect(
            Analyzer().analyze([
              buttons['d'][1],
              buttons['c'][1],
              buttons['c'][2],
              buttons['d'][2]
            ]),
            ['square']);
        expect(
            Analyzer().analyze([
              buttons['d'][2],
              buttons['c'][2],
              buttons['c'][3],
              buttons['d'][3]
            ]),
            ['square']);
        expect(
            Analyzer().analyze([
              buttons['d'][3],
              buttons['c'][3],
              buttons['c'][4],
              buttons['d'][4]
            ]),
            ['square']);
        expect(
            Analyzer().analyze([
              buttons['d'][4],
              buttons['c'][4],
              buttons['c'][5],
              buttons['d'][5]
            ]),
            ['square']);
        expect(
            Analyzer().analyze([
              buttons['d'][5],
              buttons['c'][5],
              buttons['c'][6],
              buttons['d'][6]
            ]),
            ['square']);
        expect(
            Analyzer().analyze([
              buttons['e'][3],
              buttons['d'][3],
              buttons['d'][4],
              buttons['e'][4]
            ]),
            ['square']);
        expect(
            Analyzer().analyze([
              buttons['f'][3],
              buttons['e'][3],
              buttons['e'][4],
              buttons['f'][4]
            ]),
            ['square']);
      });
    });
    group('clockwise', () {
      test('right down left up', () {
        expect(
            Analyzer().analyze([
              buttons['b'][3],
              buttons['b'][4],
              buttons['a'][4],
              buttons['a'][3]
            ]),
            ['square']);
        expect(
            Analyzer().analyze([
              buttons['c'][3],
              buttons['c'][4],
              buttons['b'][4],
              buttons['b'][3]
            ]),
            ['square']);
        expect(
            Analyzer().analyze([
              buttons['d'][1],
              buttons['d'][2],
              buttons['c'][2],
              buttons['c'][1]
            ]),
            ['square']);
        expect(
            Analyzer().analyze([
              buttons['d'][2],
              buttons['d'][3],
              buttons['c'][3],
              buttons['c'][2]
            ]),
            ['square']);
        expect(
            Analyzer().analyze([
              buttons['d'][3],
              buttons['d'][4],
              buttons['c'][4],
              buttons['c'][3]
            ]),
            ['square']);
        expect(
            Analyzer().analyze([
              buttons['d'][4],
              buttons['d'][5],
              buttons['c'][5],
              buttons['c'][4]
            ]),
            ['square']);
        expect(
            Analyzer().analyze([
              buttons['d'][5],
              buttons['d'][6],
              buttons['c'][6],
              buttons['c'][5]
            ]),
            ['square']);
        expect(
            Analyzer().analyze([
              buttons['e'][3],
              buttons['e'][4],
              buttons['d'][4],
              buttons['d'][3]
            ]),
            ['square']);
        expect(
            Analyzer().analyze([
              buttons['f'][3],
              buttons['f'][4],
              buttons['e'][4],
              buttons['e'][3]
            ]),
            ['square']);
      });
      test('down left up right', () {
        expect(
            Analyzer().analyze([
              buttons['b'][4],
              buttons['a'][4],
              buttons['a'][3],
              buttons['b'][3]
            ]),
            ['square']);
        expect(
            Analyzer().analyze([
              buttons['c'][4],
              buttons['b'][4],
              buttons['b'][3],
              buttons['c'][3]
            ]),
            ['square']);
        expect(
            Analyzer().analyze([
              buttons['d'][2],
              buttons['c'][2],
              buttons['c'][1],
              buttons['d'][1]
            ]),
            ['square']);
        expect(
            Analyzer().analyze([
              buttons['d'][3],
              buttons['c'][3],
              buttons['c'][2],
              buttons['d'][2]
            ]),
            ['square']);
        expect(
            Analyzer().analyze([
              buttons['d'][4],
              buttons['c'][4],
              buttons['c'][3],
              buttons['d'][3]
            ]),
            ['square']);
        expect(
            Analyzer().analyze([
              buttons['d'][5],
              buttons['c'][5],
              buttons['c'][4],
              buttons['d'][4]
            ]),
            ['square']);
        expect(
            Analyzer().analyze([
              buttons['d'][6],
              buttons['c'][6],
              buttons['c'][5],
              buttons['d'][5]
            ]),
            ['square']);
        expect(
            Analyzer().analyze([
              buttons['e'][4],
              buttons['d'][4],
              buttons['d'][3],
              buttons['e'][3]
            ]),
            ['square']);
        expect(
            Analyzer().analyze([
              buttons['f'][4],
              buttons['e'][4],
              buttons['e'][3],
              buttons['f'][3]
            ]),
            ['square']);
      });
      test('left up right down', () {
        expect(
            Analyzer().analyze([
              buttons['a'][4],
              buttons['a'][3],
              buttons['b'][3],
              buttons['b'][4]
            ]),
            ['square']);
        expect(
            Analyzer().analyze([
              buttons['b'][4],
              buttons['b'][3],
              buttons['c'][3],
              buttons['c'][4]
            ]),
            ['square']);
        expect(
            Analyzer().analyze([
              buttons['c'][2],
              buttons['c'][1],
              buttons['d'][1],
              buttons['d'][2]
            ]),
            ['square']);
        expect(
            Analyzer().analyze([
              buttons['c'][3],
              buttons['c'][2],
              buttons['d'][2],
              buttons['d'][3]
            ]),
            ['square']);
        expect(
            Analyzer().analyze([
              buttons['c'][4],
              buttons['c'][3],
              buttons['d'][3],
              buttons['d'][4]
            ]),
            ['square']);
        expect(
            Analyzer().analyze([
              buttons['c'][5],
              buttons['c'][4],
              buttons['d'][4],
              buttons['d'][5]
            ]),
            ['square']);
        expect(
            Analyzer().analyze([
              buttons['c'][6],
              buttons['c'][5],
              buttons['d'][5],
              buttons['d'][6]
            ]),
            ['square']);
        expect(
            Analyzer().analyze([
              buttons['d'][4],
              buttons['d'][3],
              buttons['e'][3],
              buttons['e'][4]
            ]),
            ['square']);
        expect(
            Analyzer().analyze([
              buttons['e'][4],
              buttons['e'][3],
              buttons['f'][3],
              buttons['f'][4]
            ]),
            ['square']);
      });
      test('up right down left', () {
        expect(
            Analyzer().analyze([
              buttons['a'][3],
              buttons['b'][3],
              buttons['b'][4],
              buttons['a'][4]
            ]),
            ['square']);
        expect(
            Analyzer().analyze([
              buttons['b'][3],
              buttons['c'][3],
              buttons['c'][4],
              buttons['b'][4]
            ]),
            ['square']);
        expect(
            Analyzer().analyze([
              buttons['c'][1],
              buttons['d'][1],
              buttons['d'][2],
              buttons['c'][2]
            ]),
            ['square']);
        expect(
            Analyzer().analyze([
              buttons['c'][2],
              buttons['d'][2],
              buttons['d'][3],
              buttons['c'][3]
            ]),
            ['square']);
        expect(
            Analyzer().analyze([
              buttons['c'][3],
              buttons['d'][3],
              buttons['d'][4],
              buttons['c'][4]
            ]),
            ['square']);
        expect(
            Analyzer().analyze([
              buttons['c'][4],
              buttons['d'][4],
              buttons['d'][5],
              buttons['c'][5]
            ]),
            ['square']);
        expect(
            Analyzer().analyze([
              buttons['c'][5],
              buttons['d'][5],
              buttons['d'][6],
              buttons['c'][6]
            ]),
            ['square']);
        expect(
            Analyzer().analyze([
              buttons['d'][3],
              buttons['e'][3],
              buttons['e'][4],
              buttons['d'][4]
            ]),
            ['square']);
        expect(
            Analyzer().analyze([
              buttons['e'][3],
              buttons['f'][3],
              buttons['f'][4],
              buttons['e'][4]
            ]),
            ['square']);
      });
    });
  });

  group('L', () {
    test('up left', () {
      expect(
          Analyzer().analyze([
            buttons['a'][3],
            buttons['b'][3],
            buttons['c'][3],
            buttons['c'][2],
            buttons['c'][1]
          ]),
          ['L up left']);
    });
    test('up right', () {
      expect(
          Analyzer().analyze([
            buttons['a'][4],
            buttons['b'][4],
            buttons['c'][4],
            buttons['c'][5],
            buttons['c'][6]
          ]),
          ['L up right']);
    });
    test('down left', () {
      expect(
          Analyzer().analyze([
            buttons['f'][3],
            buttons['e'][3],
            buttons['d'][3],
            buttons['d'][2],
            buttons['d'][1]
          ]),
          ['L down left']);
    });
    test('down right', () {
      expect(
          Analyzer().analyze([
            buttons['f'][4],
            buttons['e'][4],
            buttons['d'][4],
            buttons['d'][5],
            buttons['d'][6]
          ]),
          ['L down right']);
    });
    test('left up', () {
      expect(
          Analyzer().analyze([
            buttons['d'][6],
            buttons['d'][5],
            buttons['d'][4],
            buttons['e'][4],
            buttons['f'][4]
          ]),
          ['L left up']);
    });
    test('left down', () {
      expect(
          Analyzer().analyze([
            buttons['c'][6],
            buttons['c'][5],
            buttons['c'][4],
            buttons['b'][4],
            buttons['a'][4]
          ]),
          ['L left down']);
    });
    test('right up', () {
      expect(
          Analyzer().analyze([
            buttons['d'][1],
            buttons['d'][2],
            buttons['d'][3],
            buttons['e'][3],
            buttons['f'][3]
          ]),
          ['L right up']);
    });
    test('right down', () {
      expect(
          Analyzer().analyze([
            buttons['c'][1],
            buttons['c'][2],
            buttons['c'][3],
            buttons['b'][3],
            buttons['a'][3]
          ]),
          ['L right down']);
    });
  });

  group('zig-zag', () {
    group('left up down', () {
      test('3', () {
        expect(
            Analyzer()
                .analyze([buttons['c'][6], buttons['d'][5], buttons['c'][4]]),
            ['zig-zag left up down']);
        expect(
            Analyzer()
                .analyze([buttons['c'][5], buttons['d'][4], buttons['c'][3]]),
            ['zig-zag left up down']);
        expect(
            Analyzer()
                .analyze([buttons['c'][4], buttons['d'][3], buttons['c'][2]]),
            ['zig-zag left up down']);
        expect(
            Analyzer()
                .analyze([buttons['c'][3], buttons['d'][2], buttons['c'][1]]),
            ['zig-zag left up down']);
      });
      test('4', () {
        expect(
            Analyzer().analyze([
              buttons['c'][6],
              buttons['d'][5],
              buttons['c'][4],
              buttons['d'][3]
            ]),
            ['zig-zag left up down']);
        expect(
            Analyzer().analyze([
              buttons['c'][5],
              buttons['d'][4],
              buttons['c'][3],
              buttons['d'][2]
            ]),
            ['zig-zag left up down']);
        expect(
            Analyzer().analyze([
              buttons['c'][4],
              buttons['d'][3],
              buttons['c'][2],
              buttons['d'][1]
            ]),
            ['zig-zag left up down']);
      });
      test('5', () {
        expect(
            Analyzer().analyze([
              buttons['c'][6],
              buttons['d'][5],
              buttons['c'][4],
              buttons['d'][3],
              buttons['c'][2]
            ]),
            ['zig-zag left up down']);
        expect(
            Analyzer().analyze([
              buttons['c'][5],
              buttons['d'][4],
              buttons['c'][3],
              buttons['d'][2],
              buttons['c'][1]
            ]),
            ['zig-zag left up down']);
      });
      test('6', () {
        expect(
            Analyzer().analyze([
              buttons['c'][6],
              buttons['d'][5],
              buttons['c'][4],
              buttons['d'][3],
              buttons['c'][2],
              buttons['d'][1]
            ]),
            ['zig-zag left up down']);
      });
    });
    group('left down up', () {
      test('3', () {
        expect(
            Analyzer()
                .analyze([buttons['d'][6], buttons['c'][5], buttons['d'][4]]),
            ['zig-zag left down up']);
        expect(
            Analyzer()
                .analyze([buttons['d'][5], buttons['c'][4], buttons['d'][3]]),
            ['zig-zag left down up']);
        expect(
            Analyzer()
                .analyze([buttons['d'][4], buttons['c'][3], buttons['d'][2]]),
            ['zig-zag left down up']);
        expect(
            Analyzer()
                .analyze([buttons['d'][3], buttons['c'][2], buttons['d'][1]]),
            ['zig-zag left down up']);
      });
      test('4', () {
        expect(
            Analyzer().analyze([
              buttons['d'][6],
              buttons['c'][5],
              buttons['d'][4],
              buttons['c'][3]
            ]),
            ['zig-zag left down up']);
        expect(
            Analyzer().analyze([
              buttons['d'][5],
              buttons['c'][4],
              buttons['d'][3],
              buttons['c'][2]
            ]),
            ['zig-zag left down up']);
        expect(
            Analyzer().analyze([
              buttons['d'][4],
              buttons['c'][3],
              buttons['d'][2],
              buttons['c'][1]
            ]),
            ['zig-zag left down up']);
      });
      test('5', () {
        expect(
            Analyzer().analyze([
              buttons['d'][6],
              buttons['c'][5],
              buttons['d'][4],
              buttons['c'][3],
              buttons['d'][2]
            ]),
            ['zig-zag left down up']);
        expect(
            Analyzer().analyze([
              buttons['d'][5],
              buttons['c'][4],
              buttons['d'][3],
              buttons['c'][2],
              buttons['d'][1]
            ]),
            ['zig-zag left down up']);
      });
      test('6', () {
        expect(
            Analyzer().analyze([
              buttons['d'][6],
              buttons['c'][5],
              buttons['d'][4],
              buttons['c'][3],
              buttons['d'][2],
              buttons['c'][1]
            ]),
            ['zig-zag left down up']);
      });
    });
    group('right up down', () {
      test('3', () {
        expect(
            Analyzer()
                .analyze([buttons['c'][1], buttons['d'][2], buttons['c'][3]]),
            ['zig-zag right up down']);
        expect(
            Analyzer()
                .analyze([buttons['c'][2], buttons['d'][3], buttons['c'][4]]),
            ['zig-zag right up down']);
        expect(
            Analyzer()
                .analyze([buttons['c'][3], buttons['d'][4], buttons['c'][5]]),
            ['zig-zag right up down']);
        expect(
            Analyzer()
                .analyze([buttons['c'][4], buttons['d'][5], buttons['c'][6]]),
            ['zig-zag right up down']);
      });
      test('4', () {
        expect(
            Analyzer().analyze([
              buttons['c'][1],
              buttons['d'][2],
              buttons['c'][3],
              buttons['d'][4]
            ]),
            ['zig-zag right up down']);
        expect(
            Analyzer().analyze([
              buttons['c'][2],
              buttons['d'][3],
              buttons['c'][4],
              buttons['d'][5]
            ]),
            ['zig-zag right up down']);
        expect(
            Analyzer().analyze([
              buttons['c'][3],
              buttons['d'][4],
              buttons['c'][5],
              buttons['d'][6]
            ]),
            ['zig-zag right up down']);
      });
      test('5', () {
        expect(
            Analyzer().analyze([
              buttons['c'][1],
              buttons['d'][2],
              buttons['c'][3],
              buttons['d'][4],
              buttons['c'][5]
            ]),
            ['zig-zag right up down']);
        expect(
            Analyzer().analyze([
              buttons['c'][2],
              buttons['d'][3],
              buttons['c'][4],
              buttons['d'][5],
              buttons['c'][6]
            ]),
            ['zig-zag right up down']);
      });
      test('6', () {
        expect(
            Analyzer().analyze([
              buttons['c'][1],
              buttons['d'][2],
              buttons['c'][3],
              buttons['d'][4],
              buttons['c'][5],
              buttons['d'][6]
            ]),
            ['zig-zag right up down']);
      });
    });
    group('right down up', () {
      test('3', () {
        expect(
            Analyzer()
                .analyze([buttons['d'][1], buttons['c'][2], buttons['d'][3]]),
            ['zig-zag right down up']);
        expect(
            Analyzer()
                .analyze([buttons['d'][2], buttons['c'][3], buttons['d'][4]]),
            ['zig-zag right down up']);
        expect(
            Analyzer()
                .analyze([buttons['d'][3], buttons['c'][4], buttons['d'][5]]),
            ['zig-zag right down up']);
        expect(
            Analyzer()
                .analyze([buttons['d'][4], buttons['c'][5], buttons['d'][6]]),
            ['zig-zag right down up']);
      });
      test('4', () {
        expect(
            Analyzer().analyze([
              buttons['d'][1],
              buttons['c'][2],
              buttons['d'][3],
              buttons['c'][4]
            ]),
            ['zig-zag right down up']);
        expect(
            Analyzer().analyze([
              buttons['d'][2],
              buttons['c'][3],
              buttons['d'][4],
              buttons['c'][5]
            ]),
            ['zig-zag right down up']);
        expect(
            Analyzer().analyze([
              buttons['d'][3],
              buttons['c'][4],
              buttons['d'][5],
              buttons['c'][6]
            ]),
            ['zig-zag right down up']);
      });
      test('5', () {
        expect(
            Analyzer().analyze([
              buttons['d'][1],
              buttons['c'][2],
              buttons['d'][3],
              buttons['c'][4],
              buttons['d'][5]
            ]),
            ['zig-zag right down up']);
        expect(
            Analyzer().analyze([
              buttons['d'][2],
              buttons['c'][3],
              buttons['d'][4],
              buttons['c'][5],
              buttons['d'][6]
            ]),
            ['zig-zag right down up']);
      });
      test('6', () {
        expect(
            Analyzer().analyze([
              buttons['d'][1],
              buttons['c'][2],
              buttons['d'][3],
              buttons['c'][4],
              buttons['d'][5],
              buttons['c'][6]
            ]),
            ['zig-zag right down up']);
      });
    });
    group('up left right', () {
      test('3', () {
        expect(
            Analyzer()
                .analyze([buttons['a'][4], buttons['b'][3], buttons['c'][4]]),
            ['zig-zag up left right']);
        expect(
            Analyzer()
                .analyze([buttons['b'][4], buttons['c'][3], buttons['d'][4]]),
            ['zig-zag up left right']);
        expect(
            Analyzer()
                .analyze([buttons['c'][4], buttons['d'][3], buttons['e'][4]]),
            ['zig-zag up left right']);
        expect(
            Analyzer()
                .analyze([buttons['d'][4], buttons['e'][3], buttons['f'][4]]),
            ['zig-zag up left right']);
      });
      test('4', () {
        expect(
            Analyzer().analyze([
              buttons['a'][4],
              buttons['b'][3],
              buttons['c'][4],
              buttons['d'][3]
            ]),
            ['zig-zag up left right']);
        expect(
            Analyzer().analyze([
              buttons['b'][4],
              buttons['c'][3],
              buttons['d'][4],
              buttons['e'][3]
            ]),
            ['zig-zag up left right']);
        expect(
            Analyzer().analyze([
              buttons['c'][4],
              buttons['d'][3],
              buttons['e'][4],
              buttons['f'][3]
            ]),
            ['zig-zag up left right']);
      });
      test('5', () {
        expect(
            Analyzer().analyze([
              buttons['a'][4],
              buttons['b'][3],
              buttons['c'][4],
              buttons['d'][3],
              buttons['e'][4]
            ]),
            ['zig-zag up left right']);
        expect(
            Analyzer().analyze([
              buttons['b'][4],
              buttons['c'][3],
              buttons['d'][4],
              buttons['e'][3],
              buttons['f'][4]
            ]),
            ['zig-zag up left right']);
      });
      test('6', () {
        expect(
            Analyzer().analyze([
              buttons['a'][4],
              buttons['b'][3],
              buttons['c'][4],
              buttons['d'][3],
              buttons['e'][4],
              buttons['f'][3]
            ]),
            ['zig-zag up left right']);
      });
    });
    group('up right left', () {
      test('3', () {
        expect(
            Analyzer()
                .analyze([buttons['a'][3], buttons['b'][4], buttons['c'][3]]),
            ['zig-zag up right left']);
        expect(
            Analyzer()
                .analyze([buttons['b'][3], buttons['c'][4], buttons['d'][3]]),
            ['zig-zag up right left']);
        expect(
            Analyzer()
                .analyze([buttons['c'][3], buttons['d'][4], buttons['e'][3]]),
            ['zig-zag up right left']);
        expect(
            Analyzer()
                .analyze([buttons['d'][3], buttons['e'][4], buttons['f'][3]]),
            ['zig-zag up right left']);
      });
      test('4', () {
        expect(
            Analyzer().analyze([
              buttons['a'][3],
              buttons['b'][4],
              buttons['c'][3],
              buttons['d'][4]
            ]),
            ['zig-zag up right left']);
        expect(
            Analyzer().analyze([
              buttons['b'][3],
              buttons['c'][4],
              buttons['d'][3],
              buttons['e'][4]
            ]),
            ['zig-zag up right left']);
        expect(
            Analyzer().analyze([
              buttons['c'][3],
              buttons['d'][4],
              buttons['e'][3],
              buttons['f'][4]
            ]),
            ['zig-zag up right left']);
      });
      test('5', () {
        expect(
            Analyzer().analyze([
              buttons['a'][3],
              buttons['b'][4],
              buttons['c'][3],
              buttons['d'][4],
              buttons['e'][3]
            ]),
            ['zig-zag up right left']);
        expect(
            Analyzer().analyze([
              buttons['b'][3],
              buttons['c'][4],
              buttons['d'][3],
              buttons['e'][4],
              buttons['f'][3]
            ]),
            ['zig-zag up right left']);
      });
      test('6', () {
        expect(
            Analyzer().analyze([
              buttons['a'][3],
              buttons['b'][4],
              buttons['c'][3],
              buttons['d'][4],
              buttons['e'][3],
              buttons['f'][4]
            ]),
            ['zig-zag up right left']);
      });
    });
    group('down left right', () {
      test('3', () {
        expect(
            Analyzer()
                .analyze([buttons['f'][4], buttons['e'][3], buttons['d'][4]]),
            ['zig-zag down left right']);
        expect(
            Analyzer()
                .analyze([buttons['e'][4], buttons['d'][3], buttons['c'][4]]),
            ['zig-zag down left right']);
        expect(
            Analyzer()
                .analyze([buttons['d'][4], buttons['c'][3], buttons['b'][4]]),
            ['zig-zag down left right']);
        expect(
            Analyzer()
                .analyze([buttons['c'][4], buttons['b'][3], buttons['a'][4]]),
            ['zig-zag down left right']);
      });
      test('4', () {
        expect(
            Analyzer().analyze([
              buttons['f'][4],
              buttons['e'][3],
              buttons['d'][4],
              buttons['c'][3]
            ]),
            ['zig-zag down left right']);
        expect(
            Analyzer().analyze([
              buttons['e'][4],
              buttons['d'][3],
              buttons['c'][4],
              buttons['b'][3]
            ]),
            ['zig-zag down left right']);
        expect(
            Analyzer().analyze([
              buttons['d'][4],
              buttons['c'][3],
              buttons['b'][4],
              buttons['a'][3]
            ]),
            ['zig-zag down left right']);
      });
      test('5', () {
        expect(
            Analyzer().analyze([
              buttons['f'][4],
              buttons['e'][3],
              buttons['d'][4],
              buttons['c'][3],
              buttons['b'][4]
            ]),
            ['zig-zag down left right']);
        expect(
            Analyzer().analyze([
              buttons['e'][4],
              buttons['d'][3],
              buttons['c'][4],
              buttons['b'][3],
              buttons['a'][4]
            ]),
            ['zig-zag down left right']);
      });
      test('6', () {
        expect(
            Analyzer().analyze([
              buttons['f'][4],
              buttons['e'][3],
              buttons['d'][4],
              buttons['c'][3],
              buttons['b'][4],
              buttons['a'][3]
            ]),
            ['zig-zag down left right']);
      });
    });
    group('down right left', () {
      test('3', () {
        expect(
            Analyzer()
                .analyze([buttons['f'][3], buttons['e'][4], buttons['d'][3]]),
            ['zig-zag down right left']);
        expect(
            Analyzer()
                .analyze([buttons['e'][3], buttons['d'][4], buttons['c'][3]]),
            ['zig-zag down right left']);
        expect(
            Analyzer()
                .analyze([buttons['d'][3], buttons['c'][4], buttons['b'][3]]),
            ['zig-zag down right left']);
        expect(
            Analyzer()
                .analyze([buttons['c'][3], buttons['b'][4], buttons['a'][3]]),
            ['zig-zag down right left']);
      });
      test('4', () {
        expect(
            Analyzer().analyze([
              buttons['f'][3],
              buttons['e'][4],
              buttons['d'][3],
              buttons['c'][4]
            ]),
            ['zig-zag down right left']);
        expect(
            Analyzer().analyze([
              buttons['e'][3],
              buttons['d'][4],
              buttons['c'][3],
              buttons['b'][4]
            ]),
            ['zig-zag down right left']);
        expect(
            Analyzer().analyze([
              buttons['d'][3],
              buttons['c'][4],
              buttons['b'][3],
              buttons['a'][4]
            ]),
            ['zig-zag down right left']);
      });
      test('5', () {
        expect(
            Analyzer().analyze([
              buttons['f'][3],
              buttons['e'][4],
              buttons['d'][3],
              buttons['c'][4],
              buttons['b'][3]
            ]),
            ['zig-zag down right left']);
        expect(
            Analyzer().analyze([
              buttons['e'][3],
              buttons['d'][4],
              buttons['c'][3],
              buttons['b'][4],
              buttons['a'][3]
            ]),
            ['zig-zag down right left']);
      });
      test('6', () {
        expect(
            Analyzer().analyze([
              buttons['f'][3],
              buttons['e'][4],
              buttons['d'][3],
              buttons['c'][4],
              buttons['b'][3],
              buttons['a'][4]
            ]),
            ['zig-zag down right left']);
      });
    });
  });
}
