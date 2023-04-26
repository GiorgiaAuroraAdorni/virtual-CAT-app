import "dart:async";

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
import "package:cross_array_task_app/activities/block_based/containers/widget_container.dart";
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
import "package:cross_array_task_app/model/interpreter/cat_interpreter.dart";
import "package:cross_array_task_app/model/shake_widget.dart";
import "package:cross_array_task_app/utility/cat_log.dart";
import "package:cross_array_task_app/utility/localizations.dart";
import "package:cross_array_task_app/utility/result_notifier.dart";
import "package:cross_array_task_app/utility/selected_colors_notifier.dart";
import "package:cross_array_task_app/utility/visibility_notifier.dart";
import "package:dartx/dartx.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:interpreter/cat_interpreter.dart";
import "package:provider/provider.dart";

class BlockCanvas extends StatefulWidget {
  const BlockCanvas({
    super.key,
    required this.shakeKey,
  });

  /// It's a key that is used to shake the widget.
  final GlobalKey<ShakeWidgetState> shakeKey;

  @override
  _BlockCanvasState createState() => _BlockCanvasState();
}

class _BlockCanvasState extends State<BlockCanvas> {
  late List<Widget> widgets = <Widget>[];

  List<GlobalKey> _keys = [];

  void _blockDroppedOnCanvas({
    required SimpleContainer item,
    required int position,
  }) {
    final SimpleContainer itemCopy = item.copy();
    setState(
      () {
        final GlobalKey key = GlobalKey();
        itemCopy.key = key;
        final Dismissible element = Dismissible(
          key: key,
          child: _generateDismiss(
            itemCopy,
            (Size size) {},
          ),
          onDismissed: (DismissDirection direction) {
            final String prev = CatInterpreter()
                .allCommandsBuffer
                .map((SimpleContainer e) => e.toString())
                .join(",");
            setState(
              () {
                widgets.removeWhere((Widget element) => element.key == key);
                CatInterpreter().allCommandsBuffer.removeWhere(
                      (SimpleContainer element) => element.key == key,
                    );
                _keys.removeWhere(
                  (GlobalKey<State<StatefulWidget>> element) => element == key,
                );
              },
            );
            context.read<BlockUpdateNotifier>().update();
            CatLogger().addLog(
              context: context,
              previousCommand: prev,
              currentCommand: CatInterpreter()
                  .allCommandsBuffer
                  .map((SimpleContainer e) => e.toString())
                  .join(","),
              description: CatLoggingLevel.removeCommand,
            );
          },
        );
        if (position == -1) {
          widgets.add(element);
          CatInterpreter().allCommandsBuffer.add(itemCopy);
          _keys.add(key);
        } else {
          widgets[position] = element;
          _keys[position] = key;
          if (position >= CatInterpreter().allCommandsBuffer.length) {
            CatInterpreter().allCommandsBuffer.add(itemCopy);
          } else {
            CatInterpreter().allCommandsBuffer.insert(position, itemCopy);
          }
        }
      },
    );
  }

  Widget _generateDismiss(
    SimpleContainer container,
    Function f,
  ) {
    switch (container.type) {
      case ContainerType.fillEmpty:
        if (container is FillEmptyContainer) {
          return FillEmpty(
            item: container,
            onChange: f,
          );
        }
        break;
      case ContainerType.go:
        if (container is GoContainer) {
          return Go(
            item: container,
            onChange: f,
          );
        }
        break;
      case ContainerType.goPosition:
        if (container is GoPositionContainer) {
          return GoPosition(
            item: container,
            onChange: f,
          );
        }
        break;
      case ContainerType.paint:
        if (container is PaintContainer) {
          return Paint(
            item: container,
            onChange: f,
          );
        }
        break;
      case ContainerType.paintSingle:
        if (container is PaintSingleContainer) {
          return PaintSingle(
            item: container,
            onChange: f,
          );
        }
        break;
      case ContainerType.copy:
        if (container is CopyCommandsContainer) {
          return CopyCommands(
            item: container,
            onChange: f,
          );
        }
        break;
      case ContainerType.mirrorCross:
        if (container is MirrorSimpleContainer) {
          return MirrorCross(
            item: container,
            onChange: f,
          );
        }
        break;
      case ContainerType.mirrorPoints:
        if (container is MirrorContainerPoints) {
          return MirrorPoints(
            item: container,
            onChange: f,
          );
        }
        break;
      case ContainerType.mirrorCommands:
        if (container is MirrorContainerCommands) {
          return MirrorCommands(
            item: container,
            onChange: f,
          );
        }
        break;
      case ContainerType.copyCells:
        if (container is CopyCellsContainer) {
          return CopyCells(
            item: container,
            onChange: f,
          );
        }
        break;
      case ContainerType.point:
        if (container is PointContainer) {
          return Point(
            item: container,
            onChange: f,
          );
        }
        break;
    }

    return Container();
  }

