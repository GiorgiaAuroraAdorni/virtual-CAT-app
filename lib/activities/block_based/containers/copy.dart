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
import "package:cross_array_task_app/utility/cat_log.dart";
import "package:cross_array_task_app/utility/localizations.dart";
import "package:cross_array_task_app/utility/result_notifier.dart";
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

  /// A constructor for the Copy class.
  CopyCommands.build({
    required this.item,
    required super.onChange,
    super.key,
  });

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
  List<Widget> widgets = <Widget>[];
  List<Widget> widgets2 = <Widget>[];
  bool preview1 = true;
  bool preview2 = true;
  Map<Key, double> sized = <Key, double>{
    const Key("ciao"): 0.0,
    const Key("lalala"): 0.0,
  };

  Map<Key, double> sized2 = <Key, double>{
    const Key("ciao"): 0.0,
    const Key("lalala"): 0.0,
  };

  @override
  void initState() {
    super.initState();
    Future<void>(() {
      if (widget.item.container.isNotEmpty) {
        final List<SimpleContainer> copy =
            List<SimpleContainer>.from(widget.item.container);
        widget.item.container.clear();
        for (final SimpleContainer i in copy) {
          addOrigin(i, log: false);
        }
        final List<SimpleContainer> copy2 =
            List<SimpleContainer>.from(widget.item.moves);
        widget.item.moves.clear();
        for (final SimpleContainer i in copy2) {
          if (i is PointContainer) {
            addDestination(i, log: false);
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    SchedulerBinding.instance.addPostFrameCallback(postFrameCallback);
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

  Widget commands() => DragTarget<SimpleContainer>(
        builder: (
          BuildContext context,
          List<SimpleContainer?> candidateItems,
          List<dynamic> rejectedItems,
        ) =>
            LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            if (widget.item.container.isEmpty) {
              preview1 = true;
            }
            if (candidateItems.isNotEmpty && preview1) {
              preview1 = false;
              widget.item.added1 = false;
              widget.item.container.clear();
              widgets.clear();
              sized = <Key, double>{
                const Key("ciao"): 0.0,
                const Key("lalala"): 0.0,
              };
            }
            if (preview1) {
              return _preview(constraints);
            }

            return Align(
              child: Container(
                decoration: const BoxDecoration(
                  color: CupertinoColors.systemBackground,
                  borderRadius: BorderRadius.all(
                    Radius.circular(8),
                  ),
                ),
                height: childHeight + 30,
                width: constraints.maxWidth - 15,
                child: ReorderableListView(
                  onReorder: (int oldIndex, int newIndex) {
                    if (oldIndex < newIndex) {
                      newIndex -= 1;
                    }
                    final Widget widgett = widgets.removeAt(oldIndex);
                    final SimpleContainer item =
                        widget.item.container.removeAt(oldIndex);
                    widgets.insert(newIndex, widgett);
                    widget.item.container.insert(newIndex, item);
                  },
                  children: widgets,
                ),
              ),
            );
          },
        ),
        onWillAccept: (SimpleContainer? container) {
          if (container is SimpleContainer) {
            if (container.type == ContainerType.copy) {
              return false;
            }

            if (container.type == ContainerType.point) {
              return false;
            }

            return true;
          }

          return false;
        },
        onAccept: addOrigin,
      );

  Widget _preview(
    BoxConstraints constraints,
  ) {
    if (!widget.item.added1 &&
        widget.item.container.isEmpty &&
        widgets.isEmpty) {
      addOrigin(
        PaintSingleContainer(
          selected: CupertinoColors.systemBlue,
          languageCode: CATLocalizations.of(context).languageCode,
        ),
        update: false,
        log: false,
      );
      addOrigin(
        GoPositionContainer(
          a: "F",
          b: "3",
          languageCode: CATLocalizations.of(context).languageCode,
        ),
        update: false,
        log: false,
      );
      addOrigin(
        PaintSingleContainer(
          selected: CupertinoColors.systemRed,
          languageCode: CATLocalizations.of(context).languageCode,
        ),
        update: false,
        log: false,
      );
      widget.item.added1 = true;
    }

    return Align(
      child: Container(
        decoration: const BoxDecoration(
          color: CupertinoColors.systemBackground,
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
        ),
        height: childHeight + 30,
        width: constraints.maxWidth - 15,
        child: Center(
          child: AnimatedBuilder(
            animation: context.watch<TypeUpdateNotifier>(),
            builder: (BuildContext context, Widget? child) => IgnorePointer(
              child: ColorFiltered(
                colorFilter: const ColorFilter.mode(
                  Colors.white54,
                  BlendMode.modulate,
                ),
                child: ReorderableListView(
                  onReorder: (int oldIndex, int newIndex) {},
                  children: widgets,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void addOrigin(
    SimpleContainer el, {
    bool log = true,
    bool update = true,
  }) {
    Future<void>.delayed(Duration.zero, () async {
      final String prev = widget.item.toString();
      setState(
        () {
          final UniqueKey key = UniqueKey();
          final SimpleContainer container = el.copy();
          widget.item.container.add(
            container,
          );
          container.key = key;
          sized[key] = 0.0;
          widgets.add(
            Dismissible(
              key: key,
              child: generateDismiss(
                container,
                (Size size) {
                  setState(() {
                    sized[key] = size.height;
                  });
                },
              ),
              onDismissed: (DismissDirection direction) {
                final String prev = widget.item.toString();
                setState(() {
                  widget.item.container.removeWhere(
                    (SimpleContainer e) => e.key == key,
                  );
                  widgets.removeWhere(
                    (Widget element) => element.key == key,
                  );
                  sized.remove(key);
                });
                context.read<BlockUpdateNotifier>().update();

                CatLogger().addLog(
                  context: context,
                  previousCommand: prev,
                  currentCommand: widget.item.toString(),
                  description: CatLoggingLevel.removeCommand,
                );
              },
            ),
          );
          if (update) {
            context.read<BlockUpdateNotifier>().update();
          }
          if (log) {
            CatLogger().addLog(
              context: context,
              previousCommand: prev,
              currentCommand: widget.item.toString(),
              description: CatLoggingLevel.addCommand,
            );
          }
        },
      );
    });
  }

  Widget positions() => Flexible(
        flex: 0,
        child: DragTarget<PointContainer>(
          builder: (
            BuildContext context,
            List<PointContainer?> candidateItems,
            List<dynamic> rejectedItems,
          ) =>
              LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              if (widget.item.moves.isEmpty) {
                preview2 = true;
              }
              if (candidateItems.isNotEmpty && preview2) {
                preview2 = false;
                widget.item.added2 = false;
                widget.item.moves.clear();
                widgets2.clear();
                sized2 = <Key, double>{
                  const Key("ciao"): 0.0,
                  const Key("lalala"): 0.0,
                };
              }
              if (preview2) {
                if (!widget.item.added2 &&
                    widget.item.moves.isEmpty &&
                    widgets2.isEmpty) {
                  addDestination(
                    PointContainer(
                      languageCode: CATLocalizations.of(context).languageCode,
                    ),
                    update: false,
                    log: false,
                  );
                  widget.item.added2 = true;
                }

                return Align(
                  child: Container(
                    decoration: const BoxDecoration(
                      color: CupertinoColors.systemBackground,
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
                      ),
                    ),
                    height: childHeight2 + 30,
                    width: constraints.maxWidth - 15,
                    child: Center(
                      child: AnimatedBuilder(
                        animation: context.watch<TypeUpdateNotifier>(),
                        builder: (BuildContext context, Widget? child) =>
                            IgnorePointer(
                          child: ColorFiltered(
                            colorFilter: const ColorFilter.mode(
                              Colors.white54,
                              BlendMode.modulate,
                            ),
                            child: ReorderableListView(
                              onReorder: (int oldIndex, int newIndex) {},
                              children: widgets2,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }

              return Align(
                child: Container(
                  decoration: const BoxDecoration(
                    color: CupertinoColors.systemBackground,
                    borderRadius: BorderRadius.all(
                      Radius.circular(8),
                    ),
                  ),
                  height: childHeight2 + 30,
                  width: constraints.maxWidth - 15,
                  child: ReorderableListView(
                    onReorder: (int oldIndex, int newIndex) {
                      final String prev = widget.item.toString();
                      if (oldIndex < newIndex) {
                        newIndex -= 1;
                      }
                      final Widget widgett = widgets2.removeAt(oldIndex);
                      final SimpleContainer item =
                          widget.item.moves.removeAt(oldIndex);
                      widgets2.insert(newIndex, widgett);
                      widget.item.moves.insert(newIndex, item);
                      context.read<BlockUpdateNotifier>().update();
                      CatLogger().addLog(
                        context: context,
                        previousCommand: prev,
                        currentCommand: widget.item.toString(),
                        description: CatLoggingLevel.reorderCommand,
                      );
                    },
                    children: widgets2,
                  ),
                ),
              );
            },
          ),
          onAccept: addDestination,
        ),
      );

  void addDestination(
    PointContainer el, {
    bool log = true,
    bool update = true,
  }) {
    Future<void>.delayed(Duration.zero, () async {
      final String prev = widget.item.toString();
      setState(() {
        final UniqueKey key = UniqueKey();
        final PointContainer container = el.copy();
        widget.item.moves.add(
          container,
        );
        widget.item.moves.last.key = key;
        widgets2.add(
          Dismissible(
            key: key,
            child: Point(
              key: UniqueKey(),
              item: container,
              onChange: (Size size) {
                setState(() {
                  sized2[key] = size.height;
                });
              },
            ),
            onDismissed: (DismissDirection direction) {
              final String prev = widget.item.toString();
              setState(() {
                widgets2.removeWhere(
                  (Widget element) => element.key == key,
                );
                widget.item.moves.removeWhere(
                  (SimpleContainer element) => element.key == key,
                );
                sized2.remove(key);
              });
              context.read<BlockUpdateNotifier>().update();
              CatLogger().addLog(
                context: context,
                previousCommand: prev,
                currentCommand: widget.item.toString(),
                description: CatLoggingLevel.removeCommand,
              );
            },
          ),
        );
      });
      if (update) {
        context.read<BlockUpdateNotifier>().update();
      }
      if (log) {
        CatLogger().addLog(
          context: context,
          previousCommand: prev,
          currentCommand: widget.item.toString(),
          description: CatLoggingLevel.addCommand,
        );
      }
    });
  }

  Widget generateDismiss(
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
