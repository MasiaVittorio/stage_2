part of stage;

class _StageDerivedThemeData<T,S> {

  //=========================================
  // Disposer
  void dispose(){
    accentColor.dispose();
    mainPageToPrimaryColor.dispose();
    _mainPrimaryColor.dispose();
    panelPageToPrimaryColor.dispose();
    _panelPrimaryColor.dispose();
    currentPrimaryColor.dispose();
    _lightThemeData.dispose();
    _darkThemeDatas.dispose();
    themeData.dispose();
  }
  

  //=========================================
  // Values
  final _StageThemeData<T,S> parent;

  late BlocVar<Color> accentColor;

  late BlocVar<Color> _mainPrimaryColor;
  late BlocVar<Map<T,Color>?> mainPageToPrimaryColor; /// Could be null
  late BlocVar<Color> _panelPrimaryColor;
  late BlocVar<Map<S,Color>?> panelPageToPrimaryColor; /// Could be null

  late BlocVar<Color> currentPrimaryColor;

  late BlocVar<ThemeData> _lightThemeData;
  late BlocVar<Map<DarkStyle,ThemeData>> _darkThemeDatas;
  late BlocVar<ThemeData> themeData;


  //=========================================
  // Constructor
  _StageDerivedThemeData(this.parent){

    accentColor = BlocVar.fromCorrelateLatest7<
      Color, 
      Brightness, DarkStyle, 
      StageColorPlace,
      Color, Map<DarkStyle,Color>, 
      Color, Map<DarkStyle,Color>
    >(
      parent.brightness.brightness, 
      parent.brightness.darkStyle, 
      parent.colorPlace,
      parent.backgroundColors.lightAccent, 
      parent.backgroundColors.darkAccents, 
      parent.textsColors.lightAccent, 
      parent.textsColors.darkAccents, 
      map: _currentWithBrightnessAndPlace<Color>,
    );

    _mainPrimaryColor = BlocVar.fromCorrelateLatest7<
      Color, 
      Brightness, DarkStyle, 
      StageColorPlace,
      Color, Map<DarkStyle,Color>, 
      Color, Map<DarkStyle,Color>
    >(
      parent.brightness.brightness, 
      parent.brightness.darkStyle, 
      parent.colorPlace,
      parent.backgroundColors.lightMainPrimary, 
      parent.backgroundColors.darkMainPrimaries, 
      parent.textsColors.lightMainPrimary, 
      parent.textsColors.darkMainPrimaries, 
      map: _currentWithBrightnessAndPlace<Color>,
    );
    
    _panelPrimaryColor = BlocVar.fromCorrelateLatest7<
      Color, 
      Brightness, DarkStyle, 
      StageColorPlace,
      Color, Map<DarkStyle,Color>, 
      Color, Map<DarkStyle,Color> 
    >(
      parent.brightness.brightness, 
      parent.brightness.darkStyle, 
      parent.colorPlace,
      parent.backgroundColors.lightPanelPrimary, 
      parent.backgroundColors.darkPanelPrimaries, 
      parent.textsColors.lightPanelPrimary, 
      parent.textsColors.darkPanelPrimaries, 
      map: _currentWithBrightnessAndPlace<Color>,
    );
    
    mainPageToPrimaryColor = BlocVar.fromCorrelateLatest7<
      Map<T,Color>?, 
      Brightness, DarkStyle, 
      StageColorPlace,
      Map<T,Color>?, Map<DarkStyle,Map<T,Color>>?, 
      Map<T,Color>?, Map<DarkStyle,Map<T,Color>>? 
    >(
      parent.brightness.brightness, 
      parent.brightness.darkStyle, 
      parent.colorPlace,
      parent.backgroundColors.lightMainPageToPrimary, 
      parent.backgroundColors.darkMainPageToPrimaries,
      parent.textsColors.lightMainPageToPrimary, 
      parent.textsColors.darkMainPageToPrimaries, 
      map: _currentWithBrightnessAndPlaceNullable<Map<T,Color>?>,
      equals: (f,s) => _StageUtils._compareMaps<T,Color>(f, s),
      copier: (m) => m==null ? null : Map<T,Color>.from(m),
    );

    panelPageToPrimaryColor = BlocVar.fromCorrelateLatest7<
      Map<S,Color>?, 
      Brightness, DarkStyle, 
      StageColorPlace,
      Map<S,Color>?, Map<DarkStyle,Map<S,Color>>?, 
      Map<S,Color>?, Map<DarkStyle,Map<S,Color>>? 
    >(
      parent.brightness.brightness, 
      parent.brightness.darkStyle, 
      parent.colorPlace,
      parent.backgroundColors.lightPanelPageToPrimary,
      parent.backgroundColors.darkPanelPageToPrimaries,
      parent.textsColors.lightPanelPageToPrimary, 
      parent.textsColors.darkPanelPageToPrimaries, 
      map: _currentWithBrightnessAndPlaceNullable<Map<S,Color>?>,
      equals: (f,s) => _StageUtils._compareMaps<S?,Color?>(f, s),
      copier: (m) => m==null ? null : Map<S,Color>.from(m),
    );

    currentPrimaryColor = BlocVar.fromCorrelateLatest7<
      Color,   bool,T,S?,Color,Map<T,Color>?,Color,Map<S,Color>?
    >(
      parent.parent.panelController.isMostlyOpenedNonAlert, 
      parent.parent.mainPagesController._page,
      parent.parent.panelPagesController?._page ?? BlocVar(null), /// The whole controller could be null 
      _mainPrimaryColor, 
      mainPageToPrimaryColor, 
      _panelPrimaryColor, 
      panelPageToPrimaryColor,     //panel page could be null
      map: (openNonAlert, mainPage, panelPage, main, pagedMain, panel, pagedPanel)  
        => _currentWithPanelAndPages<Color?,T?,S?>(
          openNonAlert, mainPage, panelPage, main, pagedMain, panel, pagedPanel
        )!,
      onChanged: (newColor) => parent.updateSystemNavBarStyle(),
    );

    _darkThemeDatas = BlocVar.fromCorrelateLatest5<
      Map<DarkStyle,ThemeData>, 
      Map<DarkStyle?,Color?>?, Map<DarkStyle?,Color?>?,
      Map<DarkStyle?,Color?>?, Map<DarkStyle?,Color?>?,
      StageColorPlace?
    >(
      parent.backgroundColors.darkAccents, 
      parent.backgroundColors.darkMainPrimaries, 
      parent.textsColors.darkAccents, 
      parent.textsColors.darkMainPrimaries, 
      parent.colorPlace,
      map: (backAccents, backPrimaries, textsAccents, textsPrimaries, colorPlace) => <DarkStyle,ThemeData>{
        for(final style in DarkStyle.values)
          style: StageThemeUtils.getThemeData(
            brightness: Brightness.dark, 
            darkStyle: style, 
            primary: colorPlace.isTexts ? textsPrimaries![style]! : backPrimaries![style]!, 
            accent: colorPlace.isTexts ? textsAccents![style]! : backAccents![style]!, 
          ),
      }
    );

    _lightThemeData = BlocVar.fromCorrelateLatest5<
      ThemeData, 
      Color?, Color?,
      Color?, Color?,
      StageColorPlace?
    >(
      parent.backgroundColors.lightAccent, 
      parent.backgroundColors.lightMainPrimary, 
      parent.textsColors.lightAccent, 
      parent.textsColors.lightMainPrimary, 
      parent.colorPlace,
      map: (backAccent, backPrimary, textsAccent, textsPrimary, colorPlace) => StageThemeUtils.getThemeData(
        brightness: Brightness.light, 
        darkStyle: null, 
        primary: colorPlace.isTexts ? textsPrimary! : backPrimary!, 
        accent: colorPlace.isTexts ? textsAccent! : backAccent!, 
      ),
    );

    themeData = BlocVar.fromCorrelateLatest4<
      ThemeData,  Brightness?, DarkStyle, ThemeData, Map<DarkStyle,ThemeData>
    >(
      parent.brightness.brightness,
      parent.brightness.darkStyle,
      _lightThemeData,
      _darkThemeDatas,
      map: (brightness, style, light, darks) 
        => _currentWithBrightness<ThemeData>(brightness!, style, light, darks),
    );


  }


