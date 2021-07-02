part of stage;

class _StageBuildOffPrimaryColorBrightness extends StatelessWidget {

  _StageBuildOffPrimaryColorBrightness(this.builder);

  final Widget Function(BuildContext,Brightness) builder;

  @override
  Widget build(BuildContext context) {
    final StageData stage = Stage.of(context)!;

    return BlocVar.build2<Brightness?,Color?>(
      stage.themeController!.derived!.forcedPrimaryColorBrightness!,
      stage.themeController!.derived!.currentPrimaryColor!,
      builder: (context, forced, color){
        return builder(context, forced ?? ThemeData.estimateBrightnessForColor(color!));
      }
    );
  }
}