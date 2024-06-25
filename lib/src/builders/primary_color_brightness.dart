part of 'package:stage/stage.dart';

class _StageBuildOffPrimaryColorBrightness extends StatelessWidget {
  const _StageBuildOffPrimaryColorBrightness(this.builder);

  final Widget Function(BuildContext, Brightness) builder;

  @override
  Widget build(BuildContext context) => Stage.of(context)!
      .themeController
      .derived
      .currentPrimaryColor
      .build((context, color) => builder(
            context,
            color.brightness,
          ));
}
