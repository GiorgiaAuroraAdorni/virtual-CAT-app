import "package:cross_array_task_app/utility/cat_log.dart";
import "package:cross_array_task_app/utility/result_notifier.dart";
import "package:cross_array_task_app/utility/visibility_notifier.dart";
import "package:flutter/cupertino.dart";
import "package:flutter_svg/svg.dart";
import "package:interpreter/cat_interpreter.dart";
import "package:provider/provider.dart";

class ChangeCrossVisualization extends StatelessWidget {
  const ChangeCrossVisualization({super.key});

  final double _paddingSize = 5;

  @override
  Widget build(BuildContext context) => Padding(
        padding: EdgeInsets.all(_paddingSize),
        child: AnimatedBuilder(
          animation: context.watch<VisibilityNotifier>(),
          builder: (BuildContext context, Widget? child) => Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CupertinoButton(
                onPressed: !context.read<VisibilityNotifier>().visible
                    ? null
                    : () {
                        context.read<VisibilityNotifier>().visible = false;
                        context.read<ResultNotifier>().cross = Cross();
                        CatLogger().addLog(
                          context: context,
                          previousCommand: "",
                          currentCommand: "",
                          description: CatLoggingLevel.changeVisibility,
                        );
                      },
                disabledColor: CupertinoColors.activeOrange,
                borderRadius: BorderRadius.circular(45),
                minSize: 45,
                padding: EdgeInsets.zero,
                color: CupertinoColors.opaqueSeparator,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(1000),
                  child: SvgPicture.asset(
                    "resources/icons/closed_eye.svg",
                    height: 45,
                    width: 45,
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                      !context.read<VisibilityNotifier>().visible
                          ? CupertinoColors.tertiarySystemFill
                          : CupertinoColors.inactiveGray,
                      BlendMode.color,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              CupertinoButton(
                onPressed: context.watch<VisibilityNotifier>().visible
                    ? null
                    : () {
                        context.read<VisibilityNotifier>().visible = true;
                        CatLogger().addLog(
                          context: context,
                          previousCommand: "",
                          currentCommand: "",
                          description: CatLoggingLevel.changeVisibility,
                        );
                      },
                borderRadius: BorderRadius.circular(45),
                minSize: 45,
                padding: EdgeInsets.zero,
                disabledColor: CupertinoColors.activeOrange,
                color: CupertinoColors.opaqueSeparator,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(1000),
                  child: SvgPicture.asset(
                    "resources/icons/open_eye.svg",
                    height: 45,
                    width: 45,
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                      context.read<VisibilityNotifier>().visible
                          ? CupertinoColors.tertiarySystemFill
                          : CupertinoColors.inactiveGray,
                      BlendMode.color,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
