part of stage;

class _StageBuildOffMainPage<T> extends StatelessWidget {

  _StageBuildOffMainPage(this.builder);

  final Widget Function(BuildContext, T) builder;

  @override
  Widget build(BuildContext context) {
    final StageData<T,dynamic> stage = Stage.of<T,dynamic>(context);

    return stage.mainPagesController._page.build(builder);
  }
}