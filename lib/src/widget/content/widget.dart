part of stage;


class _StageContent<T,S> extends StatefulWidget {

  const _StageContent({
    //logic
    required this.data,

    //content
    required this.body,
    required this.collapsedPanel,
    required this.extendedPanel,
    required this.extendedPanelBuilder,
    required this.topBarBuilder,
    required this.scaffoldBackgroundFill,

    //theming
    required this.shadowBuilder,
    required this.singleShadow,
    required this.backgroundColor,
    required this.backgroundOpacity,
    required this.customDecorationBuilder,

    required this.splashScreen,

    required this.wholeScreen,
  }): assert(extendedPanelBuilder != null || extendedPanel != null);

  //logic
  final StageData<T,S>? data;

  //performance optimization
  final bool wholeScreen;
  // if true, the size of the mediaQuery is used instead of layout builder, which should greatly improve performance

  //content
  final Widget body;
  final Widget? collapsedPanel; //could be null, but why should it?
  final Widget? extendedPanel; //could be null if the builder is there
  final Widget Function(BuildContext, Animation)? extendedPanelBuilder;
  final Widget Function(Animation) topBarBuilder;
  final Widget? scaffoldBackgroundFill; // to override the regularly colored scaffold background


  //theming
  final StageBackgroundGetter? backgroundColor;
  final double? backgroundOpacity;
  final StageShadowBuilder shadowBuilder; // Different shadow for each panel value (0=closed, 1=opened)
  final BoxShadow? singleShadow; // If you do not need to animate the shadow
  final StagePanelDecorationBuilder? customDecorationBuilder; // To override shadows, radiuses, background color etc

  //splash screen stuff
  final Widget? splashScreen;

  @override
  _StageContentState<T,S> createState() => _StageContentState<T,S>();
}
