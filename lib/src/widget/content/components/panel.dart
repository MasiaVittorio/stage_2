part of stage;

class _Panel extends StatelessWidget {

  const _Panel({
    required this.panelAnimation,
    required this.snackBarAnimation,
    required this.realDelta,
    required this.derived,
    required this.boxedCollapsed,
    required this.boxedExtended,
    required this.maxAlertHeight,
    required this.dimensions,
    required this.onPanelDrag,
    required this.onPanelDragEnd,
    required this.shadowBuilder,
    required this.singleShadow,
    required this.customDecorationBuilder,
  });

  final void Function(DragUpdateDetails, double) onPanelDrag;
  final void Function(DragEndDetails)  onPanelDragEnd;

  final Animation<double> panelAnimation;
  final Animation<double> snackBarAnimation;
  final double realDelta;
  final _StageDerivedDimensions derived;
  final StageDimensions dimensions;
  // final bool thereIsCollapsed; 
  final Widget? boxedCollapsed; /// Could be null
  final Widget boxedExtended;

  final double maxAlertHeight;

  final StageShadowBuilder shadowBuilder; // Different shadow for each panel value (0=closed, 1=opened)
  final BoxShadow? singleShadow; // If you do not need to animate the shadow
  final StagePanelDecorationBuilder? customDecorationBuilder; // To override shadows, radiuses, background color etc

  @override
  Widget build(BuildContext context) {

    final Widget content = _PanelContent(
      alertMaxHeight: maxAlertHeight,
      derived: derived,
      panelAnimation: panelAnimation,
      realDelta: realDelta,
      snackBarAnimation: snackBarAnimation,
      boxedCollapsed: boxedCollapsed,
      boxedExtended: boxedExtended,
      dimensions: dimensions,
    );

    final data = Stage.of(context)!;
    final theme = Theme.of(context);

    return AnimatedBuilder(
      animation: panelAnimation,
      child: content,
      builder: (_, child){

        // Much faster without clamping, but not suitable if the animation overshoots
        final double clampedVal = panelAnimation.value.clamp(0.0, 1.0);

        final Widget result = data.themeController.colorPlace.build((context, place) 
          => data.themeController.derived.currentPrimaryColor.build((_, mainPrimaryColor) 
            => Container(

              decoration: customDecorationBuilder?.call(
                clampedVal,
                theme,
                place,
                dimensions,
                mainPrimaryColor,
              ) ?? BoxDecoration(
                borderRadius: BorderRadius.circular(
                  clampedVal.mapToRangeLoose(
                    dimensions.panelRadiusClosed, 
                    dimensions.panelRadiusOpened,
                  ),
                ),
                boxShadow: [singleShadow ?? shadowBuilder(clampedVal, place)],
              ),

              //this is really heavy but needed for the various layers of stuff in the content
              clipBehavior: Clip.antiAliasWithSaveLayer, 

              child: child,
            ),
          ),
        );
        
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: clampedVal.mapToRangeLoose(
            dimensions.panelHorizontalPaddingClosed, 
            dimensions.panelHorizontalPaddingOpened,
          )),
          child: data.panelController.alertController.currentSize
            .build((_, alertSize) => alertSize == double.infinity 
              ? result 
              : GestureDetector(
                onVerticalDragUpdate: (details) => onPanelDrag(details, realDelta),
                onVerticalDragEnd: onPanelDragEnd,
                child: result,
              ),),
        );
      },
    );

  }
}