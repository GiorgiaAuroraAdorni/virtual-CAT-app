import "package:flutter/material.dart";

/// It's a button that doesn't do anything
class DummyButton extends StatelessWidget {
  /// It's a constructor.
  DummyButton({super.key});

  @override
  Widget build(BuildContext context) => Padding(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width / 15 / 10),
        child: Container(
          width: MediaQuery.of(context).size.width / 15,
          height: MediaQuery.of(context).size.width / 15,
          decoration: const BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.all(Radius.circular(100)),
          ),
          child: const Center(
            child: Text(""),
          ),
        ),
      );
}
