part of stage;


class _PanelContent extends StatelessWidget {

  _PanelContent({
    @required this.panelAnimation,
    @required this.snackBarAnimation,
    @required this.realDelta,
    @required this.derived,
    @required this.boxedCollapsed,
    @required this.boxedExtended,
    @required this.alertMaxHeight,
    @required this.dimensions,
  });

  final Animation<double> panelAnimation;
  final Animation<double> snackBarAnimation;
  final double realDelta;
  final _StageDerivedDimensions derived;
  final Widget boxedCollapsed; /// Could be null
  final Widget boxedExtended;

  final double alertMaxHeight;

  final StageDimensions dimensions;

  @override
  Widget build(BuildContext context) {

    final StageData stage = Stage.of(context);

    Widget fadedCollapsed;

    if(boxedCollapsed != null){
      fadedCollapsed = AnimatedBuilder(
        animation: panelAnimation,
        child: boxedCollapsed, //expanded material with boxed collapsed on top center
        builder: (_, child) {
          final double clampedVal = panelAnimation.value; //faster without clamping, it is already clamped in mapToRange also
          // final double clampedVal = panelAnimation.value.clamp(0.0, 1.0);
          return IgnorePointer(
            ignoring: clampedVal != 0.0,
            child: Opacity(
              opacity: DoubleExt.mapToRange(clampedVal, 1.0, 0.0, fromMin: dimensions.barSize/realDelta, fromMax: 1.0),
              child: child,
            ),
          );
        },
      );
    }

    return MediaQuery.removePadding(
      context: context,
      removeBottom: true,
      removeLeft: true,
      removeRight: true,
      removeTop: true,
      child: BlocVar.build2<Widget,Widget>(
        stage.panelController.snackbarController.child,
        stage.panelController.alertController.currentChild,
        builder: (_, Widget snackBarChild, Widget alertChild) => Stack(
          fit: StackFit.expand,
          alignment: Alignment.topCenter,
          overflow: Overflow.clip,
          children: <Widget>[

            Positioned(
              top: 0.0,
              width: derived.panelWidthOpened,
              height: derived.totalPanelHeight,
              child: boxedExtended
            ),

            if(alertChild != null) Positioned( 
              top: 0.0,
              width: derived.panelWidthOpened,
              height: alertMaxHeight,
              child: Material(child: alertChild),
            ),

            if(fadedCollapsed != null) Positioned(
              top: 0.0,
              width: derived.panelWidthOpened,
              height: derived.totalPanelHeight,
              child: fadedCollapsed,
            ),

            if(snackBarChild != null) Positioned.fill(
              child: _StageSnackBar(
                animation: snackBarAnimation,
                child: snackBarChild,
              ),
            ),

          ],
        ),
      ),
    );
  }
}