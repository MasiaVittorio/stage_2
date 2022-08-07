part of stage;

class StageThemeData<T,S> {

  final StageColorsData<T,S>? textsColors;
  final StageColorsData<T,S>? backgroundColors;
  final StageBrightnessData? brightness;

  // type of theme
  final StageColorPlace? colorPlace;
  static const StageColorPlace defaultColorPlace = StageColorPlace.background;
  final Map<StageColorPlace,double>? topBarElevations;
  final bool? bottomBarShadow;

  // Optional settings
  final bool? forceSystemNavBarStyle;
  final bool? accentSelectedPage;
  final bool? pandaOpenedPanelNavBar; /// If the opened panel's bottom bar should be of the same color of the top bar

  StageThemeData._({
    required StageColorPlace? colorPlace, // if null, backgrounds
    required Map<StageColorPlace,double>? topBarElevations, // if null, defaults
    required bool? bottomBarShadow, //if null, true
    required this.backgroundColors,
    required StageColorsData<T,S>? textsColors,
    required this.brightness,
    required bool? forceSystemNavBarStyle,
    required bool? accentSelectedPage,
    required bool? pandaOpenedPanelNavBar,
  }): forceSystemNavBarStyle = forceSystemNavBarStyle ?? _defaultForceSystemNavBarStyle,
      accentSelectedPage = accentSelectedPage ?? _defaultAccentSelectedPage,
      textsColors = textsColors ?? backgroundColors,
      colorPlace = colorPlace ?? defaultColorPlace, 
      topBarElevations = topBarElevations ?? defaultTopBarElevations,
      bottomBarShadow = bottomBarShadow ?? defaultBottomBarShadow,
      pandaOpenedPanelNavBar = pandaOpenedPanelNavBar ?? _defaultPandaOpenedPanelNavBar;

  StageThemeData.nullable({
    this.backgroundColors, // for when the colors are applied to the material
    this.textsColors, // for when you use the google like style: if null, background colors are used
    this.brightness,
    this.forceSystemNavBarStyle,
    this.accentSelectedPage,
    this.pandaOpenedPanelNavBar,
    this.colorPlace, // if null, backgrounds
    this.topBarElevations, // if null, defaults
    this.bottomBarShadow,
  });

  static StageThemeData<T,S> _fromThemeAndNullableData<T,S>(
    ThemeData? theme, 
    StageThemeData<T,S>? initialNullableData,
    {
      Iterable<T>? allMainPagesToFill,
      Iterable<S>? allPanelPagesToFill, /// Can be null
    }
  ) => StageThemeData<T,S>._(
    colorPlace: initialNullableData?.colorPlace, // if null, backgrounds
    topBarElevations: initialNullableData?.topBarElevations,
    bottomBarShadow: initialNullableData?.bottomBarShadow,
    backgroundColors: StageColorsData._fromThemeAndNullableData<T,S>(
      theme, // can be null
      initialNullableData?.backgroundColors,

      allMainPagesToFill: allMainPagesToFill,
      allPanelPagesToFill: allPanelPagesToFill,
    ),
    textsColors: StageColorsData._fromThemeAndNullableData<T,S>(
      theme, // can be null
      initialNullableData?.textsColors ?? initialNullableData?.backgroundColors,

      allMainPagesToFill: allMainPagesToFill,
      allPanelPagesToFill: allPanelPagesToFill,
    ),
    brightness: StageBrightnessData._fromThemeAndNullableData(
      theme,
      initialNullableData?.brightness,
    ),
    pandaOpenedPanelNavBar: initialNullableData?.pandaOpenedPanelNavBar,
    forceSystemNavBarStyle: initialNullableData?.forceSystemNavBarStyle,
    accentSelectedPage: initialNullableData?.accentSelectedPage,
  ); 

  StageThemeData<T,S> get complete => _create<T,S>(
    allMainPagesToFill: null,
    allPanelPagesToFill: null,
    inheritedData: null,
    manualNullable: this,
    theme: null,
  );
  
  static StageThemeData<T,S> _create<T,S>({
    required ThemeData? theme,
    required StageThemeData<T,S>? inheritedData,
    required StageThemeData<T,S>? manualNullable,
    required Iterable<T>? allMainPagesToFill,
    required Iterable<S>? allPanelPagesToFill, // can be null
  }) => _fromThemeAndNullableData(
    theme, 
    manualNullable?.fillWith(inheritedData) ?? inheritedData,
    allMainPagesToFill: allMainPagesToFill,
    allPanelPagesToFill: allPanelPagesToFill,
  );
  

  //==================================
  // Getters
  StageThemeData<T,S> fillWith(StageThemeData<T,S>? other) => StageThemeData<T,S>._(
    colorPlace: colorPlace ?? other?.colorPlace,
    topBarElevations: topBarElevations ?? other?.topBarElevations,
    bottomBarShadow: bottomBarShadow ?? other?.bottomBarShadow,
    backgroundColors: backgroundColors?.fillWith(other?.backgroundColors) ?? other?.backgroundColors, 
    textsColors: textsColors?.fillWith(other?.textsColors) ?? other?.textsColors, 
    brightness: brightness?.fillWith(other?.brightness) ?? other?.brightness,
    forceSystemNavBarStyle: forceSystemNavBarStyle ?? other?.forceSystemNavBarStyle,
    accentSelectedPage: accentSelectedPage ?? other?.accentSelectedPage,
    pandaOpenedPanelNavBar: pandaOpenedPanelNavBar ?? other?.pandaOpenedPanelNavBar,
  );
  


  //=====================================
  // Default Data
  static const bool _defaultForceSystemNavBarStyle = true;
  static const bool _defaultAccentSelectedPage = false;
  static const bool _defaultPandaOpenedPanelNavBar = true;

  static const Map<StageColorPlace,double> defaultTopBarElevations = 
    <StageColorPlace,double>{
      StageColorPlace.texts: 4,
      StageColorPlace.background: 8,
    };

  static const bool defaultBottomBarShadow = true;


}