import "dart:ui";

import "package:cross_array_task_app/activities/gesture_based/model/cross_button.dart";
import "package:cross_array_task_app/activities/gesture_based/selection_mode.dart";
import "package:cross_array_task_app/activities/gesture_based/widget/buttons/color_action_button.dart";
import "package:cross_array_task_app/activities/gesture_based/widget/buttons/copy_button.dart";
import "package:cross_array_task_app/activities/gesture_based/widget/buttons/fill_empty.dart";
import "package:cross_array_task_app/activities/gesture_based/widget/buttons/mirror_button_horizontal.dart";
import "package:cross_array_task_app/activities/gesture_based/widget/buttons/mirror_button_vertical.dart";
import "package:cross_array_task_app/activities/gesture_based/widget/buttons/repeat_button.dart";
import "package:cross_array_task_app/activities/gesture_based/widget/buttons/selection_action_button.dart";
import "package:cross_array_task_app/activities/gesture_based/widget/buttons/selection_button.dart";
import "package:cross_array_task_app/model/interpreter/cat_interpreter.dart";
import "package:cross_array_task_app/model/shake_widget.dart";
import "package:cross_array_task_app/utility/cat_log.dart";
import "package:cross_array_task_app/utility/localizations.dart";
import "package:cross_array_task_app/utility/selected_colors_notifier.dart";
import "package:dartx/dartx.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:provider/provider.dart";

/// `SideMenu` is a stateful widget that creates a state object of type
/// `_SideMenuState`
class SideMenu extends StatefulWidget {
  /// A constructor.
  const SideMenu({
    required this.shakeKey,
    required this.selectionMode,
    required this.coloredButtons,
    required this.selectedButtons,
    required this.resetShape,
    super.key,
  });

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
  State<StatefulWidget> createState() => SideMenuState();
}

class SideMenuState extends State<SideMenu> {
  final double _paddingSize = 5;

  /// Creating a GlobalKey for the SelectionButton widget.
  final GlobalKey<SelectionButtonState> selectionButtonKey = GlobalKey();

  /// Creating a GlobalKey for the RepeatButton widget.
  final GlobalKey<RepeatButtonState> repeatButtonKey = GlobalKey();

  /// Creating a GlobalKey for the CopyButton widget.
  final GlobalKey<CopyButtonSecondatyState> copyButtonSecondaryKey =
      GlobalKey();

  /// Creating a GlobalKey for the ColorActionButton widget.
  final GlobalKey<ColorActionButtonState> colorActionButtonKey = GlobalKey();

  /// Creating a global key for the selection action button.
  final GlobalKey<SelectionActionButtonState> selectionActionButtonKey =
      GlobalKey();

  /// Creating a global key for the CopyButton widget.
  final GlobalKey<CopyButtonState> copyButtonKey = GlobalKey();

  /// Creating a GlobalKey for the MirrorButtonHorizontal widget.
  final GlobalKey<MirrorButtonHorizontalStateSecondary>
      mirrorHorizontalButtonKeySecondary = GlobalKey();

  /// Creating a GlobalKey for the MirrorButtonVertical widget.
  final GlobalKey<MirrorButtonVerticalStateSecondary>
      mirrorVerticalButtonKeySecondary = GlobalKey();

  bool added = false;

  void _interpreterListener() {
    if (!mounted) {
      return;
    }
    if (widget.selectionMode.value == SelectionModes.base) {
      repeatButtonKey.currentState?.deSelect();
      selectionButtonKey.currentState?.deSelect();
      if (!added) {
        CatInterpreter().addListener(_interpreterListener);
        added = !added;
      }
    }
  }

  @override
  void initState() {
    widget.selectionMode.addListener(_interpreterListener);
    super.initState();
  }

