class Collector {
  Map<String, List<bool>> data = <String, List<bool>>{
    "paintDot": <bool>[],
    "paintUpMonochromatic": <bool>[],
    "paintDownMonochromatic": <bool>[],
    "paintLeftMonochromatic": <bool>[],
    "paintRightMonochromatic": <bool>[],
    "paintSquareUpLeftDownMonochromatic": <bool>[],
    "paintSquareUpRightDownMonochromatic": <bool>[],
    "paintSquareRightDownLeftMonochromatic": <bool>[],
    "paintSquareRightUpLeftMonochromatic": <bool>[],
    "paintSquareLeftDownRightMonochromatic": <bool>[],
    "paintSquareLeftUpRightMonochromatic": <bool>[],
    "paintSquareDownLeftUpMonochromatic": <bool>[],
    "paintSquareDownRightUpMonochromatic": <bool>[],
    "paintDiagonalUpLeftMonochromatic": <bool>[],
    "paintDiagonalUpRightMonochromatic": <bool>[],
    "paintDiagonalDownLeftMonochromatic": <bool>[],
    "paintDiagonalDownRightMonochromatic": <bool>[],
    "paintLUpLeftMonochromatic": <bool>[],
    "paintLUpRightMonochromatic": <bool>[],
    "paintLDownLeftMonochromatic": <bool>[],
    "paintLDownRightMonochromatic": <bool>[],
    "paintLLeftUpMonochromatic": <bool>[],
    "paintLLeftDownMonochromatic": <bool>[],
    "paintLRightUpMonochromatic": <bool>[],
    "paintLRightDownMonochromatic": <bool>[],
    "paintZigzagLeftUpDownMonochromatic": <bool>[],
    "paintZigzagLeftDownUpMonochromatic": <bool>[],
    "paintZigzagRightUpDownMonochromatic": <bool>[],
    "paintZigzagRightDownUpMonochromatic": <bool>[],
    "paintZigzagUpLeftRightMonochromatic": <bool>[],
    "paintZigzagUpRightLeftMonochromatic": <bool>[],
    "paintZigzagDownLeftRightMonochromatic": <bool>[],
    "paintZigzagDownRightLeftMonochromatic": <bool>[],
    "paintUpPolychromatic": <bool>[],
    "paintDownPolychromatic": <bool>[],
    "paintLeftPolychromatic": <bool>[],
    "paintRightPolychromatic": <bool>[],
    "paintSquareUpLeftDownPolychromatic": <bool>[],
    "paintSquareUpRightDownPolychromatic": <bool>[],
    "paintSquareRightDownLeftPolychromatic": <bool>[],
    "paintSquareRightUpLeftPolychromatic": <bool>[],
    "paintSquareLeftDownRightPolychromatic": <bool>[],
    "paintSquareLeftUpRightPolychromatic": <bool>[],
    "paintSquareDownLeftUpPolychromatic": <bool>[],
    "paintSquareDownRightUpPolychromatic": <bool>[],
    "paintDiagonalUpLeftPolychromatic": <bool>[],
    "paintDiagonalUpRightPolychromatic": <bool>[],
    "paintDiagonalDownLeftPolychromatic": <bool>[],
    "paintDiagonalDownRightPolychromatic": <bool>[],
    "paintLUpLeftPolychromatic": <bool>[],
    "paintLUpRightPolychromatic": <bool>[],
    "paintLDownLeftPolychromatic": <bool>[],
    "paintLDownRightPolychromatic": <bool>[],
    "paintLLeftUpPolychromatic": <bool>[],
    "paintLLeftDownPolychromatic": <bool>[],
    "paintLRightUpPolychromatic": <bool>[],
    "paintLRightDownPolychromatic": <bool>[],
    "paintZigzagLeftUpDownPolychromatic": <bool>[],
    "paintZigzagLeftDownUpPolychromatic": <bool>[],
    "paintZigzagRightUpDownPolychromatic": <bool>[],
    "paintZigzagRightDownUpPolychromatic": <bool>[],
    "paintZigzagUpLeftRightPolychromatic": <bool>[],
    "paintZigzagUpRightLeftPolychromatic": <bool>[],
    "paintZigzagDownLeftRightPolychromatic": <bool>[],
    "paintZigzagDownRightLeftPolychromatic": <bool>[],
    "paintCustomPatternMonochromatic": <bool>[],
    "paintCustomPatternPolychromatic": <bool>[],
    "fillEmpty": <bool>[],
    "copy": <bool>[],
    "repeat": <bool>[],
    "mirrorCrossVertical": <bool>[],
    "mirrorCrossHorizontal": <bool>[],
    "mirrorCellsVertical": <bool>[],
    "mirrorCellsHorizontal": <bool>[],
    "mirrorCommandsVertical": <bool>[],
    "mirrorCommandsHorizontal": <bool>[],
  };

  @override
  String toString() => data.toString();
}
