part of stage;


class _StageWithThemeAndExternalData<T,S> extends StatefulWidget {
  const _StageWithThemeAndExternalData({
    Key key,
    @required this.externalStageData,
    @required this.startingThemeData,
    @required this.storeKey,
    @required this.controller,

    @required this.mainPageToJson,
    @required this.jsonToMainPage,
    @required this.panelPageToJson,
    @required this.jsonToPanelPage,

    @required this.stageTheme,
    @required this.mainPages,
    @required this.panelPages,
    @required this.dimensions,
    @required this.panelData, /// Could be null
    @required this.popBehavior,
    @required this.onMainPageChanged,

    //content
    @required this.body,
    @required this.collapsedPanel,
    @required this.extendedPanel,
    @required this.topBarData,

    //theming
    @required this.shadowBuilder,
    @required this.singleShadow,
    @required this.backgroundColor,
    @required this.backgroundOpacity,

    //splash screen stuff
    @required this.splashScreen,

    @required this.wholeScreen,
  }): 
    // assert(extendedPanel != null),
    // assert(closedPanelTreshold < openedPanelTreshold),
      super(key: key);

  /// Inherited 
  final ThemeData startingThemeData;
  final StageData<T,S> externalStageData;

  /// Optional persistence 
  final String storeKey;

  /// Controller
  final StageData<T,S> controller;

  //performance optimization
  final bool wholeScreen;
  // if true, the size of the mediaQuery is used instead of layout builder, which should greatly improve performance

  /// Initial controller values (nullables)
  final T Function(dynamic) jsonToMainPage;
  final S Function(dynamic) jsonToPanelPage;
  final dynamic Function(T) mainPageToJson;
  final dynamic Function(S) panelPageToJson;
  final StageThemeData<T,S> stageTheme;
  final StagePagesData<T> mainPages;
  final StagePagesData<S> panelPages;
  final StageDimensions dimensions;
  final StagePanelData panelData; /// Could be null
  final StagePopBehavior popBehavior; /// Could be null
  final void Function(T) onMainPageChanged; /// Could be null

  // Content
  final Widget body;
  final Widget collapsedPanel; //could be null, but why should it?
  final Widget extendedPanel;
  final StageTopBarData topBarData; // not stored in the controller


  // Theming
  final Color Function(ThemeData) backgroundColor;
  final double backgroundOpacity;
  final BoxShadow Function(double) shadowBuilder; // Different shadow for each panel value (0=closed, 1=opened)
  final BoxShadow singleShadow; // If you do not need to animate the shadow

  final Widget splashScreen;



  @override
  _StageWithThemeAndExternalDataState<T,S> createState() => _StageWithThemeAndExternalDataState<T,S>();
}

