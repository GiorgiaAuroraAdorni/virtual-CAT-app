import 'package:flutter/cupertino.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(5),
            child: CupertinoButton(
              key: const Key("Schema completed"),
              onPressed: () async {
                // await _schemaCompleted().then((int result) {
                //   if (result == -1) {
                //     Navigator.pop(context);
                //   }
                // });
              },
              borderRadius: BorderRadius.circular(45),
              minSize: 45,
              padding: EdgeInsets.zero,
              color: CupertinoColors.systemGreen.highContrastColor,
              child: const Icon(
                CupertinoIcons.arrow_right,
              ),
            ),
          ),
        ],
      );
}