  List<Widget> _colorButtonsBuild() {
    const TextStyle textStyle = TextStyle(
      color: CupertinoColors.black,
      fontFamily: "CupertinoIcons",
      fontFeatures: <FontFeature>[
        FontFeature.tabularFigures(),
      ],
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
              animation: context.watch<SelectedColorsNotifier>(),
              builder: (BuildContext context, Widget? child) => CupertinoButton(
                key: Key(colors[color]!),
                onPressed: () {
                  if (widget.selectionMode.value ==
                          SelectionModes.mirrorHorizontal ||
                      widget.selectionMode.value ==
                          SelectionModes.mirrorVertical ||
                      widget.selectionMode.value == SelectionModes.multiple ||
                      widget.selectionMode.value == SelectionModes.select ||
                      widget.selectionMode.value == SelectionModes.transition) {
                    return null;
                  }

                  return () => setState(() {
                        if (context
                            .read<SelectedColorsNotifier>()
                            .contains(color)) {
                          context.read<SelectedColorsNotifier>().remove(color);
                        } else {
                          context.read<SelectedColorsNotifier>().add(color);
                        }
                      });
                }.call(),
                borderRadius: BorderRadius.circular(45),
                minSize: 50,
                color: color,
                padding: EdgeInsets.zero,
                child: context.read<SelectedColorsNotifier>().contains(color)
                    ? Stack(
                        alignment: AlignmentDirectional.center,
                        children: <Widget>[
                          const Icon(
                            CupertinoIcons.circle_filled,
                            size: 30,
                          ),
                          Text(
                            "${context.read<SelectedColorsNotifier>().indexOf(color) + 1}",
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
        padding: const EdgeInsets.all(5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Column(
              children: <Widget>[
                AnimatedBuilder(
                  animation: widget.selectionMode,
                  builder: (_, __) => Column(
                    children: _colorButtonsBuild(),
                  ),
                ),
                const SizedBox(
                  height: 130,
                ),
                FillEmpty(
                  state: this,
                ),
                SelectionButton(
                  state: this,
                  key: selectionButtonKey,
                ),
                RepeatButton(
                  state: this,
                  key: repeatButtonKey,
                ),
                MirrorButtonHorizontal(
                  state: this,
                ),
                MirrorButtonVertical(
                  state: this,
                ),
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
                      ColorActionButton(
                        key: colorActionButtonKey,
                        selectionColor: Colors.teal,
                        state: this,
                        background: null,
                      ),
                      const Divider(
                        height: 20,
                      ),
                      CopyButtonSecondary(
                        key: copyButtonSecondaryKey,
                        selectionColor: Colors.teal,
                        background: null,
                        state: this,
                      ),
                      const Divider(
                        height: 20,
                      ),
                      Padding(
                        padding: EdgeInsets.all(_paddingSize),
                        child: CupertinoButton(
                          onPressed: _repeatAdvancement,
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
                            repeatButtonKey.currentState?.whenSelected();
                            widget.selectionMode.value = SelectionModes.base;
                            CatInterpreter().deleteCopyCommands();
                            CatLogger().addLog(
                              context: context,
                              previousCommand: "",
                              currentCommand: "copy commands",
                              description: CatLoggingLevel.dismissCommand,
                            );
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
                  visible:
                      widget.selectionMode.value == SelectionModes.multiple,
                  maintainState: true,
                  child: Column(
                    children: <Widget>[
                      SelectionActionButton(
                        key: selectionActionButtonKey,
                        selectionColor: Colors.teal,
                        background: null,
                        state: this,
                      ),
                      const Divider(
                        height: 20,
                      ),
                      CopyButton(
                        key: copyButtonKey,
                        selectionColor: Colors.teal,
                        state: this,
                      ),
                      MirrorButtonHorizontalSecondary(
                        state: this,
                        key: mirrorHorizontalButtonKeySecondary,
                        selectionColor: Colors.teal,
                      ),
                      MirrorButtonVerticalSecondary(
                        state: this,
                        key: mirrorVerticalButtonKeySecondary,
                        selectionColor: Colors.teal,
                      ),
                      const Divider(
                        height: 20,
                      ),
                      Padding(
                        padding: EdgeInsets.all(_paddingSize),
                        child: CupertinoButton(
                          onPressed: () {
                            if (widget.coloredButtons.value.isNotEmpty &&
                                widget.selectionMode.value ==
                                    SelectionModes.multiple) {
                              selectionActionButtonKey.currentState?.deSelect();
                              widget.selectionMode.value =
                                  SelectionModes.transition;
                              copyButtonKey.currentState?.activate();
                              mirrorHorizontalButtonKeySecondary.currentState
                                  ?.activate();
                              mirrorVerticalButtonKeySecondary.currentState
                                  ?.activate();

                              return;
                            }
                            if (widget.selectedButtons.value.isNotEmpty &&
                                widget.selectionMode.value ==
                                    SelectionModes.select) {
                              _copyCells();
                              selectionButtonKey.currentState?.whenSelected();
                              widget.selectionMode.value = SelectionModes.base;

                              return;
                            }
                            if (widget.selectionMode.value ==
                                SelectionModes.mirrorVertical) {
                              _mirrorCells("vertical");
                              selectionButtonKey.currentState?.whenSelected();
                              widget.selectionMode.value = SelectionModes.base;

                              return;
                            }
                            if (widget.selectionMode.value ==
                                SelectionModes.mirrorHorizontal) {
                              _mirrorCells("horizontal");
                              selectionButtonKey.currentState?.whenSelected();
                              widget.selectionMode.value = SelectionModes.base;

                              return;
                            }
                            widget.shakeKey.currentState?.shake();
                            CatLogger().addLog(
                              context: context,
                              previousCommand: "",
                              currentCommand:
                                  CatInterpreter().getResults.getCommands.last,
                              description: CatLoggingLevel.confirmCommand,
                            );
                          },
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
                              selectionButtonKey.currentState?.whenSelected();
                              mirrorVerticalButtonKeySecondary.currentState
                                  ?.whenSelected();
                              widget.selectionMode.value = SelectionModes.base;
                            });
                            CatLogger().addLog(
                              context: context,
                              previousCommand: "",
                              currentCommand: "cells selection",
                              description: CatLoggingLevel.dismissCommand,
                            );
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

  void _repeatAdvancement() {
    if (widget.coloredButtons.value.isNotEmpty &&
        widget.selectionMode.value == SelectionModes.repeat) {
      colorActionButtonKey.currentState?.deSelect();
      copyButtonSecondaryKey.currentState?.select();
      widget.selectionMode.value = SelectionModes.select;
    } else if (widget.selectedButtons.value.isNotEmpty &&
        widget.selectionMode.value == SelectionModes.select) {
      _copyCells();
      repeatButtonKey.currentState?.whenSelected();
      widget.selectionMode.value = SelectionModes.base;
    } else {
      widget.shakeKey.currentState?.shake();
    }
    CatLogger().addLog(
      context: context,
      previousCommand: "",
      currentCommand: CatInterpreter().getResults.getCommands.last,
      description: CatLoggingLevel.confirmCommand,
    );
  }

  void _copyCells() {
    final List<Pair<int, int>> origins = <Pair<int, int>>[];
    final List<Pair<int, int>> destinations = <Pair<int, int>>[];
    for (final CrossButton b in widget.coloredButtons.value) {
      origins.add(b.position);
    }
    for (final CrossButton b in widget.selectedButtons.value) {
      destinations.add(b.position);
    }
    if (CatInterpreter().copyCells(
      origins,
      destinations,
      CATLocalizations.of(context).languageCode,
    )) {
      widget.shakeKey.currentState?.shake();
    }
  }

  void _mirrorCells(String direction) {
    final List<Pair<int, int>> origins = <Pair<int, int>>[];
    for (final CrossButton i in widget.selectedButtons.value) {
      i.unSelect();
    }
    widget.selectedButtons.value.clear();
    for (final CrossButton b in widget.coloredButtons.value) {
      origins.add(b.position);
    }
    CatInterpreter().mirrorCells(
      direction,
      origins,
      CATLocalizations.of(context).languageCode,
    );
  }

  @override
  void dispose() {
    CatInterpreter().removeListener(_interpreterListener);
    super.dispose();
  }
}
