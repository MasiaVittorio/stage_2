part of stage;

class _StageBuildOffMainPagesData<T> extends StatelessWidget {

  _StageBuildOffMainPagesData(this.builder);

  final Widget Function(BuildContext, Map<T?,bool>?, List<T?>?, T?) builder;

  @override
  Widget build(BuildContext context) {
    final StageData<T,dynamic> stage = Stage.of<T,dynamic>(context)!;

    return BlocVar.build3<Map<T?,bool>?, List<T?>?,T?>(
      stage.mainPagesController!._enabledPages!,
      stage.mainPagesController!._orderedPages,
      stage.mainPagesController!._page,
      builder: builder,
    );
  }
}