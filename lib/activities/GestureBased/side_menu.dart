import 'package:cross_array_task_app/activities/GestureBased/selection_mode.dart';
import 'package:cross_array_task_app/model/shake_widget.dart';
import "package:cross_array_task_app/utility/helper.dart";
import "package:cross_array_task_app/widget/buttons/copy_button.dart";
import "package:cross_array_task_app/widget/buttons/fill_empty.dart";
import "package:cross_array_task_app/widget/buttons/mirror_button_horizontal.dart";
import "package:cross_array_task_app/widget/buttons/mirror_button_vertical.dart";
import "package:cross_array_task_app/widget/buttons/repeat_button.dart";
import "package:cross_array_task_app/widget/buttons/selection_button.dart";
import "package:flutter/cupertino.dart";
import "package:interpreter/cat_interpreter.dart" as cat;

import '../../model/schemas/SchemasReader.dart';

/// `SideMenu` is a stateful widget that creates a state object of type
/// `_SideMenuState`
class SideMenu extends StatefulWidget {
  /// A constructor.
  const SideMenu({
    required this.selectedColor,
    required this.interpreter,
    required this.shakeKey,
    super.key,
  });

  /// A value notifier that is used to notify the interpreter that the user has
  /// selected a color.
  final ValueNotifier<List<CupertinoDynamicColor>> selectedColor;

  /// A value notifier that is used to notify the interpreter that the user has
  /// selected a color.
  final ValueNotifier<cat.CATInterpreter> interpreter;

  /// It's a key that is used to access the state of the `ShakeWidget`
  final GlobalKey<ShakeWidgetState> shakeKey;

  @override
  State<StatefulWidget> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  final double _paddingSize = 5;
  SelectionModes _selectionMode = SelectionModes.base;
  final GlobalKey<MirrorButtonHorizontalState> _mirrorHorizontalButtonKey =
      GlobalKey();
  late final MirrorButtonHorizontal _mirrorButtonHorizontal =
      MirrorButtonHorizontal(
    key: _mirrorHorizontalButtonKey,
    onSelect: () {
      if (widget.interpreter.value.getResults.getCommands.length > 1) {
        String code = "mirror(horizontal)";
        widget.interpreter.value
            .validateOnScheme(code, SchemasReader().currentIndex);
        widget.interpreter.notifyListeners();
      } else {
        widget.shakeKey.currentState?.shake();
      }
    },
    onDismiss: () => <void>{
      setState(() {}),
    },
  );

  final GlobalKey<MirrorButtonVerticalState> _mirrorVerticalButtonKey =
      GlobalKey();
  late final MirrorButtonVertical _mirrorButtonVertical = MirrorButtonVertical(
    key: _mirrorVerticalButtonKey,
    onSelect: () {
      if (widget.interpreter.value.getResults.getCommands.length > 1) {
        String code = "mirror(vertical)";
        widget.interpreter.value
            .validateOnScheme(code, SchemasReader().currentIndex);
        widget.interpreter.notifyListeners();
      } else {
        widget.shakeKey.currentState?.shake();
      }
    },
    onDismiss: () => <void>{
      setState(() {}),
    },
  );

  final GlobalKey<SelectionButtonState> _selectionButtonKey = GlobalKey();
  late final SelectionButton _selectionButton = SelectionButton(
    key: _selectionButtonKey,
    onSelect: () => <void>{
      setState(() {}),
    },
    onDismiss: () => <void>{
      setState(() {}),
    },
  );

  final GlobalKey<CopyButtonState> _copyButtonKey = GlobalKey();
  late final CopyButton _copyButton = CopyButton(
    key: _copyButtonKey,
    onSelect: () => <void>{
      setState(() {}),
    },
    onDismiss: () => <void>{
      setState(() {}),
    },
  );

  final GlobalKey<RepeatButtonState> _repeatButtonKey = GlobalKey();
  late final RepeatButton _repeatButton = RepeatButton(
    key: _repeatButtonKey,
    onSelect: () => <void>{
      setState(() {
        _selectionMode = SelectionModes.repeat;
      }),
    },
    onDismiss: () => <void>{
      setState(() {
        _selectionMode = SelectionModes.base;
      }),
    },
  );

  final GlobalKey<FillEmptyState> _fillEmptyButtonKey = GlobalKey();
  late final FillEmpty _fillEmptyButton = FillEmpty(
    key: _fillEmptyButtonKey,
    onSelect: () {
      final List<String> colors = analyzeColor(widget.selectedColor.value);
      if (colors.length != 1) {
        widget.shakeKey.currentState?.shake();

        return;
      }
      String code = "fill_empty(${colors.first})";
      widget.interpreter.value
          .validateOnScheme(code, SchemasReader().currentIndex);
      widget.interpreter.notifyListeners();
      widget.selectedColor.value = <CupertinoDynamicColor>[];
    },
    onDismiss: () {},
  );

  List<Widget> _colorButtonsBuild() {
    const TextStyle textStyle = TextStyle(
      color: CupertinoColors.black,
      fontFamily: "CupertinoIcons",
    );
    final Map<CupertinoDynamicColor, String> colors =
        <CupertinoDynamicColor, String>{
      CupertinoColors.systemBlue: "ColorButtonBlue",
      CupertinoColors.systemRed: "ColorButtonRed",
      CupertinoColors.systemGreen: "ColorButtonGreen",
      CupertinoColors.systemYellow: "ColorButtonYellow",
    };

    return colors.keys
        .map(
          (CupertinoDynamicColor color) => Padding(
            padding: EdgeInsets.all(_paddingSize),
            child: AnimatedBuilder(
              animation: widget.selectedColor,
              builder: (BuildContext context, Widget? child) => CupertinoButton(
                key: Key(colors[color]!),
                onPressed: () => setState(() {
                  if (widget.selectedColor.value.contains(color)) {
                    widget.selectedColor.value.remove(color);
                  } else {
                    widget.selectedColor.value.add(color);
                  }
                }),
                borderRadius: BorderRadius.circular(45),
                minSize: 50,
                color: color,
                padding: EdgeInsets.zero,
                child: widget.selectedColor.value.contains(color)
                    ? Stack(
                        alignment: AlignmentDirectional.center,
                        children: <Widget>[
                          const Icon(CupertinoIcons.circle_filled),
                          Text(
                            "${widget.selectedColor.value.indexOf(color) + 1}",
                            style: textStyle,
                          ),
                        ],
                      )
                    : const Text(""),
              ),
            ),
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: <Widget>[
            Column(
              children: <Widget>[
                ..._colorButtonsBuild(),
                _fillEmptyButton,
                _repeatButton,
                _selectionButton,
                _copyButton,
                _mirrorButtonHorizontal,
                _mirrorButtonVertical,
              ],
            ),
            Column(
              children: <Widget>[
                Visibility(
                  visible: _selectionMode == SelectionModes.repeat,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(_paddingSize),
                        child: CupertinoButton(
                          onPressed: () {},
                          minSize: 50,
                          padding: EdgeInsets.zero,
                          borderRadius: BorderRadius.circular(100),
                          color: CupertinoColors.systemGreen,
                          child: const Icon(CupertinoIcons.check_mark),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(_paddingSize),
                        child: CupertinoButton(
                          onPressed: () {},
                          minSize: 50,
                          padding: EdgeInsets.zero,
                          borderRadius: BorderRadius.circular(100),
                          color: CupertinoColors.systemRed,
                          child: const Icon(CupertinoIcons.xmark),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      );
}
