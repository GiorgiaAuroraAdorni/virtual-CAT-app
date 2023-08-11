import "package:cross_array_task_app/activities/block_based/model/simple_container.dart";
import "package:cross_array_task_app/activities/block_based/types/container_type.dart";
import "package:cross_array_task_app/utility/helper.dart";
import "package:cross_array_task_app/utility/translations/localizations.dart";
import "package:flutter/cupertino.dart";
import "package:flutter_svg/svg.dart";

class PaintContainer extends SimpleContainer {
  PaintContainer({
    required this.selectedColors,
    required super.languageCode,
    super.name = "Colora",
    super.type = ContainerType.paint,
    this.direction = "right",
    super.repetitions = 0,
  });

  List<CupertinoDynamicColor> selectedColors;

  String direction;

  late Map<String, String> items = <String, String>{
    // Directions
    CATLocalizations.getPatterns(languageCode)["right"]!: "right",
    CATLocalizations.getPatterns(languageCode)["left"]!: "left",
    CATLocalizations.getPatterns(languageCode)["up"]!: "up",
    CATLocalizations.getPatterns(languageCode)["down"]!: "down",
    // Diagonal
    CATLocalizations.getPatterns(languageCode)["diagonal up left"]!:
        "diagonal up left",
    CATLocalizations.getPatterns(languageCode)["diagonal up right"]!:
        "diagonal up right",
    CATLocalizations.getPatterns(languageCode)["diagonal down left"]!:
        "diagonal down left",
    CATLocalizations.getPatterns(languageCode)["diagonal down right"]!:
        "diagonal down right",
    // Square
    CATLocalizations.getPatterns(languageCode)["square bottom left"]!:
        "square right up left",
    CATLocalizations.getPatterns(languageCode)["square top left"]!:
        "square down right up",
    CATLocalizations.getPatterns(languageCode)["square bottom right"]!:
        "square up left down",
    CATLocalizations.getPatterns(languageCode)["square top right"]!:
        "square left down right",
    CATLocalizations.getPatterns(languageCode)["square bottom left reverse"]!:
        "square up right down",
    CATLocalizations.getPatterns(languageCode)["square top left reverse"]!:
        "square right down left",
    CATLocalizations.getPatterns(languageCode)["square bottom right reverse"]!:
        "square left up right",
    CATLocalizations.getPatterns(languageCode)["square top right reverse"]!:
        "square down left up",
    // L
    CATLocalizations.getPatterns(languageCode)["L up left"]!: "l up left",
    CATLocalizations.getPatterns(languageCode)["L up right"]!: "l up right",
    CATLocalizations.getPatterns(languageCode)["L right down"]!: "l right down",
    CATLocalizations.getPatterns(languageCode)["L right up"]!: "l right up",
    CATLocalizations.getPatterns(languageCode)["L left down"]!: "l left down",
    CATLocalizations.getPatterns(languageCode)["L left up"]!: "l left up",
    CATLocalizations.getPatterns(languageCode)["L down left"]!: "l down left",
    CATLocalizations.getPatterns(languageCode)["L down right"]!: "l down right",
    // Zig-zag
    CATLocalizations.getPatterns(languageCode)["zig-zag left up down"]!:
        "zig-zag left up down",
    CATLocalizations.getPatterns(languageCode)["zig-zag left down up"]!:
        "zig-zag left down up",
    CATLocalizations.getPatterns(languageCode)["zig-zag right up down"]!:
        "zig-zag right up down",
    CATLocalizations.getPatterns(languageCode)["zig-zag right down up"]!:
        "zig-zag right down up",
    CATLocalizations.getPatterns(languageCode)["zig-zag up left right"]!:
        "zig-zag up left right",
    CATLocalizations.getPatterns(languageCode)["zig-zag down right left"]!:
        "zig-zag down right left",
    CATLocalizations.getPatterns(languageCode)["zig-zag up right left"]!:
        "zig-zag up right left",
    CATLocalizations.getPatterns(languageCode)["zig-zag down left right"]!:
        "zig-zag down left right",
  };

  late Map<String, String> revertedItems = Map<String, String>.fromIterables(
    items.values,
    items.keys,
  );

