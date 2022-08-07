part of stage;

class _StageBuildOffOpenNonAlert extends StatelessWidget {

  const _StageBuildOffOpenNonAlert(this.builder);

  final Widget Function(BuildContext, bool) builder;

  @override
  Widget build(BuildContext context) {
    final StageData stage = Stage.of(context)!;

    return stage.panelController.isMostlyOpenedNonAlert.build(builder);
  }
}