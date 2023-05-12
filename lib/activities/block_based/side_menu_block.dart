import "package:cross_array_task_app/activities/block_based/containers/copy.dart";
import "package:cross_array_task_app/activities/block_based/containers/copy_cells.dart";
import "package:cross_array_task_app/activities/block_based/containers/fill_empty.dart";
import "package:cross_array_task_app/activities/block_based/containers/go.dart";
import "package:cross_array_task_app/activities/block_based/containers/go_position.dart";
import "package:cross_array_task_app/activities/block_based/containers/mirror_commands.dart";
import "package:cross_array_task_app/activities/block_based/containers/mirror_cross.dart";
import "package:cross_array_task_app/activities/block_based/containers/mirror_points.dart";
import "package:cross_array_task_app/activities/block_based/containers/paint.dart";
import "package:cross_array_task_app/activities/block_based/containers/paint_single.dart";
import "package:cross_array_task_app/activities/block_based/containers/point.dart";
import "package:cross_array_task_app/activities/block_based/drop_down_blocks.dart";
import "package:cross_array_task_app/activities/block_based/model/copy_cells_container.dart";
import "package:cross_array_task_app/activities/block_based/model/copy_commands_container.dart";
import "package:cross_array_task_app/activities/block_based/model/fill_empty_container.dart";
import "package:cross_array_task_app/activities/block_based/model/go_container.dart";
import "package:cross_array_task_app/activities/block_based/model/go_position_container.dart";
import "package:cross_array_task_app/activities/block_based/model/mirror_container_commands.dart";
import "package:cross_array_task_app/activities/block_based/model/mirror_container_points.dart";
import "package:cross_array_task_app/activities/block_based/model/mirror_simple_container.dart";
import "package:cross_array_task_app/activities/block_based/model/paint_container.dart";
import "package:cross_array_task_app/activities/block_based/model/paint_single_container.dart";
import "package:cross_array_task_app/activities/block_based/model/point_container.dart";
import "package:cross_array_task_app/activities/block_based/model/simple_container.dart";
import "package:cross_array_task_app/activities/block_based/types/container_type.dart";
import "package:cross_array_task_app/utility/localizations.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";

class SideMenuBlock extends StatefulWidget {
  const SideMenuBlock({super.key});

  @override
  SideMenuBlockState createState() => SideMenuBlockState();
}

class SideMenuBlockState extends State<SideMenuBlock> {
  /// Creating a list of SimpleContainer objects.
  late List<SimpleContainer> containers = <SimpleContainer>[
    PointContainer(
      languageCode: CATLocalizations
          .of(context)
          .languageCode,
    ),
    PaintSingleContainer(
      languageCode: CATLocalizations
          .of(context)
          .languageCode,
    ),
    GoPositionContainer(
      languageCode: CATLocalizations
          .of(context)
          .languageCode,
    ),
    PaintContainer(
      selectedColors: <CupertinoDynamicColor>[],
      languageCode: CATLocalizations
          .of(context)
          .languageCode,
    ),
    GoContainer(
      languageCode: CATLocalizations
          .of(context)
          .languageCode,
    ),
    FillEmptyContainer(
      languageCode: CATLocalizations
          .of(context)
          .languageCode,
    ),
    MirrorSimpleContainer(
      type: ContainerType.mirrorCross,
      languageCode: CATLocalizations
          .of(context)
          .languageCode,
    ),
    MirrorContainerPoints(
      container: <SimpleContainer>[],
      languageCode: CATLocalizations
          .of(context)
          .languageCode,
    ),
    MirrorContainerCommands(
      container: <SimpleContainer>[],
      languageCode: CATLocalizations
          .of(context)
          .languageCode,
    ),
    CopyCommandsContainer(
      container: <SimpleContainer>[],
      moves: <SimpleContainer>[],
      languageCode: CATLocalizations
          .of(context)
          .languageCode,
    ),
    CopyCellsContainer(
      container: <SimpleContainer>[],
      moves: <SimpleContainer>[],
      languageCode: CATLocalizations
          .of(context)
          .languageCode,
    ),
  ];

