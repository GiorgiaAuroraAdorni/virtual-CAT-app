import "dart:async";
import "dart:math";

import "package:cross_array_task_app/activities/block_based/containers/point.dart";
import "package:cross_array_task_app/activities/block_based/containers/widget_container.dart";
import "package:cross_array_task_app/activities/block_based/model/paint_multiple_container.dart";
import "package:cross_array_task_app/activities/block_based/model/point_container.dart";
import "package:cross_array_task_app/activities/block_based/model/simple_container.dart";
import "package:cross_array_task_app/activities/block_based/types/container_type.dart";
import "package:cross_array_task_app/model/interpreter/cat_interpreter.dart";
import "package:cross_array_task_app/utility/cat_log.dart";
import "package:cross_array_task_app/utility/localizations.dart";
import "package:cross_array_task_app/utility/result_notifier.dart";
import "package:dartx/dartx.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:flutter/scheduler.dart";
import "package:flutter_sfsymbols/flutter_sfsymbols.dart";
import "package:provider/provider.dart";

class PaintMultiple extends WidgetContainer {
  PaintMultiple({
    required this.item,
    required super.onChange,
    super.key,
  });

  PaintMultiple.build({
    required this.item,
    required super.onChange,
    super.key,
  });

  PaintMultiple.context({
    required this.item,
    required super.onChange,
    required this.state,
    super.key,
  });

  List<State> state = [];

  @override
  final PaintMultipleContainer item;

  @override
  _PaintMultipleState createState() => _PaintMultipleState();
}

class _PaintMultipleState extends State<PaintMultiple> {
  final GlobalKey<State<PaintMultiple>> widgetKey = GlobalKey();
  double childHeight = 0;
  int _prevIndex = -1;
  Map<Key, double> sized = <Key, double>{};
  Timer _timer = Timer(Duration.zero, () {});

