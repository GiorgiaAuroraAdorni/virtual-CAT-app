import "package:flutter/cupertino.dart";

class DropDownBlocks extends StatefulWidget {
  const DropDownBlocks({
    required this.title,
    required this.items,
    required this.color,
    super.key,
  });

  final String title;
  final List<Widget> items;
  final Color color;

  @override
  _DropDownBlocksState createState() => _DropDownBlocksState();
}

class _DropDownBlocksState extends State<DropDownBlocks> {
  bool _visibility = false;

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
                  color: _visibility
                      ? CupertinoColors.activeGreen
                      : CupertinoColors.extraLightBackgroundGray,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Icon(
                        CupertinoIcons.circle_filled,
                        color: widget.color,
                      ),
                      Text(
                        widget.title,
                        style: TextStyle(
                          color: _visibility
                              ? CupertinoColors.extraLightBackgroundGray
                              : CupertinoColors.label,
                        ),
                      ),
                    ],
                  ),
                  onPressed: () => setState(() {
                    _visibility = !_visibility;
                  }),
                ),
              ),
            ),
          ),
          Visibility(
            visible: _visibility,
            child: ListView.separated(
              itemCount: widget.items.length,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) =>
                  widget.items[index],
              separatorBuilder: (BuildContext context, int index) =>
                  const SizedBox(
                height: 5,
              ),
            ),
          ),
        ],
      );
}
