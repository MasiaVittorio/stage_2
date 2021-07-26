part of stage;

class _StageBuildOffPanelMostlyOpened extends StatelessWidget {

  _StageBuildOffPanelMostlyOpened(this.builder);

  final Widget Function(BuildContext, bool) builder;

  @override
  Widget build(BuildContext context) {
    final StageData stage = Stage.of(context)!;

    return stage.panelController.isMostlyOpened.build(builder);
  }
}