  bool added = false;

  void _interpreterListener() {
    if (!mounted) {
      return;
    }
    if (context.read<VisibilityNotifier>().visible) {
      context.read<ResultNotifier>().cross =
          CatInterpreter().getLastState as Cross;
      if (!added) {
        CatInterpreter().addListener(_interpreterListener);
        added = !added;
      }
    } else {
      CatInterpreter().removeListener(_interpreterListener);
    }
  }

  void _cleanBlocksListener() {
    if (!mounted) {
      return;
    }
    setState(() {
      widgets.clear();
      _keys.clear();
      CatInterpreter().allCommandsBuffer.clear();
      // items.clear();
    });
  }

  void _executeCommands() {
    if (!mounted) {
      return;
    }
    CatInterpreter().resetInterpreter();
    final List<String> commands = CatInterpreter()
        .allCommandsBuffer
        .map((SimpleContainer e) => e.toString())
        .toList();
    for (final String command in commands) {
      runZonedGuarded(
        () {
          if (command.isNotEmpty) {
            CatInterpreter().executeCommands(
              command,
              CATLocalizations.of(context).languageCode,
            );
          }
        },
        (Object error, StackTrace stackTrace) {
          // widget.shakeKey.currentState?.shake();
        },
      );
    }
  }

  @override
  void initState() {
    context.read<VisibilityNotifier>().addListener(_interpreterListener);
    context.read<SelectedColorsNotifier>().addListener(_cleanBlocksListener);
    context.read<BlockUpdateNotifier>().addListener(_executeCommands);
    final List<SimpleContainer> commands = List<SimpleContainer>.from(
      CatInterpreter().allCommandsBuffer,
    );
    CatInterpreter().allCommandsBuffer.clear();
    super.initState();
    Future<void>(
      () {
        // for (final String i in commands) {
        //   if (i == "None") {
        //     continue;
        //   }
        //   for (final SimpleContainer j in parseToContainer(i, context)) {
        //     _blockDroppedOnCanvas(item: j);
        //   }
        // }
        for (final SimpleContainer i in commands) {
          // parseToContainer("", context);
          _blockDroppedOnCanvas(item: i, position: 0);
        }
      },
    );
  }

  final ScrollController _firstController = ScrollController();

  int prevIndex = -1;

  Timer t = Timer(Duration.zero, () {});

