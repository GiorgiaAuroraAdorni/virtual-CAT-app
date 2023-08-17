import "dart:async";
import "dart:math";

import "package:cross_array_task_app/activities/block_based/containers/copy.dart";
import "package:cross_array_task_app/activities/block_based/containers/copy_cells.dart";
import "package:cross_array_task_app/activities/block_based/containers/fill_empty.dart";
import "package:cross_array_task_app/activities/block_based/containers/go.dart";
import "package:cross_array_task_app/activities/block_based/containers/mirror_commands.dart";
import "package:cross_array_task_app/activities/block_based/containers/mirror_cross.dart";
import "package:cross_array_task_app/activities/block_based/containers/mirror_points.dart";
import "package:cross_array_task_app/activities/block_based/containers/paint.dart";
import "package:cross_array_task_app/activities/block_based/containers/paint_multiple.dart";
import "package:cross_array_task_app/activities/block_based/containers/paint_single.dart";
import "package:cross_array_task_app/activities/block_based/containers/point.dart";
import "package:cross_array_task_app/activities/block_based/containers/widget_container.dart";
import "package:cross_array_task_app/activities/block_based/model/copy_cells_container.dart";
import "package:cross_array_task_app/activities/block_based/model/copy_commands_container.dart";
import "package:cross_array_task_app/activities/block_based/model/fill_empty_container.dart";
import "package:cross_array_task_app/activities/block_based/model/go_container.dart";
import "package:cross_array_task_app/activities/block_based/model/mirror_container_commands.dart";
import "package:cross_array_task_app/activities/block_based/model/mirror_container_points.dart";
import "package:cross_array_task_app/activities/block_based/model/mirror_simple_container.dart";
import "package:cross_array_task_app/activities/block_based/model/paint_container.dart";
import "package:cross_array_task_app/activities/block_based/model/paint_multiple_container.dart";
import "package:cross_array_task_app/activities/block_based/model/paint_single_container.dart";
import "package:cross_array_task_app/activities/block_based/model/point_container.dart";
import "package:cross_array_task_app/activities/block_based/model/simple_container.dart";
import "package:cross_array_task_app/activities/block_based/types/container_type.dart";
import "package:cross_array_task_app/model/interpreter/cat_interpreter.dart";
import "package:cross_array_task_app/model/shake_widget.dart";
import "package:cross_array_task_app/utility/notifiers/cat_log.dart";
import "package:cross_array_task_app/utility/notifiers/result_notifier.dart";
import "package:cross_array_task_app/utility/notifiers/selected_colors_notifier.dart";
import "package:cross_array_task_app/utility/notifiers/visibility_notifier.dart";
import "package:cross_array_task_app/utility/translations/localizations.dart";
import "package:dartx/dartx.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:flutter/scheduler.dart";
import "package:interpreter/cat_interpreter.dart";
import "package:provider/provider.dart";

class NewCanvas extends StatefulWidget {
  const NewCanvas({required this.shakeKey, super.key});

  /// It's a key that is used to shake the widget.
  final GlobalKey<ShakeWidgetState> shakeKey;

  @override
  NewCanvasState createState() => NewCanvasState();
}

class NewCanvasState extends State<NewCanvas> {
  final ScrollController _firstController = ScrollController();

  Timer _timer = Timer(Duration.zero, () {});
  int _prevIndex = -1;
  List<SimpleContainer> _data = <SimpleContainer>[];
  late final List<SimpleContainer> _data_placeholder = <SimpleContainer>[
    PointContainer(
      languageCode: CATLocalizations.of(context).languageCode,
    ),
  ];

  bool _added = false;

