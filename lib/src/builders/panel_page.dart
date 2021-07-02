part of stage;

class _StageBuildOffPanelPage<S> extends StatelessWidget {

  _StageBuildOffPanelPage(this.builder);

  final Widget Function(BuildContext, S) builder;

  @override
  Widget build(BuildContext context) {
    final StageData<dynamic,S> stage = Stage.of<dynamic,S>(context)!;

    return stage.panelPagesController?._page?.build(builder as Widget Function(BuildContext, S?)) ?? Container();
  }
}