  Map<Widget, String> items2 = <Widget, String>{
    SvgPicture.asset(
      "resources/symbols/right.svg",
      height: 20,
      width: 20,
    ): "right",
    SvgPicture.asset(
      "resources/symbols/left.svg",
      height: 20,
      width: 20,
    ): "left",
    SvgPicture.asset(
      "resources/symbols/up.svg",
      height: 20,
      width: 20,
    ): "up",
    SvgPicture.asset(
      "resources/symbols/down.svg",
      height: 20,
      width: 20,
    ): "down",
    SvgPicture.asset(
      "resources/symbols/diagonal_up_left.svg",
      height: 20,
      width: 20,
    ): "diagonal up left",
    SvgPicture.asset(
      "resources/symbols/diagonal_up_right.svg",
      height: 20,
      width: 20,
    ): "diagonal up right",
    SvgPicture.asset(
      "resources/symbols/diagonal_down_left.svg",
      height: 20,
      width: 20,
    ): "diagonal down left",
    SvgPicture.asset(
      "resources/symbols/diagonal_down_right.svg",
      height: 20,
      width: 20,
    ): "diagonal down right",
    SvgPicture.asset(
      "resources/symbols/square_left_down_right.svg",
      height: 20,
      width: 20,
    ): "square left down right",
    SvgPicture.asset(
      "resources/symbols/square_up_left_down.svg",
      height: 20,
      width: 20,
    ): "square up left down",
    SvgPicture.asset(
      "resources/symbols/square_right_up_left.svg",
      height: 20,
      width: 20,
    ): "square right up left",
    SvgPicture.asset(
      "resources/symbols/square_down_right_up.svg",
      height: 20,
      width: 20,
    ): "square down right up",
    SvgPicture.asset(
      "resources/symbols/square_down_left_up.svg",
      height: 20,
      width: 20,
    ): "square down left up",
    SvgPicture.asset(
      "resources/symbols/square_left_up_right.svg",
      height: 20,
      width: 20,
    ): "square left up right",
    SvgPicture.asset(
      "resources/symbols/square_up_right_down.svg",
      height: 20,
      width: 20,
    ): "square up right down",
    SvgPicture.asset(
      "resources/symbols/square_right_down_left.svg",
      height: 20,
      width: 20,
    ): "square right down left",
    SvgPicture.asset(
      "resources/symbols/L_up_left.svg",
      height: 20,
      width: 20,
    ): "l up left",
    SvgPicture.asset(
      "resources/symbols/L_up_right.svg",
      height: 20,
      width: 20,
    ): "l up right",
    SvgPicture.asset(
      "resources/symbols/L_right_down.svg",
      height: 20,
      width: 20,
    ): "l right down",
    SvgPicture.asset(
      "resources/symbols/L_right_up.svg",
      height: 20,
      width: 20,
    ): "l right up",
    SvgPicture.asset(
      "resources/symbols/L_left_down.svg",
      height: 20,
      width: 20,
    ): "l left down",
    SvgPicture.asset(
      "resources/symbols/L_left_up.svg",
      height: 20,
      width: 20,
    ): "l left up",
    SvgPicture.asset(
      "resources/symbols/L_down_left.svg",
      height: 20,
      width: 20,
    ): "l down left",
    SvgPicture.asset(
      "resources/symbols/L_down_right.svg",
      height: 20,
      width: 20,
    ): "l down right",
    SvgPicture.asset(
      "resources/symbols/zigzag_left_down_up.svg",
      height: 20,
      width: 20,
    ): "zig-zag left down up",
    SvgPicture.asset(
      "resources/symbols/zigzag_right_up_down.svg",
      height: 20,
      width: 20,
    ): "zig-zag right up down",
    SvgPicture.asset(
      "resources/symbols/zigzag_down_right_left.svg",
      height: 20,
      width: 20,
    ): "zig-zag down right left",
    SvgPicture.asset(
      "resources/symbols/zigzag_right_down_up.svg",
      height: 20,
      width: 20,
    ): "zig-zag right down up",
    SvgPicture.asset(
      "resources/symbols/zigzag_up_right_left.svg",
      height: 20,
      width: 20,
    ): "zig-zag up right left",
    SvgPicture.asset(
      "resources/symbols/zigzag_down_left_right.svg",
      height: 20,
      width: 20,
    ): "zig-zag down left right",
    SvgPicture.asset(
      "resources/symbols/zigzag_up_left_right.svg",
      height: 20,
      width: 20,
    ): "zig-zag up left right",
    SvgPicture.asset(
      "resources/symbols/zigzag_left_up_down.svg",
      height: 20,
      width: 20,
    ): "zig-zag left up down",
  };

