import "package:cross_array_task_app/utility/SineCurve.dart";
import "package:flutter/material.dart";

import "animation_controller_state.dart";

class ShakeWidget extends StatefulWidget {
  const ShakeWidget({
    super.key,
    required this.child,
    required this.shakeOffset,
    required this.shakeCount,
    required this.shakeDuration,
  });

  final Widget child;
  final double shakeOffset;
  final int shakeCount;
  final Duration shakeDuration;

  @override
  ShakeWidgetState createState() => ShakeWidgetState(shakeDuration);
}

class ShakeWidgetState extends AnimationControllerState<ShakeWidget> {
  ShakeWidgetState(super.duration);
  late final Animation<num> _sineAnimation = Tween(
    begin: 0,
    end: 1.0,
  ).animate(CurvedAnimation(
    parent: animationController,
    curve: SineCurve(count: widget.shakeCount.toDouble()),
  ));

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
        animation: _sineAnimation,
        child: widget.child,
        builder: (BuildContext context, Widget? child) => Transform.translate(
          offset: Offset(_sineAnimation.value * widget.shakeOffset, 0),
          child: child,
        ),
      );

  @override
  void initState() {
    super.initState();
    animationController.addStatusListener(_updateStatus);
  }

  @override
  void dispose() {
    animationController.removeStatusListener(_updateStatus);
    super.dispose();
  }

  void _updateStatus(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      animationController.reset();
    }
  }

  /// `shake()` is a function that calls the `forward()` method of the
  /// `animationController` object
  void shake() {
    animationController.forward();
  }
}