  //===========================================
  // Maps

  static A _currentWithBrightnessAndPlace<A>(
    Brightness brightness, DarkStyle style, StageColorPlace place, 
    A backgroundLight, Map<DarkStyle,A> backgroundDarks,
    A textsLight, Map<DarkStyle,A> textsDarks,
  ){
    if(brightness.isDark){
      if(place.isTexts){
        return textsDarks[style]!;
      } else {
        return backgroundDarks[style]!;
      }
    } else {
      if(place.isTexts){
        return textsLight;
      } else {
        return backgroundLight;
      }
    }
  }

  static A? _currentWithBrightnessAndPlaceNullable<A>(
    Brightness brightness, DarkStyle style, StageColorPlace place, 
    A? backgroundLight, Map<DarkStyle,A>? backgroundDarks,
    A? textsLight, Map<DarkStyle,A>? textsDarks,
  ){
    if(brightness.isDark){
      if(place.isTexts){
        return textsDarks?[style]!;
      } else {
        return backgroundDarks?[style]!;
      }
    } else {
      if(place.isTexts){
        return textsLight;
      } else {
        return backgroundLight;
      }
    }
  }

  static A _currentWithBrightness<A>(
    Brightness brightness, DarkStyle style, 
    A light, Map<DarkStyle,A> darks,
  ){
    if(brightness.isDark){
      return darks[style] ?? light;
    } else {
      return light;
    }
  }

  static A _currentWithPanelAndPages<A,T,S>(
    bool openNonAlert, 
    T mainPage, 
    S panelPage, // Could be null if panel does not have pages 
    A main, Map<T,A>? pagedMain, 
    A panel, Map<S,A>? pagedPanel
  ) => openNonAlert 
    ? pagedPanel != null && panelPage != null
      ? pagedPanel[panelPage] ?? panel
      : panel
    : pagedMain != null 
      ? pagedMain[mainPage] ?? main
      : main;

} 