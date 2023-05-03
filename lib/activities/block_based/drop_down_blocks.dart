import "package:flutter/cupertino.dart";

// class DropDownBlocks extends StatefulWidget {
//   const DropDownBlocks({
//     required this.title,
//     required this.items,
//     required this.color,
//     super.key,
//   });
//
//   final String title;
//   final List<Widget> items;
//   final Color color;
//
//   @override
//   _DropDownBlocksState createState() => _DropDownBlocksState();
// }

class DropDownBlocks extends AnimatedWidget {
  const DropDownBlocks({
    required this.title,
    required this.items,
    required this.color,
    required this.visibility,
    super.key,
  }) : super(listenable: visibility);

  final String title;
  final List<Widget> items;
  final Color color;

  final ValueNotifier<bool> visibility;

  @override
  Widget build(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.20,
            child: Padding(
              padding: const EdgeInsets.only(right: 10, bottom: 5, top: 5),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  border: Border.all(color: CupertinoColors.darkBackgroundGray),
                ),
                position: DecorationPosition.foreground,
                child: CupertinoButton(
                  padding: const EdgeInsets.all(16),
                  borderRadius: BorderRadius.zero,
                  color: !visibility.value
                      ? color
                      : CupertinoColors.extraLightBackgroundGray,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        title,
                        style: TextStyle(
                          color: !visibility.value
                              ? CupertinoColors.extraLightBackgroundGray
                              : CupertinoColors.label,
                        ),
                      ),
                    ],
                  ),
                  onPressed: () => visibility.value = !visibility.value,
                ),
              ),
            ),
          ),
          Visibility(
            visible: visibility.value,
            child: ListView.separated(
              itemCount: items.length,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) => items[index],
              separatorBuilder: (BuildContext context, int index) =>
                  const SizedBox(
                height: 5,
              ),
            ),
          ),
        ],
      );
}
