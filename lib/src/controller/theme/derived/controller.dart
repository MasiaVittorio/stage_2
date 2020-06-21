part of stage;

class _StageDerivedThemeData<T,S> {

  //=========================================
  // Disposer
  void dispose(){
    accentColor?.dispose();
    mainPageToPrimaryColor?.dispose();
    _mainPrimaryColor?.dispose();
    panelPageToPrimaryColor?.dispose();
    _panelPrimaryColor?.dispose();
    currentPrimaryColor?.dispose();
    _lightThemeData?.dispose();
    _darkThemeDatas?.dispose();
    themeData?.dispose();
    forcedPrimaryColorBrightness?.dispose();
  }
  

  //=========================================
  // Values
  final _StageThemeData<T,S> parent;

  BlocVar<Color> accentColor;

  BlocVar<Color> _mainPrimaryColor;
  BlocVar<Map<T,Color>> mainPageToPrimaryColor; /// Could be null
  BlocVar<Color> _panelPrimaryColor;
  BlocVar<Map<S,Color>> panelPageToPrimaryColor; /// Could be null

  BlocVar<Color> currentPrimaryColor;

  BlocVar<ThemeData> _lightThemeData;
  BlocVar<Map<DarkStyle,ThemeData>> _darkThemeDatas;
  BlocVar<ThemeData> themeData;

  BlocVar<Brightness> forcedPrimaryColorBrightness;