  late final List<SimpleContainer> _data_placeholder = <SimpleContainer>[
    PointContainer(
      languageCode: CATLocalizations.of(context).languageCode,
    )..key = GlobalKey(),
    PointContainer(
      languageCode: CATLocalizations.of(context).languageCode,
      b: "2",
    )..key = GlobalKey(),
    PointContainer(
      languageCode: CATLocalizations.of(context).languageCode,
      a: "D",
      b: "2",
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
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    SchedulerBinding.instance.addPostFrameCallback(postFrameCallback);
    if (sized.isEmpty) {
      sized = <Key, double>{const Key("ciao"): 0.0, const Key("lalala"): 0.0};
    }

    childHeight = sized.entries
        .map((MapEntry<Key, double> e) => e.value)
        .reduce((double a, double b) => a + b);

    return Container(
      key: widgetKey,
      height: childHeight +
          100 +
          (context.read<TypeUpdateNotifier>().state == 2 ? 50 : 0),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        border: Border.all(),
        color: Colors.teal,
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      child: Center(
        child: figure(),
      ),
    );
  }

  Widget header() => AnimatedBuilder(
        animation: context.watch<TypeUpdateNotifier>(),
        builder: (BuildContext context, Widget? child) {
          if (context.read<TypeUpdateNotifier>().state == 2) {
            return Column(
              children: [
                Text(
                  CATLocalizations.of(context).blocks["paintMultiple"]!,
                  style: const TextStyle(
                    color: CupertinoColors.systemBackground,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Container(
                  padding: const EdgeInsets.all(1),
                  decoration: const BoxDecoration(
                    color: CupertinoColors.systemGrey5,
                    borderRadius: BorderRadius.all(
                      Radius.circular(8),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: _colorButtonsBuild(),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
              ],
            );
          }

          return Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    const Icon(
                      SFSymbols.paintbrush_fill,
                      color: CupertinoColors.systemBackground,
                    ),
                    Container(
                      padding: const EdgeInsets.all(1),
                      decoration: const BoxDecoration(
                        color: CupertinoColors.systemGrey5,
                        borderRadius: BorderRadius.all(
                          Radius.circular(8),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: _colorButtonsBuild(),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
              ],
            ),
          );
        },
      );

  Widget figure() => Padding(
        padding: const EdgeInsets.all(5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            header(),
            DragTarget<PointContainer>(
              builder: (
                BuildContext context,
                List<PointContainer?> candidateItems,
                List<dynamic> rejectedItems,
              ) =>
                  LayoutBuilder(
                builder: (
                  BuildContext context,
                  BoxConstraints constraints,
                ) =>
                    canvas(candidateItems, constraints),
              ),
              onLeave: (_) {
                Timer(const Duration(milliseconds: 40), () {
                  setStateCustom(() {
                    widget.item.container = widget.item.container
                        .filter(
                          (SimpleContainer e) => e.type != ContainerType.none,
                        )
                        .toList();
                    sized = sized.filter(
                      (MapEntry<Key, double> entry) =>
                          widget.item.container.any(
                        (SimpleContainer element) => element.key == entry.key,
                      ),
                    );
                    _prevIndex = -1;
                  });
                });
              },
              onMove: (DragTargetDetails<SimpleContainer> details) =>
                  Timer(const Duration(milliseconds: 30), () {
                move(details);
              }),
              onAcceptWithDetails:
                  (DragTargetDetails<SimpleContainer> details) {
                Timer(const Duration(milliseconds: 40), () {
                  final String prev = CatInterpreter()
                      .allCommandsBuffer
                      .map((SimpleContainer e) => e.toString())
                      .join(",");
                  final SimpleContainer copy = details.data.copy()
                    ..key = GlobalKey();
                  setStateCustom(() {
                    widget.item.container.insert(_prevIndex, copy);
                    widget.item.container = widget.item.container
                        .filter(
                          (SimpleContainer e) => e.type != ContainerType.none,
                        )
                        .toList();
                    sized = sized.filter(
                      (MapEntry<Key, double> entry) =>
                          widget.item.container.any(
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
                    previousCommand: prev,
                    currentCommand: CatInterpreter()
                        .allCommandsBuffer
                        .map((SimpleContainer e) => e.toString())
                        .join(","),
                    description: CatLoggingLevel.addCommand,
                  );
                });
              },
            ),
          ],
        ),
      );

  Widget canvas(
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
                            child: IgnorePointer(
                              child: generateDismiss(
                                widget.item.container[index],
                                (Size size) {},
                              ),
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
                            final String prev = CatInterpreter()
                                .allCommandsBuffer
                                .map((SimpleContainer e) => e.toString())
                                .join(",");
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
                              previousCommand: prev,
                              currentCommand: CatInterpreter()
                                  .allCommandsBuffer
                                  .map((SimpleContainer e) => e.toString())
                                  .join(","),
                              description: CatLoggingLevel.removeCommand,
                            );
                          },
                        ),
                        onDismissed: (_) {
                          final String prev = CatInterpreter()
                              .allCommandsBuffer
                              .map((SimpleContainer e) => e.toString())
                              .join(",");
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
                            previousCommand: prev,
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

  void move(DragTargetDetails<SimpleContainer> details) {
    if (!mounted) {
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

  Widget generateDismiss(
    SimpleContainer container,
    Function f,
  ) {
    switch (container.type) {
      case ContainerType.fillEmpty:
        break;
      case ContainerType.go:
        break;
      case ContainerType.goPosition:
        break;
      case ContainerType.paint:
        break;
      case ContainerType.paintSingle:
        break;
      case ContainerType.copy:
        break;
      case ContainerType.mirrorCross:
        break;
      case ContainerType.mirrorPoints:
        break;
      case ContainerType.mirrorCommands:
        break;
      case ContainerType.copyCells:
        break;
      case ContainerType.paintMultiple:
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
      case ContainerType.none:
        return WidgetContainer(
          onChange: f,
        )..item = container;
    }

    return WidgetContainer(
      onChange: f,
    )..item = container;
  }

  List<Widget> _colorButtonsBuild() {
    const TextStyle textStyle = TextStyle(
      color: CupertinoColors.black,
      fontFamily: "CupertinoIcons",
      fontSize: 13,
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
            padding: const EdgeInsets.all(5),
            child: CupertinoButton(
              key: Key(colors[color]!),
              onPressed: () {
                final String prev = widget.item.toString();
                setStateCustom(() {
                  if (widget.item.selectedColors.contains(color)) {
                    widget.item.selectedColors.remove(color);
                  } else {
                    widget.item.selectedColors.add(color);
                  }
                });
                context.read<BlockUpdateNotifier>().update();
                if (widget.state.isEmpty) {
                  return;
                }
                CatLogger().addLog(
                  context: context,
                  previousCommand: prev,
                  currentCommand: widget.item.toString(),
                  description: CatLoggingLevel.updateCommandProperties,
                );
              },
              borderRadius: BorderRadius.circular(45),
              minSize: 30,
              color: color,
              padding: EdgeInsets.zero,
              child: widget.item.selectedColors.contains(color)
                  ? Stack(
                      alignment: AlignmentDirectional.center,
                      children: <Widget>[
                        const Icon(
                          CupertinoIcons.circle_filled,
                          size: 20,
                        ),
                        Text(
                          "${widget.item.selectedColors.indexOf(color) + 1}",
                          style: textStyle,
                        ),
                      ],
                    )
                  : const Text(""),
            ),
          ),
        )
        .toList();
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
