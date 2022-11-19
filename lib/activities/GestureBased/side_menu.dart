import "package:cross_array_task_app/widget/buttons/copy_button.dart";
import "package:cross_array_task_app/widget/buttons/fill_empty.dart";
import "package:cross_array_task_app/widget/buttons/mirror_button_horizontal.dart";
import "package:cross_array_task_app/widget/buttons/mirror_button_vertical.dart";
import "package:cross_array_task_app/widget/buttons/repeat_button.dart";
import "package:cross_array_task_app/widget/buttons/selection_button.dart";
import "package:flutter/cupertino.dart";

/// `SideMenu` is a stateful widget that creates a state object of type
/// `_SideMenuState`
class SideMenu extends StatefulWidget {
  /// A constructor.
  const SideMenu({
    required this.selectedColor,
    super.key,
  });

  final ValueNotifier<List<CupertinoDynamicColor>> selectedColor;

  @override
  State<StatefulWidget> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  final double _paddingSize = 5;
  final GlobalKey<MirrorButtonHorizontalState> _mirrorHorizontalButtonKey =
      GlobalKey();
  late final MirrorButtonHorizontal _mirrorButtonHorizontal =
      MirrorButtonHorizontal(
    key: _mirrorHorizontalButtonKey,
    onSelect: () => <void>{
      setState(() {}),
    },
    onDismiss: () => <void>{
      setState(() {}),
    },
  );

  final GlobalKey<MirrorButtonVerticalState> _mirrorVerticalButtonKey =
      GlobalKey();
  late final MirrorButtonVertical _mirrorButtonVertical = MirrorButtonVertical(
    key: _mirrorVerticalButtonKey,
    onSelect: () => <void>{
      setState(() {}),
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
      setState(() {}),
    },
    onDismiss: () => <void>{
      setState(() {}),
    },
  );

  final GlobalKey<FillEmptyState> _fillEmptyButtonKey = GlobalKey();
  late final FillEmpty _fillEmptyButton = FillEmpty(
    key: _fillEmptyButtonKey,
    onSelect: () => <void>{
      setState(() {}),
    },
    onDismiss: () => <void>{
      setState(() {}),
    },
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
              children: <Widget>[],
            ),
          ],
        ),
      );
}
