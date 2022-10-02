import "package:flutter/cupertino.dart";

/// This class is a stateful widget that provides an animation controller with a
/// duration
abstract class AnimationControllerState<T extends StatefulWidget>
    extends State<T> with SingleTickerProviderStateMixin {
  /// A constructor that takes in a duration and sets the animation duration
  /// to that duration.
  AnimationControllerState(this.animationDuration);

  /// A variable that is set to the duration that is passed in.
  final Duration animationDuration;

  /// Creating an animation controller with the duration that is passed in.
  late final AnimationController animationController = AnimationController(
    vsync: this,
    duration: animationDuration,
  );

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}
