part of 'package:stage/stage.dart';

class _StageBuildOffOpenNonAlertAllPages<T, S> extends StatelessWidget {
  const _StageBuildOffOpenNonAlertAllPages(this.builder);

  final Widget Function(BuildContext context, bool openNonAlert, T? mainPage, S? panelPage) builder;

  @override
  Widget build(BuildContext context) {
    final StageData<T, S> stage = Stage.of<T, S>(context)!;

    return Reactive.build3<bool, T?, S?>(
      stage.panelController.isMostlyOpenedNonAlert,
      stage.mainPagesController._page,
      stage.panelPagesController?._page ?? Reactive<S?>(null),
      builder: (con, op, mpg, ppg) => builder(con, op, mpg, ppg),
    );
  }
}
