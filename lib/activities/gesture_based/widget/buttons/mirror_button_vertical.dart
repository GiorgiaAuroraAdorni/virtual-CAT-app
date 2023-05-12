import "package:cross_array_task_app/activities/gesture_based/model/cross_button.dart";
import "package:cross_array_task_app/activities/gesture_based/selection_mode.dart";
import "package:cross_array_task_app/activities/gesture_based/side_menu.dart";
import "package:cross_array_task_app/activities/gesture_based/widget/buttons/action_button.dart";
import "package:cross_array_task_app/model/interpreter/cat_interpreter.dart";
import "package:cross_array_task_app/utility/cat_log.dart";
import "package:cross_array_task_app/utility/localizations.dart";
import "package:dartx/dartx.dart";
import "package:flutter/cupertino.dart";
import "package:flutter_svg/svg.dart";

/// `MirrorButtonVertical` is a stateful widget that displays a vertical mirror
/// button that calls `onSelect` when selected and `onDismiss` when dismissed
class MirrorButtonVertical extends ActionButton {
  /// A constructor.
  const MirrorButtonVertical({
    required this.state,
    super.displayColoring = false,
    super.selectionColor,
    super.background,
    super.key,
  });

  /// A reference to the state of the side menu.
  final SideMenuState state;

  @override
  MirrorButtonVerticalState createState() => MirrorButtonVerticalState();
}

/// It's a button that rotates 90 degrees and changes color when pressed
class MirrorButtonVerticalState
    extends ActionButtonState<MirrorButtonVertical> {
  final double _paddingSize = 5;

  @override
  Widget build(BuildContext context) {
    if (widget.state.widget.selectionMode.value == SelectionModes.base) {
      activateNoState();
    } else {
      deActivateNoState();
    }

    return AnimatedBuilder(
      animation: CatInterpreter(),
      builder: (BuildContext context, Widget? child) {
        if (!active ||
            (CatInterpreter().executedCommands == 1 && additionalFlag)) {
          return Padding(
            padding: EdgeInsets.all(_paddingSize),
            child: CupertinoButton(
              onPressed: null,
              color: widget.background,
              minSize: 50,
              padding: EdgeInsets.zero,
              borderRadius: BorderRadius.circular(45),
              child: SvgPicture.asset(
                "resources/icons/mirror_horizontal.svg",
                height: 20,
                colorFilter: const ColorFilter.matrix(<double>[
                  -1, 0, 0, 0, 255, //
                  0, -1, 0, 0, 255, //
                  0, 0, -1, 0, 255, //
                  0, 0, 0, 1, 0, //
                ]),
              ),
            ),
          );
        }

        return Padding(
          padding: EdgeInsets.all(_paddingSize),
          child: CupertinoButton(
            onPressed: selected ? whenSelected : whenNotSelected,
            borderRadius: BorderRadius.circular(45),
            minSize: 50,
            padding: EdgeInsets.zero,
            color: selected ? widget.selectionColor : widget.background,
            child: SvgPicture.asset(
              "resources/icons/mirror_vertical.svg",
              height: 20,
              colorFilter: selected
                  ? const ColorFilter.matrix(<double>[
                      -1, 0, 0, 0, 255, //
                      0, -1, 0, 0, 255, //
                      0, 0, -1, 0, 255, //
                      0, 0, 0, 1, 0, //
                    ])
                  : const ColorFilter.matrix(<double>[
                      1, 0, 0, 0, 0, //
                      0, 1, 0, 0, 0, //
                      0, 0, 1, 0, 0, //
                      0, 0, 0, 1, 0, //
                    ]),
            ),
          ),
        );
      },
    );
  }

  @override
  void onSelect() {
    if (CatInterpreter().executedCommands > 1) {
      CatInterpreter()
          .mirror("vertical", CATLocalizations.of(context).languageCode);
    } else {
      widget.state.widget.shakeKey.currentState?.shake();
    }
    CatLogger().addLog(
      context: context,
      previousCommand: "",
      currentCommand: "mirror vertical",
      description: CatLoggingLevel.buttonSelect,
    );
  }

  @override
  void onDismiss() {}
}

