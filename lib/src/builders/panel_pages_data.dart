part of stage;

class _StageBuildOffPanelPagesData<S> extends StatelessWidget {

  _StageBuildOffPanelPagesData(this.builder);

  final Widget Function(BuildContext, Map<S,bool>, List<S>, S) builder;

  @override
  Widget build(BuildContext context) {
    final StageData<dynamic,S> stage = Stage.of<dynamic,S>(context);

    return BlocVar.build3<Map<S,bool>, List<S>,S>(
      stage.panelPagesController._enabledPages,
      stage.panelPagesController._orderedPages,
      stage.panelPagesController._page,
      builder: builder,
    );
  }
}