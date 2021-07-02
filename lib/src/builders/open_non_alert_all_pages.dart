part of stage;

class _StageBuildOffOpenNonAlertAllPages<T,S> extends StatelessWidget {

  _StageBuildOffOpenNonAlertAllPages(this.builder);

  final Widget Function(BuildContext context, bool openNonAlert, T? mainPage, S? panelPage) builder;

  @override
  Widget build(BuildContext context) {
    final StageData<T,S> stage = Stage.of<T,S>(context)!;

    return BlocVar.build3<bool,T?,S?>(
      stage.panelController.isMostlyOpenedNonAlert,
      stage.mainPagesController._page,
      stage.panelPagesController?._page ?? BlocVar<S?>(null),
      builder: (con, op, mpg, ppg) => builder(con, op!, mpg, ppg),
    );
  }
}