  //=========================================
  // Constructor
  _StageDerivedThemeData(this.parent){

    accentColor = BlocVar.fromCorrelateLatest4<
      Color,  Brightness, DarkStyle, Color, Map<DarkStyle,Color>
    >(
      parent.brightness.brightness, 
      parent.brightness.darkStyle, 
      parent.colors.lightAccent, 
      parent.colors.darkAccents, 
      map: (brightness, style, light, darks) 
        => _currentWithBrightness<Color>(brightness, style, light, darks)
          ?? StageDefaultColors.accent,
    );

    _mainPrimaryColor = BlocVar.fromCorrelateLatest4<
      Color,  Brightness, DarkStyle, Color, Map<DarkStyle,Color>
    >(
      parent.brightness.brightness, 
      parent.brightness.darkStyle, 
      parent.colors.lightMainPrimary, 
      parent.colors.darkMainPrimaries, 
      map: (brightness, style, light, darks) 
        => _currentWithBrightness<Color>(brightness, style, light, darks)
          ?? StageDefaultColors.primary,
    );

    _panelPrimaryColor = BlocVar.fromCorrelateLatest4<
      Color,  Brightness, DarkStyle, Color, Map<DarkStyle,Color>
    >(
      parent.brightness.brightness, 
      parent.brightness.darkStyle, 
      parent.colors.lightPanelPrimary, 
      parent.colors.darkPanelPrimaries, 
      map: (brightness, style, light, darks) 
        => _currentWithBrightness<Color>(brightness, style, light, darks)
          ?? StageDefaultColors.primary,
    );

    mainPageToPrimaryColor = BlocVar.fromCorrelateLatest4<
      Map<T,Color>,  Brightness, DarkStyle, Map<T,Color>, Map<DarkStyle,Map<T,Color>>
    >(
      parent.brightness.brightness, 
      parent.brightness.darkStyle, 
      parent.colors.lightMainPageToPrimary, 
      parent.colors.darkMainPageToPrimaries, 
      map: (brightness, style, light, darks) 
        => _currentWithBrightness<Map<T,Color>>(brightness, style, light, darks),
          /// could be null
      equals: (f,s) => _StageUtils._compareMaps<T,Color>(f, s),
      copier: (m) => Map<T,Color>.from(m),
    );

    panelPageToPrimaryColor = BlocVar.fromCorrelateLatest4<
      Map<S,Color>,  Brightness, DarkStyle, Map<S,Color>, Map<DarkStyle,Map<S,Color>>
    >(
      parent.brightness.brightness, 
      parent.brightness.darkStyle, 
      parent.colors.lightPanelPageToPrimary, 
      parent.colors.darkPanelPageToPrimaries, 
      map: (brightness, style, light, darks) 
        => _currentWithBrightness<Map<S,Color>>(brightness, style, light, darks),
          /// could be null
      equals: (f,s) => _StageUtils._compareMaps<S,Color>(f, s),
      copier: (m) => Map<S,Color>.from(m),
    );

    currentPrimaryColor = BlocVar.fromCorrelateLatest7<
      Color,   bool,T,S,Color,Map<T,Color>,Color,Map<S,Color>
    >(
      parent.parent.panelController.isMostlyOpenedNonAlert, 
      parent.parent.mainPagesController._page,
      parent.parent.panelPagesController?._page ?? BlocVar(null), /// The whole controller could be null 
      _mainPrimaryColor, 
      mainPageToPrimaryColor, 
      _panelPrimaryColor, 
      panelPageToPrimaryColor,     //panel page could be null
      map: (openNonAlert, mainPage, panelPage, main, pagedMain, panel, pagedPanel)  
        => _currentWithPanelAndPages<Color,T,S>(openNonAlert, mainPage, panelPage, main, pagedMain, panel, pagedPanel),
      onChanged: (newColor) => parent.colors.updateSystemNavBarStyle(newColor),
    );

    _darkThemeDatas = BlocVar.fromCorrelateLatest2<
      Map<DarkStyle,ThemeData>,  Map<DarkStyle,Color>, Map<DarkStyle,Color>
    >(
      parent.colors.darkAccents, 
      parent.colors.darkMainPrimaries, 
      map: (mapAccents, mapPrimaries) => <DarkStyle,ThemeData>{
        for(final style in DarkStyle.values)
          style: StageThemeUtils.getThemeData(
            brightness: Brightness.dark, 
            darkStyle: style, 
            primary: mapPrimaries[style], 
            accent: mapAccents[style], 
            forcedPrimaryColorBrightness: parent.forcedPrimaryColorBrightnessOnDarkTheme,
          ),
      }
    );

    _lightThemeData = BlocVar.fromCorrelateLatest2<
      ThemeData,  Color, Color
    >(
      parent.colors.lightAccent,
      parent.colors.lightMainPrimary,
      map: (accent,primary) => StageThemeUtils.getThemeData(
        brightness: Brightness.light, 
        darkStyle: null, 
        primary: primary, 
        accent: accent, 
        forcedPrimaryColorBrightness: parent.forcedPrimaryColorBrightnessOnLightTheme,
      ),
    );

    themeData = BlocVar.fromCorrelateLatest4<
      ThemeData,  Brightness, DarkStyle, ThemeData, Map<DarkStyle,ThemeData>
    >(
      parent.brightness.brightness,
      parent.brightness.darkStyle,
      this._lightThemeData,
      this._darkThemeDatas,
      map: (brightness, style, light, darks) 
        => _currentWithBrightness<ThemeData>(brightness, style, light, darks),
    );

    forcedPrimaryColorBrightness = BlocVar.fromCorrelate<Brightness,Brightness>(
      from: parent.brightness.brightness, 
      map: (b) => b.isLight 
        ? parent.forcedPrimaryColorBrightnessOnLightTheme 
        : parent.forcedPrimaryColorBrightnessOnDarkTheme,
    );

  }


  //===========================================
  // Maps

  static A _currentWithBrightness<A>(Brightness brightness, DarkStyle style, A light, Map<DarkStyle,A> darks){
    if(brightness == Brightness.dark){
      if(darks == null) return null;
      else return darks[style];
    } else {
      return light;
    }
  }

  static A _currentWithPanelAndPages<A,T,S>(
    bool openNonAlert, 
    T mainPage, 
    S panelPage, // Could be null if panel does not have pages 
    A main, Map<T,A> pagedMain, 
    A panel, Map<S,A> pagedPanel
  ) => openNonAlert 
    ? pagedPanel != null && panelPage != null
      ? pagedPanel[panelPage]
      : panel
    : pagedMain != null 
      ? pagedMain[mainPage]
      : main;

} 