  void _interpreterListener() {
    if (!mounted) {
      return;
    }
    if (context.read<VisibilityNotifier>().visible) {
      context.read<ResultNotifier>().cross =
          CatInterpreter().getLastState as Cross;
      if (!_added) {
        CatInterpreter().addListener(_interpreterListener);
        _added = !_added;
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
      _data.clear();
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
    CatInterpreter().validCommandsBuffer.clear();
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
    )
        .filter((SimpleContainer element) => element.type != ContainerType.none)
        .toList();
    CatInterpreter().allCommandsBuffer.clear();
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback(
      (_) {
        setState(() {
          _data = commands
              .onEach((SimpleContainer e) => e.key = GlobalKey())
              .toList();
          CatInterpreter().allCommandsBuffer = _data;
        });
      },
    );
  }

  WidgetContainer _generateContainerWidget(
    SimpleContainer container,
    Function f,
  ) {
    switch (container.type) {
      case ContainerType.fillEmpty:
        if (container is FillEmptyContainer) {
          return FillEmpty.context(
            item: container,
            onChange: f,
            state: <State>[this],
          );
        }
        break;
      case ContainerType.go:
        if (container is GoContainer) {
          return Go.context(
            item: container,
            onChange: f,
            state: <State>[this],
          );
        }
        break;
      case ContainerType.paint:
        if (container is PaintContainer) {
          return Paint.context(
            item: container,
            onChange: f,
            state: <State>[this],
          );
        }
        break;
      case ContainerType.paintSingle:
        if (container is PaintSingleContainer) {
          return PaintSingle.context(
            item: container,
            onChange: f,
            state: <State>[this],
          );
        }
        break;
      case ContainerType.copy:
        if (container is CopyCommandsContainer) {
          return CopyCommands.context(
            item: container,
            onChange: f,
            state: <State>[this],
          );
        }
        break;
      case ContainerType.mirrorCross:
        if (container is MirrorSimpleContainer) {
          return MirrorCross.context(
            item: container,
            onChange: f,
            state: <State>[this],
          );
        }
        break;
      case ContainerType.mirrorPoints:
        if (container is MirrorContainerPoints) {
          return MirrorPoints.context(
            item: container,
            onChange: f,
            state: <State>[this],
          );
        }
        break;
      case ContainerType.mirrorCommands:
        if (container is MirrorContainerCommands) {
          return MirrorCommands.context(
            item: container,
            onChange: f,
            state: <State>[this],
          );
        }
        break;
      case ContainerType.copyCells:
        if (container is CopyCellsContainer) {
          return CopyCells.context(
            item: container,
            onChange: f,
            state: <State>[this],
          );
        }
        break;
      case ContainerType.point:
        if (container is PointContainer) {
          return Point.context(
            item: container,
            onChange: f,
            state: <State>[this],
          );
        }
        break;
      case ContainerType.paintMultiple:
        if (container is PaintMultipleContainer) {
          return PaintMultiple.context(
            item: container,
            onChange: f,
            state: <State>[this],
          );
        }
        break;
      case ContainerType.none:
        return WidgetContainer(
          onChange: f,
        )..item = container;
    }

    return WidgetContainer(
      onChange: f,
    )..item = container;
  }

  int _counter = 0;

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
            List<dynamic> rejectedItems,
          ) =>
              Container(
            width: MediaQuery.of(context).size.width * 0.51,
            height: MediaQuery.of(context).size.height * 0.85,
            decoration: const BoxDecoration(
              color: CupertinoColors.systemBackground,
            ),
            child: Scrollbar(
              controller: _firstController,
              interactive: true,
              thumbVisibility: true,
              child: ListView.builder(
                controller: _firstController,
                padding: const EdgeInsets.only(
                  left: 10,
                  right: 10,
                  bottom: 200,
                ),
                itemBuilder: (BuildContext context, int index) =>
                    _data.isEmpty && candidateItems.isEmpty
                        ? IgnorePointer(
                            key: GlobalKey(),
                            child: ColorFiltered(
                              colorFilter: const ColorFilter.mode(
                                Colors.white54,
                                BlendMode.modulate,
                              ),
                              child: _generateContainerWidget(
                                _data_placeholder[index],
                                (Size size) {},
                              ),
                            ),
                          )
                        : Dismissible(
                            key: _data[index].key,
                            child: LongPressDraggable<SimpleContainer>(
                              delay: const Duration(milliseconds: 200),
                              data: _data[index].copy(),
                              feedback: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.45,
                                child: IgnorePointer(
                                  child: _generateContainerWidget(
                                    _data[index].copy(),
                                    (Size size) {},
                                  ),
                                ),
                              ),
                              child: _generateContainerWidget(
                                _data[index],
                                (Size size) {},
                              ),
                              onDragStarted: () {
                                setState(
                                  () {
                                    _data[index] = SimpleContainer(
                                      name: "",
                                      type: ContainerType.none,
                                      languageCode: "en",
                                    )..key = GlobalKey();
                                    _prevIndex = index;
                                    // _data.removeAt(index);
                                  },
                                );
                                CatInterpreter().allCommandsBuffer = _data;
                                context.read<BlockUpdateNotifier>().update();
                                CatLogger().addLog(
                                  context: context,
                                  currentCommand: CatInterpreter()
                                      .allCommandsBuffer
                                      .map((SimpleContainer e) => e.toString())
                                      .join(","),
                                  description: CatLoggingLevel.removeCommand,
                                );
                              },
                            ),
                            onDismissed: (_) {
                              setState(
                                () {
                                  _data.removeAt(index);
                                },
                              );
                              CatInterpreter().allCommandsBuffer = _data;
                              context.read<BlockUpdateNotifier>().update();
                              CatLogger().addLog(
                                context: context,
                                currentCommand: CatInterpreter()
                                    .allCommandsBuffer
                                    .map((SimpleContainer e) => e.toString())
                                    .join(","),
                                description: CatLoggingLevel.removeCommand,
                              );
                            },
                          ),
                itemCount: _data.isEmpty && candidateItems.isEmpty
                    ? _data_placeholder.length
                    : _data.length,
              ),
            ),
          ),
          onWillAccept: (SimpleContainer? data) {
            if (data is SimpleContainer) {
              return true;
            }

            return false;
          },
          onMove: (DragTargetDetails<SimpleContainer> details) {
            if (_counter < 1) {
              _counter++;

              return;
            }
            if (!mounted) {
              return;
            }
            if (_timer.isActive) {
              return;
            }
            int index = _data.length;
            double distance = double.maxFinite;
            bool placeholder = false;
            for (int i = 0; i < _data.length; i++) {
              final Key elementKey = _data[i].key;
              if (elementKey is GlobalKey &&
                  elementKey.currentContext?.findRenderObject() != null &&
                  elementKey != details.data.key) {
                final RenderBox renderBox =
                    elementKey.currentContext?.findRenderObject() as RenderBox;

                final Offset offset = renderBox.localToGlobal(Offset.zero);
                final double posy = offset.dy;
                final double dist = sqrt(
                  pow(posy - details.offset.dy, 2),
                );
                if (dist < distance) {
                  distance = dist;
                  index = i;
                  placeholder = _data[index].type == ContainerType.none;
                }
              }
            }
            if (placeholder) {
              return;
            }
            if (_prevIndex != -1) {
              setState(() {
                _data
                  ..removeAt(_prevIndex)
                  ..insert(
                    index,
                    SimpleContainer(
                      name: "",
                      type: ContainerType.none,
                      languageCode: "en",
                    )..key = GlobalKey(),
                  );
                _prevIndex = index;
              });
            } else {
              setState(() {
                _data.insert(
                  index,
                  SimpleContainer(
                    name: "",
                    type: ContainerType.none,
                    languageCode: "en",
                  )..key = GlobalKey(),
                );
                _prevIndex = index;
              });
            }
            // print(_prevIndex);
            _timer = Timer(const Duration(milliseconds: 200), () {});
          },
          onLeave: (_) {
            setState(() {
              _data = _data
                  .filter((SimpleContainer e) => e.type != ContainerType.none)
                  .toList();
              _prevIndex = -1;
            });
            _counter = 0;
          },
          onAcceptWithDetails: (DragTargetDetails<SimpleContainer> details) {
            final SimpleContainer copy = details.data.copy()..key = GlobalKey();

            setState(() {
              _data.insert(_prevIndex, copy);
              _data = _data
                  .filter((SimpleContainer e) => e.type != ContainerType.none)
                  .toList();
              _prevIndex = -1;
              CatInterpreter().allCommandsBuffer = _data;
            });
            context.read<BlockUpdateNotifier>().update();
            CatLogger().addLog(
              context: context,
              currentCommand: CatInterpreter()
                  .allCommandsBuffer
                  .map((SimpleContainer e) => e.toString())
                  .join(","),
              description: CatLoggingLevel.addCommand,
            );
            _counter = 0;
          },
        ),
      );

  @override
  void dispose() {
    CatInterpreter().removeListener(_interpreterListener);
    _timer.cancel();
    super.dispose();
  }
}
