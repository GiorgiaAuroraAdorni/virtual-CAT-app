import "dart:math";

import "package:flutter/animation.dart";

/// "SineCurve is a Curve that transforms a value by applying a sine function to
/// it."
///
/// The `transformInternal` method is the only method that needs to be implemented.
/// It takes a value between 0.0 and 1.0 and returns a value between 0.0 and 1.0
class SineCurve extends Curve {
  /// Setting the default value of the `count` parameter to 3.
  const SineCurve({this.count = 3});

  /// A parameter that is passed to the constructor.
  final double count;

  /// "The transformInternal function returns the sine of the count times 2 times pi
  /// times t."
  ///
  /// The first thing to notice is that the function returns a double. This is
  /// because the transformInternal function is a function that returns a double
  ///
  /// Args:
  ///   t (double): The current time, in seconds.
  ///
  /// Returns:
  ///   The sine of the count times 2 times pi times t.
  @override
  double transformInternal(double t) => sin(count * 2 * pi * t);
}
