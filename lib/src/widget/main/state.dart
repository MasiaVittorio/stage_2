part of stage;



class _StageWithThemeAndExternalDataState<T,S> extends State<_StageWithThemeAndExternalData<T?,S?>> {
  StageData<T?,S?>? controller;

  @override
  void initState() {
    super.initState();
    if(widget.controller != null){
      controller = widget.controller;
    } else {
      final StageData<T?,S?>? inherited = widget.externalStageData;
      final StageThemeData<T?,S?>? externalTheme = inherited?.themeController.extractData;

      final StagePagesData<T?> mainPages = StagePagesData._create<T?>(
        manualNullable: widget.mainPages,
        inheritedData: inherited?.mainPagesController.extractData, 
      )!;
      final StagePagesData<S?>? panelPages = StagePagesData._create<S?>(
        manualNullable: widget.panelPages, /// Can be null
        inheritedData: inherited?.panelPagesController?.extractData, 
      );

      controller = StageData<T?,S?>(
        storeKey: widget.storeKey,
        mainPageToJson: widget.mainPageToJson,
        jsonToMainPage: widget.jsonToMainPage,
        panelPageToJson: widget.panelPageToJson,
        jsonToPanelPage: widget.jsonToPanelPage,

        initialDimensions: widget.dimensions ?? inherited?.dimensionsController.dimensions.value, // Could be null
        initialMainPagesData: mainPages,
        initialPanelPagesData: panelPages, /// Can be null
        initialThemeData: StageThemeData._create<T?,S?>(
          theme: widget.startingThemeData,
          manualNullable: widget.stageTheme,
          inheritedData: externalTheme, // can be null
          allMainPagesToFill: mainPages._allKeys,
          allPanelPagesToFill: panelPages?._allKeys, // can be null
        ),
        panelData: widget.panelData,
        popBehavior: widget.popBehavior, /// Can be null
        onMainPageChanged: widget.onMainPageChanged,
      );
    }

  }

  bool get externalController => widget.controller != null;

  @override
  void dispose() {
    if(!externalController){
      controller?.dispose();
    }
    super.dispose();
  }


  @override
  Widget build(BuildContext context){
    return StageProvider(
      data: controller,
      child: _StageContent(
        data: this.controller, 

        body: widget.body, 
        collapsedPanel: widget.collapsedPanel, 
        extendedPanel: widget.extendedPanel,
        extendedPanelBuilder: widget.extendedPanelBuilder,
        topBarBuilder: (animation) => _TopBar<T,S>(
          animation: animation, 
          openedPanelSubtitle: widget.topBarContent.subtitle,
          alignment: widget.topBarContent.alignment,
          appBarTitle: widget.topBarContent.title,
        ),

        shadowBuilder: widget.shadowBuilder,
        singleShadow: widget.singleShadow,
        backgroundColor: widget.backgroundColor,
        backgroundOpacity: widget.backgroundOpacity,

        splashScreen: widget.splashScreen,

        wholeScreen: widget.wholeScreen,
      ),
    );
  }
}
