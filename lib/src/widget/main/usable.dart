part of stage;

typedef StageShadowBuilder = BoxShadow Function(double, StageColorPlace);
typedef StageBackgroundGetter = Color Function(ThemeData, StageColorPlace);

class Stage<T,S> extends StatelessWidget {

  static StageData<A,B>? of<A,B>(BuildContext context) => StageProvider.of<A,B>(context);

  const Stage({
    Key? key,

    //content
    required this.body,
    required this.collapsedPanel,
    required this.extendedPanel,
    this.extendedPanelBuilder, //can use this and set the regular one to null
    required this.topBarContent,

    /// Optional external controller
    this.controller, /// Either you put this, or you set the initial controller values

    // Optional disk persistence
    this.storeKey,
    this.mainPageToJson,
    this.jsonToMainPage,
    this.panelPageToJson,
    this.jsonToPanelPage,

    // Initial controller values (if not external controller, main pages data are required)
    this.stageTheme, /// Can be null
    this.mainPages, /// required (if not external controller)
    this.panelPages, /// Can be null
    this.dimensions, /// Can be null
    this.panelData, /// Could be null
    this.popBehavior, /// Can be null
    this.onMainPageChanged, /// Can be null

    // Appearance stuff
    this.backgroundColor,
    this.backgroundOpacity,
    this.shadowBuilder = _defaultShadowBuilder,
    this.singleShadow,

    this.splashScreen,
    this.wholeScreen = true,
  }): 
    assert(mainPages != null || controller != null),
    assert(extendedPanel != null || extendedPanelBuilder != null),
    super(key: key);

  // Content
  final Widget body;
  final Widget? collapsedPanel; //could be null
  final Widget? extendedPanel; //could be null if the builder is there
  final Widget Function(BuildContext, Animation)? extendedPanelBuilder;
  final StageTopBarContent topBarContent;

  //performance optimization
  final bool wholeScreen;
  // if true, the size of the mediaQuery is used instead of layout builder, which should greatly improve performance

  // Optional disk persistence
  final String? storeKey; /// Set if you want to save user changes to disk
  final T Function(dynamic)? jsonToMainPage; /// All these are optional if the pages are of an already jsonable type
  final S Function(dynamic)? jsonToPanelPage;
  final dynamic Function(T)? mainPageToJson;
  final dynamic Function(S)? panelPageToJson;

  /// Optional external controller
  final StageData<T,S>? controller;

  // Initial controller values (if not external controller)
  final StageThemeData<T,S>? stageTheme;
  final StagePagesData<T>? mainPages;
  final StagePagesData<S>? panelPages;
  final StageDimensions? dimensions;
  final StagePanelData? panelData; /// Could be null
  final StagePopBehavior? popBehavior; /// Could be null
  final void Function(T)? onMainPageChanged; /// Could be null

  // Appearance stuff
  final StageBackgroundGetter? backgroundColor;
  final double? backgroundOpacity;
  final StageShadowBuilder shadowBuilder; // Different shadow for each panel value (0=closed, 1=opened)
  final BoxShadow? singleShadow; // If you do not need to animate the shadow

  final Widget? splashScreen;




  //=================================
  // Default data
  static BoxShadow _defaultShadowBuilder(double panelVal, StageColorPlace place) => BoxShadow(
    blurRadius: DoubleExt.mapToRangeLoose( 
      //the value is provided already clamped
      panelVal,
      place.isTexts ? 4.0 : 8.0,
      place.isTexts ? 8.0 : 14.0,
    ),
    color: const Color(0x39000000),
    offset: const Offset(0,0.5),
  );
  // static const BoxShadow _defaultSingleShadow = BoxShadow(
  //   blurRadius: 6.0,
  //   color: Color(0x39000000),
  //   offset: Offset(0,0.5),
  // );





  @override
  Widget build(BuildContext context) {
    final ThemeData startingThemeData = Theme.of(context);
    final StageData? externalStageData = Stage.of(context);

    return _StageWithThemeAndExternalData<T,S>(
      startingThemeData: startingThemeData,
      externalStageData: (externalStageData is StageData<T,S>) ? externalStageData : null,
      storeKey: this.storeKey,
      controller: this.controller,
      mainPageToJson: this.mainPageToJson,
      jsonToMainPage: this.jsonToMainPage,
      panelPageToJson: this.panelPageToJson,
      jsonToPanelPage: this.jsonToPanelPage,
      stageTheme: this.stageTheme,
      mainPages: this.mainPages,
      panelPages: this.panelPages,
      dimensions: this.dimensions,
      panelData: this.panelData,
      onMainPageChanged: this.onMainPageChanged,
      popBehavior: this.popBehavior,

      body: body,
      collapsedPanel: collapsedPanel,
      extendedPanel: extendedPanel,
      extendedPanelBuilder: extendedPanelBuilder,
      topBarContent: topBarContent,

      backgroundColor: backgroundColor,
      backgroundOpacity: backgroundOpacity,
      shadowBuilder: shadowBuilder,
      singleShadow: singleShadow,

      splashScreen: splashScreen,

      wholeScreen: wholeScreen,
    );
  }



}
