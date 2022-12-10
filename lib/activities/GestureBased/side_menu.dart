import "package:cross_array_task_app/activities/GestureBased/selection_mode.dart";
import "package:cross_array_task_app/model/schemas/SchemasReader.dart";
import "package:cross_array_task_app/model/shake_widget.dart";
import "package:cross_array_task_app/utility/helper.dart";
import "package:cross_array_task_app/widget/buttons/color_action_button.dart";
import "package:cross_array_task_app/widget/buttons/copy_button.dart";
import "package:cross_array_task_app/widget/buttons/fill_empty.dart";
import "package:cross_array_task_app/widget/buttons/mirror_button_horizontal.dart";
import "package:cross_array_task_app/widget/buttons/mirror_button_vertical.dart";
import "package:cross_array_task_app/widget/buttons/repeat_button.dart";
import "package:cross_array_task_app/widget/buttons/selection_button.dart";
import 'package:dartx/dartx.dart';
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:interpreter/cat_interpreter.dart" as cat;

import "model/cross_button.dart";

/// `SideMenu` is a stateful widget that creates a state object of type
/// `_SideMenuState`
class SideMenu extends StatefulWidget {
  /// A constructor.
  const SideMenu({
    required this.selectedColor,
    required this.interpreter,
    required this.shakeKey,
    required this.selectionMode,
    required this.coloredButtons,
    required this.selectedButtons,
    required this.resetShape,
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

  /// It's a variable that is used to store the current selection mode.
  final ValueNotifier<SelectionModes> selectionMode;

  /// Creating a list of CrossButton objects.
  final ValueNotifier<List<CrossButton>> coloredButtons;

  /// Creating a list of CrossButton objects.
  final ValueNotifier<List<CrossButton>> selectedButtons;

  /// Creating a list of CrossButton objects.
  final ValueNotifier<bool> resetShape;

  @override
  State<StatefulWidget> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  final double _paddingSize = 5;
  final GlobalKey<MirrorButtonHorizontalState>
      _mirrorHorizontalButtonKeyPrimary = GlobalKey();
  late final MirrorButtonHorizontal _mirrorButtonHorizontalPrimary =
      MirrorButtonHorizontal(
    key: _mirrorHorizontalButtonKeyPrimary,
    displayColoring: false,
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

  final GlobalKey<MirrorButtonVerticalState> _mirrorVerticalButtonKeyPrimary =
      GlobalKey();
  late final MirrorButtonVertical _mirrorButtonVerticalPrimary =
      MirrorButtonVertical(
    key: _mirrorVerticalButtonKeyPrimary,
    displayColoring: false,
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
      setState(() {
        _repeatButtonKey.currentState?.deSelect();
        widget.selectionMode.value = SelectionModes.select;
      }),
    },
    onDismiss: () => <void>{
      setState(() {
        widget.selectionMode.value = SelectionModes.base;
        widget.selectedButtons.value.clear();
        widget.resetShape.notifyListeners();
      }),
    },
  );

  final GlobalKey<RepeatButtonState> _repeatButtonKey = GlobalKey();
  late final RepeatButton _repeatButton = RepeatButton(
    key: _repeatButtonKey,
    onSelect: () => <void>{
      setState(() {
        _selectionButtonKey.currentState?.deSelect();
        widget.selectionMode.value = SelectionModes.repeat;
      }),
    },
    onDismiss: () => <void>{
      setState(() {
        widget.selectionMode.value = SelectionModes.base;
        widget.selectedButtons.value.clear();
        widget.coloredButtons.value.clear();
        widget.resetShape.notifyListeners();
      }),
    },
  );

  final GlobalKey<CopyButtonState> _copyButtonSecondaryKey = GlobalKey();
  late final CopyButton _copyButtonSecondary = CopyButton(
    key: _copyButtonSecondaryKey,
    selectionColor: CupertinoColors.systemIndigo,
    background: null,
    onSelect: () => <void>{
      _copyButtonSecondaryKey.currentState?.deSelect(),
    },
    onDismiss: () => <void>{
      _copyButtonSecondaryKey.currentState?.select(),
    },
  );

  final GlobalKey<ColorActionButtonState> _colorActionButtonKey = GlobalKey();
  late final ColorActionButton _colorActionButton = ColorActionButton(
    key: _colorActionButtonKey,
    selectionColor: CupertinoColors.systemIndigo,
    background: null,
    onSelect: () => <void>{
      _colorActionButtonKey.currentState?.deSelect(),
    },
    onDismiss: () => <void>{
      _colorActionButtonKey.currentState?.select(),
    },
  );

  final GlobalKey<CopyButtonState> _copyButtonKey = GlobalKey();
  late final CopyButton _copyButton = CopyButton(
    key: _copyButtonKey,
    selectionColor: CupertinoColors.systemIndigo,
    onSelect: () => <void>{
      setState(
        () {
          _mirrorHorizontalButtonKeySecondary.currentState?.deSelect();
          _mirrorVerticalButtonKeySecondary.currentState?.deSelect();
        },
      ),
    },
    onDismiss: () => <void>{
      setState(() {}),
    },
  );

  final GlobalKey<MirrorButtonHorizontalState>
      _mirrorHorizontalButtonKeySecondary = GlobalKey();
  late final MirrorButtonHorizontal _mirrorButtonHorizontalSecondary =
      MirrorButtonHorizontal(
    key: _mirrorHorizontalButtonKeySecondary,
    selectionColor: CupertinoColors.systemIndigo,
    onSelect: () => <void>{
      setState(
        () {
          _copyButtonKey.currentState?.deSelect();
          _mirrorVerticalButtonKeySecondary.currentState?.deSelect();
        },
      ),
    },
    onDismiss: () => <void>{
      setState(() {}),
    },
  );

  final GlobalKey<MirrorButtonVerticalState> _mirrorVerticalButtonKeySecondary =
      GlobalKey();
  late final MirrorButtonVertical _mirrorButtonVerticalSecondary =
      MirrorButtonVertical(
    key: _mirrorVerticalButtonKeySecondary,
    selectionColor: CupertinoColors.systemIndigo,
    onSelect: () => <void>{
      setState(
        () {
          _copyButtonKey.currentState?.deSelect();
          _mirrorHorizontalButtonKeySecondary.currentState?.deSelect();
        },
      ),
    },
    onDismiss: () => <void>{
      setState(() {}),
    },
  );

  final GlobalKey<FillEmptyState> _fillEmptyButtonKey = GlobalKey();
  late final FillEmpty _fillEmptyButton = FillEmpty(
    key: _fillEmptyButtonKey,
    displayColoring: false,
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
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Column(
              children: <Widget>[
                ..._colorButtonsBuild(),
                _fillEmptyButton,
                _mirrorButtonHorizontalPrimary,
                _mirrorButtonVerticalPrimary,
                _repeatButton,
                _selectionButton,
              ],
            ),
            Column(
              children: <Widget>[
                Visibility(
                  visible: widget.selectionMode.value == SelectionModes.repeat,
                  replacement: Padding(
                    padding: EdgeInsets.all(_paddingSize),
                    child: SizedBox.fromSize(
                      size: const Size(50, 50),
                    ),
                  ),
                  child: Column(
                    children: <Widget>[
                      _colorActionButton,
                      const Divider(
                        height: 20,
                      ),
                      _copyButtonSecondary,
                      const Divider(
                        height: 20,
                      ),
                      Padding(
                        padding: EdgeInsets.all(_paddingSize),
                        child: CupertinoButton(
                          onPressed: repeatAdvancement,
                          minSize: 50,
                          padding: EdgeInsets.zero,
                          borderRadius: BorderRadius.circular(100),
                          color: CupertinoColors.systemGreen.highContrastColor,
                          child: const Icon(CupertinoIcons.check_mark),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(_paddingSize),
                        child: CupertinoButton(
                          onPressed: () {
                            _repeatButtonKey.currentState?.whenSelected();
                          },
                          minSize: 50,
                          padding: EdgeInsets.zero,
                          borderRadius: BorderRadius.circular(100),
                          color: CupertinoColors.systemRed.highContrastColor,
                          child: const Icon(CupertinoIcons.xmark),
                        ),
                      ),
                    ],
                  ),
                ),
                Visibility(
                  visible: widget.selectionMode.value == SelectionModes.select,
                  child: Column(
                    children: <Widget>[
                      const Divider(
                        height: 20,
                      ),
                      _copyButton,
                      _mirrorButtonHorizontalSecondary,
                      _mirrorButtonVerticalSecondary,
                      const Divider(
                        height: 20,
                      ),
                      Padding(
                        padding: EdgeInsets.all(_paddingSize),
                        child: CupertinoButton(
                          onPressed: () {},
                          minSize: 50,
                          padding: EdgeInsets.zero,
                          borderRadius: BorderRadius.circular(100),
                          color: CupertinoColors.systemGreen.highContrastColor,
                          child: const Icon(CupertinoIcons.check_mark),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(_paddingSize),
                        child: CupertinoButton(
                          onPressed: () {
                            setState(() {
                              _selectionButtonKey.currentState?.whenSelected();
                            });
                          },
                          minSize: 50,
                          padding: EdgeInsets.zero,
                          borderRadius: BorderRadius.circular(100),
                          color: CupertinoColors.systemRed.highContrastColor,
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

  void repeatAdvancement() {
    if (widget.coloredButtons.value.isNotEmpty &&
        widget.selectionMode.value == SelectionModes.repeat) {
      _colorActionButtonKey.currentState?.deSelect();
      _copyButtonSecondaryKey.currentState?.select();
      widget.selectionMode.value = SelectionModes.select;
    } else if (widget.selectedButtons.value.isNotEmpty &&
        widget.selectionMode.value == SelectionModes.select) {
      final List<Pair<int, int>> origins = <Pair<int, int>>[];
      final List<Pair<int, int>> destinations = <Pair<int, int>>[];
      for (CrossButton b in widget.coloredButtons.value) {
        origins.add(b.position);
      }
      for (CrossButton b in widget.selectedButtons.value) {
        destinations.add(b.position);
      }
      final List<String> originsPosition = <String>[];
      final List<String> destinationPosition = <String>[];
      for (final Pair<int, int> i in origins) {
        originsPosition.add("${rows[i.first]}${i.second + 1}");
      }
      for (final Pair<int, int> i in destinations) {
        destinationPosition.add("${rows[i.first]}${i.second + 1}");
      }
      String code = "COPY({${originsPosition.joinToString(separator: ",")}},"
          "{${destinationPosition.joinToString(separator: ",")}})";
      widget.interpreter.value
          .validateOnScheme(code, SchemasReader().currentIndex);
      widget.interpreter.notifyListeners();
      _repeatButtonKey.currentState?.whenSelected();
    } else {
      widget.shakeKey.currentState?.shake();
    }
  }
}
