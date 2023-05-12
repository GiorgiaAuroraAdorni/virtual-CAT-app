import "package:cross_array_task_app/utility/result_notifier.dart";
import "package:flutter/cupertino.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:provider/provider.dart";

class DropDownBlocks extends AnimatedWidget {
  const DropDownBlocks({
    required this.title,
    required this.iconLocation,
    required this.items,
    required this.color,
    required this.visibility,
    super.key,
  }) : super(listenable: visibility);

  final String title;
  final String iconLocation;
  final List<Widget> items;
  final Color color;

  final ValueNotifier<bool> visibility;

  @override
  Widget build(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.20,
            child: Padding(
              padding: const EdgeInsets.only(right: 10, bottom: 5, top: 5),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  border: Border(
                    right: BorderSide(
                      width: 10,
                      color: color,
                    ),
                  ),
                ),
                position: DecorationPosition.foreground,
                child: CupertinoButton(
                  padding: const EdgeInsets.all(16),
                  borderRadius: BorderRadius.zero,
                  color: visibility.value
                      ? color
                      : CupertinoColors.extraLightBackgroundGray,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      AnimatedBuilder(
                        animation: context.read<TypeUpdateNotifier>(),
                        builder: (_, __) {
                          if (context.read<TypeUpdateNotifier>().state == 2) {
                            return Text(
                              title,
                              style: TextStyle(
                                color: visibility.value
                                    ? CupertinoColors.extraLightBackgroundGray
                                    : color,
                                fontWeight: FontWeight.bold,
                              ),
                            );
                          }

                          return SvgPicture.asset(
                            iconLocation,
                            height: 25,
                            width: 25,
                            fit: BoxFit.cover,
                            colorFilter: ColorFilter.mode(
                              visibility.value ? CupertinoColors.white : color,
                              BlendMode.modulate,
                            ),
                          );
                        },
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