  /// It returns a Draggable widget that has a feedback widget that is a Card
  /// with a child that is the result of calling the builder function
  ///
  /// Args:
  ///   container (SimpleContainer): The container that is being dragged.
  ///   builder (Function): This is the function that will be called to build
  ///   the widget.
  ///
  /// Returns:
  ///   A Draggable widget.
  Widget _buildLongPressDraggable({
    required SimpleContainer container,
    required Function builder,
  }) {
    final SimpleContainer copyContainer = container.copy();

    return LongPressDraggable<SimpleContainer>(
      delay: const Duration(milliseconds: 200),
      data: copyContainer,
      feedback: SizedBox(
        width: 250,
        child: Function.apply(
          builder,
          [],
          {#item: copyContainer, #onChange: (Size size) {}, #key: UniqueKey()},
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(right: 10),
        child: Function.apply(
          builder,
          [],
          {#item: copyContainer, #onChange: (Size size) {}, #key: UniqueKey()},
        ),
      ),
      onDragCompleted: () =>
          setState(() {
            containers = <SimpleContainer>[
              PointContainer(
                languageCode: CATLocalizations
                    .of(context)
                    .languageCode,
              ),
              PaintSingleContainer(
                languageCode: CATLocalizations
                    .of(context)
                    .languageCode,
              ),
              GoPositionContainer(
                languageCode: CATLocalizations
                    .of(context)
                    .languageCode,
              ),
              PaintContainer(
                selectedColors: <CupertinoDynamicColor>[],
                languageCode: CATLocalizations
                    .of(context)
                    .languageCode,
              ),
              GoContainer(
                languageCode: CATLocalizations
                    .of(context)
                    .languageCode,
              ),
              FillEmptyContainer(
                languageCode: CATLocalizations
                    .of(context)
                    .languageCode,
              ),
              MirrorSimpleContainer(
                type: ContainerType.mirrorCross,
                languageCode: CATLocalizations
                    .of(context)
                    .languageCode,
              ),
              MirrorContainerPoints(
                container: <SimpleContainer>[],
                languageCode: CATLocalizations
                    .of(context)
                    .languageCode,
              ),
              MirrorContainerCommands(
                container: <SimpleContainer>[],
                languageCode: CATLocalizations
                    .of(context)
                    .languageCode,
              ),
              CopyCommandsContainer(
                container: <SimpleContainer>[],
                moves: <SimpleContainer>[],
                languageCode: CATLocalizations
                    .of(context)
                    .languageCode,
              ),
              CopyCellsContainer(
                container: <SimpleContainer>[],
                moves: <SimpleContainer>[],
                languageCode: CATLocalizations
                    .of(context)
                    .languageCode,
              ),
            ];
          }),
    );
  }

  /// It returns a widget that is a draggable version of the widget that
  /// is returned by the builder function that is passed in
  ///
  /// Args:
  ///   container (SimpleContainer): The container to be built.
  ///
  /// Returns:
  ///   A widget that is a long press draggable.
  Widget _buildContainerItem({required SimpleContainer container}) {
    switch (container.type) {
      case ContainerType.fillEmpty:
        return _buildLongPressDraggable(
          container: container,
          builder: FillEmpty.build,
        );
      case ContainerType.go:
        return _buildLongPressDraggable(
          container: container,
          builder: Go.build,
        );
      case ContainerType.paint:
        return _buildLongPressDraggable(
          container: container,
          builder: Paint.build,
        );
      case ContainerType.copy:
        return _buildLongPressDraggable(
          container: container,
          builder: CopyCommands.build,
        );
      case ContainerType.mirrorPoints:
        return _buildLongPressDraggable(
          container: container,
          builder: MirrorPoints.build,
        );
      case ContainerType.mirrorCommands:
        return _buildLongPressDraggable(
          container: container,
          builder: MirrorCommands.build,
        );
      case ContainerType.paintSingle:
        return _buildLongPressDraggable(
          container: container,
          builder: PaintSingle.build,
        );
      case ContainerType.goPosition:
        return _buildLongPressDraggable(
          container: container,
          builder: GoPosition.build,
        );
      case ContainerType.mirrorCross:
        return _buildLongPressDraggable(
          container: container,
          builder: MirrorCross.build,
        );
      case ContainerType.copyCells:
        return _buildLongPressDraggable(
          container: container,
          builder: CopyCells.build,
        );
      case ContainerType.point:
        return _buildLongPressDraggable(
          container: container,
          builder: Point.build,
        );
    }
  }

  final ScrollController _firstController = ScrollController();

  final List<ValueNotifier<bool>> _states = <ValueNotifier<bool>>[
    ValueNotifier<bool>(false),
    ValueNotifier<bool>(false),
    ValueNotifier<bool>(false),
    ValueNotifier<bool>(false),
  ];

  @override
  Widget build(BuildContext context) =>
      Padding(
        padding: const EdgeInsets.all(5),
        child: SizedBox(
          width: MediaQuery
              .of(context)
              .size
              .width * 0.20,
          height: MediaQuery
              .of(context)
              .size
              .height * 0.85,
          child: Scrollbar(
            controller: _firstController,
            interactive: true,
            thumbVisibility: true,
            child: ListView(
              controller: _firstController,
              children: <Widget>[
                DropDownBlocks(
                  title: CATLocalizations
                      .of(context)
                      .blockGroups["groupGoTo"]!,
                  color: Colors.green,
                  items: <Widget>[
                    _buildContainerItem(container: containers[2]),
                    _buildContainerItem(container: containers[4]),
                    _buildContainerItem(container: containers[0]),
                  ],
                  visibility: _states[0],
                  iconLocation: "resources/icons/placement_menu.svg",
                ),
                DropDownBlocks(
                  title:
                  CATLocalizations
                      .of(context)
                      .blockGroups["groupColor"]!,
                  color: Colors.teal,
                  items: <Widget>[
                    _buildContainerItem(container: containers[1]),
                    _buildContainerItem(container: containers[3]),
                    _buildContainerItem(container: containers[5]),
                  ],
                  visibility: _states[1],
                  iconLocation: "resources/icons/colouring_menu.svg",
                ),
                DropDownBlocks(
                  title: CATLocalizations
                      .of(context)
                      .blockGroups["groupCopy"]!,
                  color: Colors.indigo,
                  items: <Widget>[
                    _buildContainerItem(container: containers[10]),
                    _buildContainerItem(container: containers[9]),
                  ],
                  visibility: _states[2],
                  iconLocation: "resources/icons/loops_menu.svg",
                ),
                DropDownBlocks(
                  title:
                  CATLocalizations
                      .of(context)
                      .blockGroups["groupMirror"]!,
                  color: Colors.blueGrey,
                  items: <Widget>[
                    _buildContainerItem(container: containers[6]),
                    _buildContainerItem(container: containers[7]),
                    _buildContainerItem(container: containers[8]),
                  ],
                  visibility: _states[3],
                  iconLocation: "resources/icons/mirror_menu.svg",
                ),
              ],
            ),
            // child: ListView.separated(
            //   controller: _firstController,
            //   itemCount: containers.length,
            //   itemBuilder: (BuildContext context, int index) =>
            //       _buildContainerItem(container: containers[index]),
            //   separatorBuilder: (BuildContext context, int index) =>
            //       const SizedBox(
            //     height: 5,
            //   ),
            // ),
          ),
        ),
      );
}
