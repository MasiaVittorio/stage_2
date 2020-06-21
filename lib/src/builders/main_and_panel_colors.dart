part of stage;

class _StageBuildOffMainColors<T> extends StatelessWidget {

  _StageBuildOffMainColors(this.builder);

  final Widget Function(BuildContext,Color, Map<T,Color>) builder;

  @override
  Widget build(BuildContext context) {
    final StageData<T,dynamic> stage = Stage.of<T,dynamic>(context);
    final controller = stage.themeController.derived;

    return BlocVar.build2<Color, Map<T,Color>>(
      controller._mainPrimaryColor,
      controller.mainPageToPrimaryColor,
      builder: builder,
    );
  }
}


class _StageBuildOffPanelColors<S> extends StatelessWidget {

  _StageBuildOffPanelColors(this.builder);

  final Widget Function(BuildContext,Color, Map<S,Color>) builder;

  @override
  Widget build(BuildContext context) {
    final StageData<dynamic,S> stage = Stage.of<dynamic,S>(context);
    final controller = stage.themeController.derived;

    return BlocVar.build2<Color, Map<S,Color>>(
      controller._panelPrimaryColor,
      controller.panelPageToPrimaryColor,
      builder: builder,
    );
  }
}