part of stage;

class _StageBuildOffPrimaryColorANDItsBrightness extends StatelessWidget {

  _StageBuildOffPrimaryColorANDItsBrightness(this.builder);

  final Widget Function(BuildContext,Color?, Brightness) builder;

  @override
  Widget build(BuildContext context) {
    final StageData stage = Stage.of(context)!;

    return BlocVar.build2<Brightness?,Color?>(
      stage.themeController!.derived!.forcedPrimaryColorBrightness!,
      stage.themeController!.derived!.currentPrimaryColor!,
      builder: (context, forced, color){
        return builder(context, color, forced ?? color!.brightness);
      }
    );
  }
}