import "package:flutter/material.dart";

/// It's a button that doesn't do anything
class DummyButton extends StatelessWidget {
  /// It's a constructor.
  DummyButton({required this.buttonDimension, super.key});

  /// A variable that is used to set the size of the button.
  double buttonDimension;

  @override
  Widget build(BuildContext context) => Container(
        width: buttonDimension,
        height: buttonDimension,
        decoration: const BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.all(Radius.circular(24)),
        ),
        child: const Center(
          child: Text(""),
        ),
      );
}