  @override
  Widget build(BuildContext context) => ShakeWidget(
        key: widget.shakeKey,
        shakeCount: 3,
        shakeOffset: 10,
        shakeDuration: const Duration(milliseconds: 400),
        child: DragTarget<SimpleContainer>(
          builder: (
            BuildContext context,
            List<SimpleContainer?> candidateItems,
            List rejectedItems,
          ) =>
              Container(
            width: MediaQuery.of(context).size.width * 0.50,
            height: MediaQuery.of(context).size.height * 0.85,
            decoration: const BoxDecoration(
              color: CupertinoColors.systemBackground,
            ),
            child: Scrollbar(
              controller: _firstController,
              interactive: true,
              thumbVisibility: true,
              child: ReorderableListView(
                scrollController: _firstController,
                padding: const EdgeInsets.only(
                  left: 10,
                  right: 10,
                  bottom: 200,
                ),
                onReorder: (int oldIndex, int newIndex) {
                  t.cancel();
                  t = Timer(const Duration(milliseconds: 200), () {});
                  final String prev = CatInterpreter()
                      .allCommandsBuffer
                      .map((SimpleContainer e) => e.toString())
                      .join(",");
                  if (oldIndex < newIndex) {
                    newIndex -= 1;
                  }
                  widgets.insert(newIndex, widgets.removeAt(oldIndex));
                  _keys.insert(newIndex, _keys.removeAt(oldIndex));
                  CatInterpreter().allCommandsBuffer = widgets
                      .filter(
                        (Widget e) =>
                            (e as Dismissible).child is WidgetContainer,
                      )
                      .map(
                        (Widget e) =>
                            ((e as Dismissible).child as WidgetContainer).item,
                      )
                      .toList();
                  context.read<BlockUpdateNotifier>().update();
                  CatLogger().addLog(
                    context: context,
                    previousCommand: prev,
                    currentCommand: CatInterpreter()
                        .allCommandsBuffer
                        .map((SimpleContainer e) => e.toString())
                        .join(","),
                    description: CatLoggingLevel.reorderCommand,
                  );
                },
                children: () {
                  if (candidateItems.isEmpty && widgets.isEmpty) {
                    return [
                      IgnorePointer(
                        key: GlobalKey(),
                        child: ColorFiltered(
                          colorFilter: const ColorFilter.mode(
                            Colors.white54,
                            BlendMode.modulate,
                          ),
                          child: GoPosition(
                            item: GoPositionContainer(
                              languageCode:
                                  CATLocalizations.of(context).languageCode,
                            ),
                            onChange: (Size size) {},
                          ),
                        ),
                      ),
                    ];
                  }

                  return widgets;
                }.call(),
              ),
            ),
          ),
          onWillAccept: (SimpleContainer? data) {
            if (data is SimpleContainer) {
              if (data.type == ContainerType.point) {
                return false;
              }

              return true;
            }

            return false;
          },
          onLeave: (_) {
            setState(() {
              widgets = widgets.filter((Widget e) => e is Dismissible).toList();
            });
            _keys = widgets.map((Widget e) => e.key as GlobalKey).toList();
            CatInterpreter().allCommandsBuffer = widgets
                .filter(
                  (Widget e) => (e as Dismissible).child is WidgetContainer,
                )
                .map(
                  (Widget e) =>
                      ((e as Dismissible).child as WidgetContainer).item,
                )
                .toList();
            prevIndex = -1;
          },
          onMove: (DragTargetDetails<SimpleContainer> details) {
            if (details.data.type == ContainerType.point) {
              return;
            }
            if (t.isActive) {
              return;
            }
            int index = _keys.length;
            double distance = double.maxFinite;
            bool sized_box = false;
            for (int i = 0; i < _keys.length; i++) {
              if (_keys[i].currentContext?.findRenderObject() != null) {
                final RenderBox renderBox =
                    _keys[i].currentContext?.findRenderObject() as RenderBox;
                final Size size = renderBox.size;

                final Offset offset = renderBox.localToGlobal(Offset.zero);
                final double posx =
                    ((offset.dx + size.width) / 2).roundToDouble();
                final double posy =
                    ((offset.dy + size.height) / 2).roundToDouble();
                final double dist = (((posx - details.offset.dx).abs() +
                            (posy - details.offset.dy).abs()) /
                        2)
                    .roundToDouble();
                if (dist < distance) {
                  distance = dist;
                  index = i;
                  sized_box = widgets[index] is SizedBox;
                }
              }
            }
            if (sized_box) {
              return;
            }
            final GlobalKey key = GlobalKey();
            if (prevIndex != -1) {
              setState(() {
                widgets
                  ..removeAt(prevIndex)
                  ..insert(
                    index,
                    Container(
                      key: key,
                      height: 70,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        border: Border.all(),
                        color: CupertinoColors.systemBackground,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8)),
                      ),
                    ),
                  );
                _keys
                  ..removeAt(prevIndex)
                  ..insert(index, key);
                prevIndex = index;
              });
            } else {
              setState(() {
                widgets.insert(
                  index,
                  Container(
                    key: key,
                    height: 70,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      border: Border.all(),
                      color: CupertinoColors.systemBackground,
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                    ),
                  ),
                );
                _keys.insert(index, key);
                prevIndex = index;
              });
            }
            t = Timer(const Duration(milliseconds: 200), () {});
          },
          onAcceptWithDetails: (DragTargetDetails<SimpleContainer> details) {
            final SimpleContainer item = details.data;
            final String prev = CatInterpreter()
                .allCommandsBuffer
                .map((SimpleContainer e) => e.toString())
                .join(",");
            _blockDroppedOnCanvas(
              item: item,
              position: prevIndex,
            );
            setState(() {
              widgets = widgets.filter((Widget e) => e is Dismissible).toList();
            });
            _keys = widgets.map((Widget e) => e.key as GlobalKey).toList();
            CatInterpreter().allCommandsBuffer = widgets
                .filter(
                  (Widget e) => (e as Dismissible).child is WidgetContainer,
                )
                .map(
                  (Widget e) =>
                      ((e as Dismissible).child as WidgetContainer).item,
                )
                .toList();
            prevIndex = -1;
            context.read<BlockUpdateNotifier>().update();
            CatLogger().addLog(
              context: context,
              previousCommand: prev,
              currentCommand: CatInterpreter()
                  .allCommandsBuffer
                  .map((SimpleContainer e) => e.toString())
                  .join(","),
              description: CatLoggingLevel.addCommand,
            );
          },
        ),
      );

  @override
  void dispose() {
    CatInterpreter().removeListener(_interpreterListener);
    super.dispose();
  }
}
