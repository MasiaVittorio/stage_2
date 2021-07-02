part of stage;

class _StageBuildOffMainEnabledPages<T> extends StatelessWidget {

  _StageBuildOffMainEnabledPages(this.builder);

  final Widget Function(BuildContext, Map<T,bool>, ) builder;

  @override
  Widget build(BuildContext context) {
    final StageData<T,dynamic> stage = Stage.of<T,dynamic>(context)!;

    return stage.mainPagesController._enabledPages.build(builder);
  }
}