  final List<Text> repetitionsText = <Text>[
    const Text(
      "2",
      style: TextStyle(
        color: CupertinoColors.black,
      ),
    ),
    const Text(
      "3",
      style: TextStyle(
        color: CupertinoColors.black,
      ),
    ),
    const Text(
      "4",
      style: TextStyle(
        color: CupertinoColors.black,
      ),
    ),
    const Text(
      "5",
      style: TextStyle(
        color: CupertinoColors.black,
      ),
    ),
    const Text(
      "6",
      style: TextStyle(
        color: CupertinoColors.black,
      ),
    ),
    const Text(
      "∞",
      style: TextStyle(
        color: CupertinoColors.black,
      ),
    ),
  ];

  final List<Widget> repetitionsIcons = <Widget>[
    const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(CupertinoIcons.circle_fill),
        Icon(CupertinoIcons.circle_fill),
      ],
    ),
    const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(CupertinoIcons.circle_fill),
        Icon(CupertinoIcons.circle_fill),
        Icon(CupertinoIcons.circle_fill),
      ],
    ),
    const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(CupertinoIcons.circle_fill),
        Icon(CupertinoIcons.circle_fill),
        Icon(CupertinoIcons.circle_fill),
        Icon(CupertinoIcons.circle_fill),
      ],
    ),
    const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(CupertinoIcons.circle_fill),
        Icon(CupertinoIcons.circle_fill),
        Icon(CupertinoIcons.circle_fill),
        Icon(CupertinoIcons.circle_fill),
        Icon(CupertinoIcons.circle_fill),
      ],
    ),
    const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(CupertinoIcons.circle_fill),
        Icon(CupertinoIcons.circle_fill),
        Icon(CupertinoIcons.circle_fill),
        Icon(CupertinoIcons.circle_fill),
        Icon(CupertinoIcons.circle_fill),
        Icon(CupertinoIcons.circle_fill),
      ],
    ),
    const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(CupertinoIcons.infinite),
      ],
    ),
  ];

  final List<Widget> repetitionsDisplay = <Widget>[
    const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          CupertinoIcons.circle_fill,
          color: CupertinoColors.black,
        ),
        Icon(
          CupertinoIcons.circle_fill,
          color: CupertinoColors.black,
        ),
      ],
    ),
    const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          CupertinoIcons.circle_fill,
          color: CupertinoColors.black,
        ),
        Icon(
          CupertinoIcons.circle_fill,
          color: CupertinoColors.black,
        ),
        Icon(
          CupertinoIcons.circle_fill,
          color: CupertinoColors.black,
        ),
      ],
    ),
    const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          CupertinoIcons.circle_fill,
          color: CupertinoColors.black,
        ),
        Icon(
          CupertinoIcons.circle_fill,
          color: CupertinoColors.black,
        ),
        Icon(
          CupertinoIcons.circle_fill,
          color: CupertinoColors.black,
        ),
        Icon(
          CupertinoIcons.circle_fill,
          color: CupertinoColors.black,
        ),
      ],
    ),
    const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          CupertinoIcons.circle_fill,
          color: CupertinoColors.black,
        ),
        Icon(
          CupertinoIcons.circle_fill,
          color: CupertinoColors.black,
        ),
        Icon(
          CupertinoIcons.circle_fill,
          color: CupertinoColors.black,
        ),
        Icon(
          CupertinoIcons.circle_fill,
          color: CupertinoColors.black,
        ),
        Icon(
          CupertinoIcons.circle_fill,
          color: CupertinoColors.black,
        ),
      ],
    ),
    const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          CupertinoIcons.circle_fill,
          color: CupertinoColors.black,
        ),
        Icon(
          CupertinoIcons.circle_fill,
          color: CupertinoColors.black,
        ),
        Icon(
          CupertinoIcons.circle_fill,
          color: CupertinoColors.black,
        ),
        Icon(
          CupertinoIcons.circle_fill,
          color: CupertinoColors.black,
        ),
        Icon(
          CupertinoIcons.circle_fill,
          color: CupertinoColors.black,
        ),
        Icon(
          CupertinoIcons.circle_fill,
          color: CupertinoColors.black,
        ),
      ],
    ),
    const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          CupertinoIcons.infinite,
          color: CupertinoColors.black,
        ),
      ],
    ),
  ];

  late Map<String, Widget> revertedItems2 = Map<String, Widget>.fromIterables(
    items2.values,
    items2.keys,
  );

  @override
  PaintContainer copy() => PaintContainer(
        selectedColors: List<CupertinoDynamicColor>.generate(
          selectedColors.length,
          (int i) => selectedColors[i],
        ),
        direction: direction,
        repetitions: repetitions,
        languageCode: super.languageCode,
      );

  @override
  String toString() => "paint({${analyzeColor(selectedColors).join(",")}},"
      "${repetitionsText[repetitions].data == "∞" ? ":" : repetitionsText[repetitions].data},$direction)";
}
