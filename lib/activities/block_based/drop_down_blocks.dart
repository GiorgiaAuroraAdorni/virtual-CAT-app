import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";

class DropDownBlocks extends StatefulWidget {
  const DropDownBlocks({
    required this.title,
    required this.items,
    super.key,
  });

  final String title;
  final List<Widget> items;

  @override
  _DropDownBlocksState createState() => _DropDownBlocksState();
}

class _DropDownBlocksState extends State<DropDownBlocks> {
  bool _visibility = false;

  final ScrollController _firstController = ScrollController();

  @override
  Widget build(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.20,
            child: Padding(
              padding: const EdgeInsets.only(right: 10, bottom: 5, top: 5),
              child: CupertinoButton(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(widget.title),
                    Icon(
                      _visibility ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                    ),
                  ],
                ),
                onPressed: () => setState(() {
                  _visibility = !_visibility;
                }),
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
