part of stage;

class _StageBuildOffPrimaryColorANDItsBrightness extends StatelessWidget {

  const _StageBuildOffPrimaryColorANDItsBrightness(this.builder);

  final Widget Function(BuildContext,Color, Brightness) builder;

  @override
  Widget build(BuildContext context) {
    final StageData stage = Stage.of(context)!;

    return stage.themeController.derived.currentPrimaryColor.build((context, color)
      => builder(context, color, color.brightness));
  }
}