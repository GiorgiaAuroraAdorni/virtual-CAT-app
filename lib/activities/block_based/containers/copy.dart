import "dart:async";
import "dart:math";

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
import "package:cross_array_task_app/utility/notifiers/cat_log.dart";
import "package:cross_array_task_app/utility/notifiers/result_notifier.dart";
import "package:cross_array_task_app/utility/translations/localizations.dart";
import "package:dartx/dartx.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:flutter/scheduler.dart";
import "package:flutter_sfsymbols/flutter_sfsymbols.dart";
import "package:provider/provider.dart";

/// `Copy` is a stateful widget that displays a copy of the `item` passed to it
class CopyCommands extends WidgetContainer {
  /// A constructor for the Copy class.
  CopyCommands({
    required this.item,
    required super.onChange,
    super.key,
  });

  CopyCommands.context({
    required this.item,
    required super.onChange,
    required this.state,
    super.key,
  });

  /// A constructor for the Copy class.
  CopyCommands.build({
    required this.item,
    required super.onChange,
    super.key,
  });

  List<State> state = [];

  /// Creating a new instance of the SimpleContainer class.
  @override
  final CopyCommandsContainer item;

  @override
  State<StatefulWidget> createState() => _Copy();
}

class _Copy extends State<CopyCommands> {
  GlobalKey<State<StatefulWidget>> widgetKey = GlobalKey();
  final double fontSize = 15;
  double childHeight = 0;
  double childHeight2 = 0;
  int _prevIndex = -1;
  Map<Key, double> sized = <Key, double>{};
  Map<Key, double> sized2 = <Key, double>{};
  Timer _timer = Timer(Duration.zero, () {});

  late final List<SimpleContainer> _data_placeholder = <SimpleContainer>[
    PaintSingleContainer(
      selected: CupertinoColors.systemBlue,
      languageCode: CATLocalizations.of(context).languageCode,
    )..key = GlobalKey(),
    PointContainer(
      a: "F",
      b: "3",
      languageCode: CATLocalizations.of(context).languageCode,
    )..key = GlobalKey(),
    PaintSingleContainer(
      selected: CupertinoColors.systemRed,
      languageCode: CATLocalizations.of(context).languageCode,
    )..key = GlobalKey(),
  ];

  late final List<SimpleContainer> _data_placeholder2 = <SimpleContainer>[
    PointContainer(
      languageCode: CATLocalizations.of(context).languageCode,
    )..key = GlobalKey(),
  ];