/// It's a button that mirrors the image vertically
class MirrorButtonVerticalSecondary extends ActionButton {
  /// It's a constructor.
  const MirrorButtonVerticalSecondary({
    required this.state,
    super.displayColoring,
    super.selectionColor,
    super.background,
    super.key,
  });

  /// A reference to the state of the side menu.
  final SideMenuState state;

  @override
  MirrorButtonVerticalStateSecondary createState() =>
      MirrorButtonVerticalStateSecondary();
}

class MirrorButtonVerticalStateSecondary
    extends ActionButtonState<MirrorButtonVerticalSecondary> {
  final double _paddingSize = 5;

  @override
  void initState() {
    super.initState();
    super.icon = CupertinoIcons.square_fill_line_vertical_square;
  }

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
        animation: widget.state.widget.selectionMode,
        builder: (BuildContext c, Widget? w) {
          if (widget.state.widget.selectionMode.value !=
              SelectionModes.multiple) {
            activateNoState();
          } else {
            deActivateNoState();
          }

          return AnimatedBuilder(
            animation: CatInterpreter(),
            builder: (BuildContext context, Widget? child) {
              if (!active ||
                  (CatInterpreter().executedCommands == 1 && additionalFlag)) {
                return Padding(
                  padding: EdgeInsets.all(_paddingSize),
                  child: CupertinoButton(
                    onPressed: null,
                    color: widget.background,
                    minSize: 50,
                    padding: EdgeInsets.zero,
                    borderRadius: BorderRadius.circular(45),
                    child: SvgPicture.asset(
                      "resources/icons/mirror_horizontal.svg",
                      height: 20,
                      colorFilter: const ColorFilter.matrix(<double>[
                        -1, 0, 0, 0, 255, //
                        0, -1, 0, 0, 255, //
                        0, 0, -1, 0, 255, //
                        0, 0, 0, 1, 0, //
                      ]),
                    ),
                  ),
                );
              }

              return Padding(
                padding: EdgeInsets.all(_paddingSize),
                child: CupertinoButton(
                  onPressed: selected ? whenSelected : whenNotSelected,
                  borderRadius: BorderRadius.circular(45),
                  minSize: 50,
                  padding: EdgeInsets.zero,
                  color: selected ? widget.selectionColor : widget.background,
                  child: SvgPicture.asset(
                    "resources/icons/mirror_vertical.svg",
                    height: 20,
                    colorFilter: selected
                        ? const ColorFilter.matrix(<double>[
                            -1, 0, 0, 0, 255, //
                            0, -1, 0, 0, 255, //
                            0, 0, -1, 0, 255, //
                            0, 0, 0, 1, 0, //
                          ])
                        : const ColorFilter.matrix(<double>[
                            1, 0, 0, 0, 0, //
                            0, 1, 0, 0, 0, //
                            0, 0, 1, 0, 0, //
                            0, 0, 0, 1, 0, //
                          ]),
                  ),
                ),
              );
            },
          );
        },
      );

  @override
  void onSelect() {
    widget.state.copyButtonKey.currentState?.deSelect();
    widget.state.mirrorHorizontalButtonKeySecondary.currentState?.deSelect();
    widget.state.widget.selectionMode.value = SelectionModes.mirrorVertical;
    for (final CrossButton i in widget.state.widget.coloredButtons.value) {
      final Pair<int, int> pos = i.position;
      final Widget button = i.buttons[pos.first].children[5 - pos.second];
      if (button is CrossButton) {
        button.selectRepeat();
        widget.state.widget.selectedButtons.value.add(button);
      }
    }
    CatLogger().addLog(
      context: context,
      previousCommand: "",
      currentCommand: "cells mirror vertical",
      description: CatLoggingLevel.buttonSelect,
    );
  }

  @override
  void onDismiss() {
    super.deSelect();
    widget.state.widget.selectionMode.value = SelectionModes.transition;
    for (final CrossButton i in widget.state.widget.selectedButtons.value) {
      i.unSelect();
    }
    widget.state.widget.selectedButtons.value.clear();
    CatLogger().addLog(
      context: context,
      previousCommand: "",
      currentCommand: "cells mirror vertical",
      description: CatLoggingLevel.buttonDismiss,
    );
  }
}
