import "package:cross_array_task_app/widget/copy/copy_button.dart";
import "package:cross_array_task_app/widget/mirror/mirror_button_horizontal.dart";
import "package:cross_array_task_app/widget/mirror/mirror_button_vertical.dart";
import "package:cross_array_task_app/widget/repeat/repeat_button.dart";
import "package:cross_array_task_app/widget/selection/selection_button.dart";
import "package:flutter/cupertino.dart";

class SideMenu extends StatefulWidget {
  const SideMenu({super.key});

  @override
  _SideMenuState createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  final double _paddingSize = 5;

  final GlobalKey<MirrorButtonHorizontalState> _mirrorHorizontalButtonKey =
      GlobalKey();
  late final Padding _mirrorButtonHorizontal = Padding(
    padding: EdgeInsets.all(_paddingSize),
    child: MirrorButtonHorizontal(
      key: _mirrorHorizontalButtonKey,
      onSelect: () => <void>{
        setState(() {}),
      },
      onDismiss: () => <void>{
        setState(() {}),
      },
    ),
  );

  final GlobalKey<MirrorButtonVerticalState> _mirrorVerticalButtonKey =
      GlobalKey();
  late final Padding _mirrorButtonVertical = Padding(
    padding: EdgeInsets.all(_paddingSize),
    child: MirrorButtonVertical(
      key: _mirrorVerticalButtonKey,
      onSelect: () => <void>{
        setState(() {}),
      },
      onDismiss: () => <void>{
        setState(() {}),
      },
    ),
  );

  final GlobalKey<SelectionButtonState> _selectionButtonKey = GlobalKey();
  late final Padding _selectionButton = Padding(
    padding: EdgeInsets.all(_paddingSize),
    child: SelectionButton(
      key: _selectionButtonKey,
      onSelect: () => <void>{
        setState(() {}),
      },
      onDismiss: () => <void>{
        setState(() {}),
      },
    ),
  );

  final GlobalKey<CopyButtonState> _copyButtonKey = GlobalKey();
  late final Padding _copyButton = Padding(
    padding: EdgeInsets.all(_paddingSize),
    child: CopyButton(
      key: _copyButtonKey,
      onSelect: () => <void>{
        setState(() {}),
      },
      onDismiss: () => <void>{
        setState(() {}),
      },
    ),
  );

  final GlobalKey<RepeatButtonState> _repeatButtonKey = GlobalKey();
  late final Padding _repeatButton = Padding(
    padding: EdgeInsets.all(_paddingSize),
    child: RepeatButton(
      key: _repeatButtonKey,
      onSelect: () => <void>{
        setState(() {}),
      },
      onDismiss: () => <void>{
        setState(() {}),
      },
    ),
  );

  late final Padding _eraseCross = Padding(
    padding: EdgeInsets.all(_paddingSize),
    child: CupertinoButton(
      key: const Key("Erase cross"),
      onPressed: () {},
      borderRadius: BorderRadius.circular(45),
      minSize: 50,
      padding: EdgeInsets.zero,
      color: CupertinoColors.systemFill,
      child: const Icon(
        CupertinoIcons.trash_fill,
        color: CupertinoColors.black,
      ),
    ),
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
            child: CupertinoButton(
              key: Key(colors[color]!),
              onPressed: () {},
              borderRadius: BorderRadius.circular(45),
              minSize: 50,
              color: color,
              padding: EdgeInsets.zero,
              child: const Text(""),
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
                _repeatButton,
                _selectionButton,
                _copyButton,
                _mirrorButtonHorizontal,
                _mirrorButtonVertical,
                _eraseCross,
              ],
            ),
            Column(
              children: <Widget>[],
            ),
          ],
        ),
      );
}
