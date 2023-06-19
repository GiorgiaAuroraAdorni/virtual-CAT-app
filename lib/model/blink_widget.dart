import "package:cross_array_task_app/model/animation_controller_state.dart";
import "package:cross_array_task_app/utility/sine_curve.dart";
import "package:flutter/material.dart";

/// `ShakeWidget` is a `StatefulWidget` that takes a `child` widget,
/// a `shakeOffset` value,
/// a `shakeCount` value,
/// and a `shakeDuration` value
class BlinkWidget extends StatefulWidget {
  /// A constructor that takes in a `child` widget,
  /// a `shakeOffset` value,
  /// a `shakeCount` value,
  /// and a `shakeDuration` value
  const BlinkWidget({
    required this.child,
    required this.shakeOffset,
    required this.shakeCount,
    required this.shakeDuration,
    super.key,
  });

  /// A variable that is used to store the child widget that is passed in as a
  /// parameter to the `ShakeWidget` constructor.
  final Widget child;

  /// A variable that is used to store the value of
  /// the `shakeOffset` parameter that is passed in as a parameter to
  /// the `ShakeWidget` constructor.
  final double shakeOffset;

  /// Used to store the value of the `shakeCount` parameter that is passed
  /// in as a parameter to the `ShakeWidget` constructor.
  final double shakeCount;

  /// A variable that is used to store the value of
  /// the `shakeDuration` parameter that is passed in as a parameter to
  /// the `ShakeWidget` constructor.
  final Duration shakeDuration;

  @override
  BlinkWidgetState createState() => BlinkWidgetState(shakeDuration);
}

/// `ShakeWidgetState` is a class that extends `AnimationControllerState`
/// and uses  an `AnimatedBuilder` to animate
/// the `child` widget of the `ShakeWidget` class
class BlinkWidgetState extends AnimationControllerState<BlinkWidget> {
  /// Calling the constructor of the `AnimationControllerState` class
  BlinkWidgetState(super.duration);

  late final Animation<double> _sineAnimation = Tween<double>(
    begin: 0,
    end: 1,
  ).animate(
    CurvedAnimation(
      parent: animationController,
      curve: CustomCurve(count: widget.shakeCount.toDouble()),
    ),
  );

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
        animation: _sineAnimation,
        child: widget.child,
        builder: (BuildContext context, Widget? child) => ColorFiltered(
          colorFilter: ColorFilter.mode(
            Colors.white.withOpacity(_sineAnimation.value),
            BlendMode.lighten,
          ),
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