  void setStateCustom(VoidCallback fn) {
    setState(fn);
    for (final State<StatefulWidget> i in widget.state) {
      i.setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      setStateCustom(() {
        if (widget.item.container.isNotEmpty) {
          final List<SimpleContainer> copy =
              List<SimpleContainer>.from(widget.item.container);
          widget.item.container.clear();
          for (final SimpleContainer element in copy) {
            element.key = GlobalKey();
          }
          widget.item.container = copy;
        }
        if (widget.item.moves.isNotEmpty) {
          final List<SimpleContainer> copy =
              List<SimpleContainer>.from(widget.item.moves);
          widget.item.moves.clear();
          for (final SimpleContainer element in copy) {
            element.key = GlobalKey();
          }
          widget.item.moves = copy;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    SchedulerBinding.instance.addPostFrameCallback(postFrameCallback);
    if (sized.isEmpty) {
      sized = <Key, double>{const Key("ciao"): 0.0, const Key("lalala"): 0.0};
    }
    if (sized2.isEmpty) {
      sized2 = <Key, double>{const Key("ciao"): 0.0, const Key("lalala"): 0.0};
    }
    childHeight = sized.entries
        .map((MapEntry<Key, double> e) => e.value)
        .reduce((double a, double b) => a + b);
    childHeight2 = sized2.entries
        .map((MapEntry<Key, double> e) => e.value)
        .reduce((double a, double b) => a + b);

    return Container(
      key: widgetKey,
      height: childHeight + childHeight2 + 200,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        border: Border.all(),
        color: Colors.indigo,
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      child: Center(
        child: figure(),
      ),
    );
  }

  Widget figure() => Padding(
        padding: const EdgeInsets.all(5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            AnimatedBuilder(
              animation: context.watch<TypeUpdateNotifier>(),
              builder: (BuildContext context, Widget? child) {
                if (context.read<TypeUpdateNotifier>().state == 2) {
                  return Text(
                    "${CATLocalizations.of(context).blocks["repeatPattern"]!}\n"
                    "${CATLocalizations.of(context).blocks["repeatFirstBlock"]!}",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: CupertinoColors.systemBackground,
                    ),
                  );
                }

                return const Icon(
                  SFSymbols.arrow_2_squarepath,
                  color: CupertinoColors.systemBackground,
                );
              },
            ),
            commands(),
            AnimatedBuilder(
              animation: context.watch<TypeUpdateNotifier>(),
              builder: (BuildContext context, Widget? child) {
                if (context.read<TypeUpdateNotifier>().state == 2) {
                  return Text(
                    CATLocalizations.of(context).blocks["repeatSecondBlock"]!,
                    style: const TextStyle(
                      color: CupertinoColors.systemBackground,
                    ),
                  );
                }

                return const Icon(
                  SFSymbols.doc_on_doc_fill,
                  color: CupertinoColors.systemBackground,
                );
              },
            ),
            positions(),
          ],
        ),
      );
  int _counter = 0;

  Widget commands() => DragTarget<SimpleContainer>(
        builder: (
          BuildContext context,
          List<SimpleContainer?> candidateItems,
          List<dynamic> rejectedItems,
        ) =>
            LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) =>
              canvas(candidateItems, constraints),
        ),
        onWillAccept: (SimpleContainer? container) {
          if (container is SimpleContainer) {
            if (container.type == ContainerType.mirrorCommands) {
              return false;
            }
            if (container.type == ContainerType.mirrorPoints) {
              return false;
            }
            if (container.type == ContainerType.copyCells) {
              return false;
            }
            if (container.type == ContainerType.copy) {
              return false;
            }

            return true;
          }

          return false;
        },
        onMove: (DragTargetDetails<SimpleContainer> details) =>
            _counter < 1 ? _counter++ : move(details),
        onLeave: (_) {
          setStateCustom(() {
            widget.item.container = widget.item.container
                .filter(
                  (SimpleContainer e) => e.type != ContainerType.none,
                )
                .toList();
            sized = sized.filter(
              (MapEntry<Key, double> entry) => widget.item.container.any(
                (SimpleContainer element) => element.key == entry.key,
              ),
            );
            _prevIndex = -1;
          });
          _counter = 0;
        },
        onAcceptWithDetails: (DragTargetDetails<SimpleContainer> details) {
          final SimpleContainer copy = details.data.copy()..key = GlobalKey();
          setStateCustom(() {
            widget.item.container.insert(_prevIndex, copy);
            widget.item.container = widget.item.container
                .filter(
                  (SimpleContainer e) => e.type != ContainerType.none,
                )
                .toList();
            sized = sized.filter(
              (MapEntry<Key, double> entry) => widget.item.container.any(
                (SimpleContainer element) => element.key == entry.key,
              ),
            );
            _prevIndex = -1;
          });
          context.read<BlockUpdateNotifier>().update();
          if (widget.state.isEmpty) {
            return;
          }
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
      );

  void move(DragTargetDetails<SimpleContainer> details) {
    if (!mounted) {
      return;
    }
    if (details.data.type == ContainerType.mirrorCommands) {
      return;
    }
    if (details.data.type == ContainerType.mirrorPoints) {
      return;
    }
    if (details.data.type == ContainerType.copyCells) {
      return;
    }
    if (details.data.type == ContainerType.copy) {
      return;
    }
    if (_timer.isActive) {
      return;
    }
    int index = widget.item.container.length;
    double distance = double.maxFinite;
    bool placeholder = false;
    for (int i = 0; i < widget.item.container.length; i++) {
      final Key elementKey = widget.item.container[i].key;
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
          placeholder = widget.item.container[index].type == ContainerType.none;
        }
      }
    }
    if (placeholder) {
      return;
    }
    if (_prevIndex != -1) {
      setStateCustom(() {
        final SimpleContainer removed =
            widget.item.container.removeAt(_prevIndex);
        sized.remove(removed.key);
        widget.item.container.insert(
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
      setStateCustom(() {
        widget.item.container.insert(
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
    _timer = Timer(const Duration(milliseconds: 200), () {});
  }

  Widget canvas(
    List<SimpleContainer?> candidateItems,
    BoxConstraints constraints,
  ) =>
      Align(
        child: Container(
          decoration: const BoxDecoration(
            color: CupertinoColors.systemBackground,
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            ),
          ),
          height: childHeight + 30,
          width: constraints.maxWidth - 15,
          child: ListView.builder(
            itemBuilder: (BuildContext context, int index) =>
                widget.item.container.isEmpty && candidateItems.isEmpty
                    ? IgnorePointer(
                        key: _data_placeholder[index].key,
                        child: ColorFiltered(
                          colorFilter: const ColorFilter.mode(
                            Colors.white54,
                            BlendMode.modulate,
                          ),
                          child: generateDismiss(
                            _data_placeholder[index],
                            (Size size) {
                              setStateCustom(() {
                                sized[_data_placeholder[index].key] =
                                    size.height;
                              });
                            },
                          ),
                        ),
                      )
                    : Dismissible(
                        key: widget.item.container[index].key,
                        child: LongPressDraggable<SimpleContainer>(
                          delay: const Duration(milliseconds: 200),
                          data: widget.item.container[index].copy(),
                          feedback: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.45,
                            child: generateDismiss(
                              widget.item.container[index],
                              (Size size) {},
                            ),
                          ),
                          child: generateDismiss(
                            widget.item.container[index],
                            (Size size) {
                              setStateCustom(
                                () {
                                  sized[widget.item.container[index].key] =
                                      size.height;
                                },
                              );
                            },
                          ),
                          onDragStarted: () {
                            setStateCustom(
                              () {
                                sized.remove(
                                  widget.item.container[index].key,
                                );
                                widget.item.container.removeAt(index);
                              },
                            );
                            context.read<BlockUpdateNotifier>().update();
                            if (widget.state.isEmpty) {
                              return;
                            }
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
                          setStateCustom(
                            () {
                              sized.remove(
                                widget.item.container[index].key,
                              );
                              widget.item.container.removeAt(index);
                            },
                          );
                          context.read<BlockUpdateNotifier>().update();
                          if (widget.state.isEmpty) {
                            return;
                          }
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
            itemCount: widget.item.container.isEmpty && candidateItems.isEmpty
                ? _data_placeholder.length
                : widget.item.container.length,
          ),
        ),
      );
  int _counter2 = 0;

  Widget positions() => Flexible(
        flex: 0,
        child: DragTarget<PointContainer>(
          builder: (
            BuildContext context,
            List<PointContainer?> candidateItems,
            List<dynamic> rejectedItems,
          ) =>
              LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) =>
                canvas2(candidateItems, constraints),
          ),
          onMove: (DragTargetDetails<SimpleContainer> details) =>
              _counter2 < 1 ? _counter2++ : move2(details),
          onLeave: (_) {
            setStateCustom(() {
              widget.item.moves = widget.item.moves
                  .filter(
                    (SimpleContainer e) => e.type != ContainerType.none,
                  )
                  .toList();
              sized2 = sized2.filter(
                (MapEntry<Key, double> entry) => widget.item.moves.any(
                  (SimpleContainer element) => element.key == entry.key,
                ),
              );
              _prevIndex = -1;
            });
            _counter2 = 0;
          },
          onAcceptWithDetails: (DragTargetDetails<SimpleContainer> details) {
            final SimpleContainer copy = details.data.copy()..key = GlobalKey();
            setStateCustom(() {
              widget.item.moves.insert(_prevIndex, copy);
              widget.item.moves = widget.item.moves
                  .filter(
                    (SimpleContainer e) => e.type != ContainerType.none,
                  )
                  .toList();
              sized2 = sized2.filter(
                (MapEntry<Key, double> entry) => widget.item.moves.any(
                  (SimpleContainer element) => element.key == entry.key,
                ),
              );
              _prevIndex = -1;
            });
            context.read<BlockUpdateNotifier>().update();
            if (widget.state.isEmpty) {
              return;
            }
            CatLogger().addLog(
              context: context,
              currentCommand: CatInterpreter()
                  .allCommandsBuffer
                  .map((SimpleContainer e) => e.toString())
                  .join(","),
              description: CatLoggingLevel.addCommand,
            );
            _counter2 = 0;
          },
        ),
      );

  void move2(DragTargetDetails<SimpleContainer> details) {
    if (!mounted) {
      return;
    }
    if (_timer.isActive) {
      return;
    }
    int index = widget.item.moves.length;
    double distance = double.maxFinite;
    bool placeholder = false;
    for (int i = 0; i < widget.item.moves.length; i++) {
      final Key elementKey = widget.item.moves[i].key;
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
          placeholder = widget.item.moves[index].type == ContainerType.none;
        }
      }
    }
    if (placeholder) {
      return;
    }
    if (_prevIndex != -1) {
      setStateCustom(() {
        final SimpleContainer removed = widget.item.moves.removeAt(_prevIndex);
        sized2.remove(removed.key);
        widget.item.moves.insert(
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
      setStateCustom(() {
        widget.item.moves.insert(
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
    _timer = Timer(const Duration(milliseconds: 200), () {});
  }

  Widget canvas2(
    List<PointContainer?> candidateItems,
    BoxConstraints constraints,
  ) =>
      Align(
        child: Container(
          decoration: const BoxDecoration(
            color: CupertinoColors.systemBackground,
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            ),
          ),
          height: childHeight2 + 30,
          width: constraints.maxWidth - 15,
          child: ListView.builder(
            itemBuilder: (BuildContext context, int index) =>
                widget.item.moves.isEmpty && candidateItems.isEmpty
                    ? IgnorePointer(
                        key: _data_placeholder2[index].key,
                        child: ColorFiltered(
                          colorFilter: const ColorFilter.mode(
                            Colors.white54,
                            BlendMode.modulate,
                          ),
                          child: generateDismiss(
                            _data_placeholder2[index],
                            (Size size) {
                              setStateCustom(() {
                                sized2[_data_placeholder2[index].key] =
                                    size.height;
                              });
                            },
                          ),
                        ),
                      )
                    : Dismissible(
                        key: widget.item.moves[index].key,
                        child: LongPressDraggable<SimpleContainer>(
                          delay: const Duration(milliseconds: 200),
                          data: widget.item.moves[index].copy(),
                          feedback: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.45,
                            child: generateDismiss(
                              widget.item.moves[index],
                              (Size size) {},
                            ),
                          ),
                          child: generateDismiss(
                            widget.item.moves[index],
                            (Size size) {
                              setStateCustom(
                                () {
                                  sized2[widget.item.moves[index].key] =
                                      size.height;
                                },
                              );
                            },
                          ),
                          onDragStarted: () {
                            setStateCustom(
                              () {
                                sized2.remove(
                                  widget.item.moves[index].key,
                                );
                                widget.item.moves.removeAt(index);
                              },
                            );
                            context.read<BlockUpdateNotifier>().update();
                            if (widget.state.isEmpty) {
                              return;
                            }
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
                          setStateCustom(
                            () {
                              sized2.remove(
                                widget.item.moves[index].key,
                              );
                              widget.item.moves.removeAt(index);
                            },
                          );
                          context.read<BlockUpdateNotifier>().update();
                          if (widget.state.isEmpty) {
                            return;
                          }
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
            itemCount: widget.item.moves.isEmpty && candidateItems.isEmpty
                ? _data_placeholder2.length
                : widget.item.moves.length,
          ),
        ),
      );

  Widget generateDismiss(
    SimpleContainer container,
    Function f,
  ) {
    switch (container.type) {
      case ContainerType.fillEmpty:
        if (container is FillEmptyContainer) {
          return FillEmpty.context(
            item: container,
            onChange: f,
            state: List<State>.from(widget.state)..add(this),
          );
        }
        break;
      case ContainerType.go:
        if (container is GoContainer) {
          return Go.context(
            item: container,
            onChange: f,
            state: List<State>.from(widget.state)..add(this),
          );
        }
        break;
      case ContainerType.paint:
        if (container is PaintContainer) {
          return Paint.context(
            item: container,
            onChange: f,
            state: List<State>.from(widget.state)..add(this),
          );
        }
        break;
      case ContainerType.paintSingle:
        if (container is PaintSingleContainer) {
          return PaintSingle.context(
            item: container,
            onChange: f,
            state: List<State>.from(widget.state)..add(this),
          );
        }
        break;
      case ContainerType.copy:
        if (container is CopyCommandsContainer) {
          return CopyCommands.context(
            item: container,
            onChange: f,
            state: List<State>.from(widget.state)..add(this),
          );
        }
        break;
      case ContainerType.mirrorCross:
        if (container is MirrorSimpleContainer) {
          return MirrorCross.context(
            item: container,
            onChange: f,
            state: List<State>.from(widget.state)..add(this),
          );
        }
        break;
      case ContainerType.mirrorPoints:
        if (container is MirrorContainerPoints) {
          return MirrorPoints.context(
            item: container,
            onChange: f,
            state: List<State>.from(widget.state)..add(this),
          );
        }
        break;
      case ContainerType.mirrorCommands:
        if (container is MirrorContainerCommands) {
          return MirrorCommands.context(
            item: container,
            onChange: f,
            state: List<State>.from(widget.state)..add(this),
          );
        }
        break;
      case ContainerType.copyCells:
        if (container is CopyCellsContainer) {
          return CopyCells.context(
            item: container,
            onChange: f,
            state: List<State>.from(widget.state)..add(this),
          );
        }
        break;
      case ContainerType.point:
        if (container is PointContainer) {
          return Point.context(
            item: container,
            onChange: f,
            state: List<State>.from(widget.state)..add(this),
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
      case ContainerType.none:
        return WidgetContainer(
          onChange: f,
        )..item = container;
    }

    return WidgetContainer(
      onChange: f,
    )..item = container;
  }

  Size? oldSize = Size.zero;

  /// If the size of the widget has changed, call the onChange callback
  ///
  /// Args:
  ///   _: This is the callback function that will be called after the frame is
  /// rendered.
  ///
  /// Returns:
  ///   A function that is called after the frame is rendered.
  void postFrameCallback(_) {
    final BuildContext? context = widgetKey.currentContext;
    if (context == null) {
      return;
    }

    final Size? newSize = context.size;
    if (oldSize == newSize) {
      return;
    }

    oldSize = newSize;
    widget.onChange(newSize);
  }
}
