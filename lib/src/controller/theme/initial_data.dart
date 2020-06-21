part of stage;

class StageThemeData<T,S> {

  final StageColorsData<T,S> colors;
  final StageBrightnessData brightness;

  // Optional settings
  final bool forceSystemNavBarStyle;
  final bool accentSelectedPage;
  final Brightness forcedPrimaryColorBrightnessOnLightTheme; /// Could be null
  final Brightness forcedPrimaryColorBrightnessOnDarkTheme; /// Could be null
  final bool pandaOpenedPanelNavBar; /// If the opened panel's bottom bar should be of the same color of the top bar

  StageThemeData._({
    @required this.colors,
    @required this.brightness,
    @required bool forceSystemNavBarStyle,
    @required bool accentSelectedPage,
    @required this.forcedPrimaryColorBrightnessOnLightTheme, /// Could be null
    @required this.forcedPrimaryColorBrightnessOnDarkTheme, /// Could be null
    @required bool pandaOpenedPanelNavBar,
  }): forceSystemNavBarStyle = forceSystemNavBarStyle ?? _defaultForceSystemNavBarStyle,
      accentSelectedPage = accentSelectedPage ?? _defaultAccentSelectedPage,
      pandaOpenedPanelNavBar = pandaOpenedPanelNavBar ?? _defaultPandaOpenedPanelNavBar;

  StageThemeData.nullable({
    this.colors,
    this.brightness,
    this.forceSystemNavBarStyle,
    this.accentSelectedPage,
    this.forcedPrimaryColorBrightnessOnLightTheme,
    this.forcedPrimaryColorBrightnessOnDarkTheme,
    this.pandaOpenedPanelNavBar,
  });

  static StageThemeData<T,S> _fromThemeAndNullableData<T,S>(
    ThemeData theme, 
    StageThemeData<T,S> initialNullableData,
    {
      Iterable<T> allMainPagesToFill,
      Iterable<S> allPanelPagesToFill, /// Can be null
    }
  ) => StageThemeData<T,S>._(
    colors: StageColorsData._fromThemeAndNullableData<T,S>(
      theme, // can be null
      initialNullableData?.colors,

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
    forcedPrimaryColorBrightnessOnDarkTheme: initialNullableData?.forcedPrimaryColorBrightnessOnDarkTheme,
    forcedPrimaryColorBrightnessOnLightTheme: initialNullableData?.forcedPrimaryColorBrightnessOnLightTheme,
  ); 

  StageThemeData<T,S> get complete => _create<T,S>(
    allMainPagesToFill: null,
    allPanelPagesToFill: null,
    inheritedData: null,
    manualNullable: this,
    theme: null,
  );
  
  static StageThemeData<T,S> _create<T,S>({
    @required ThemeData theme,
    @required StageThemeData<T,S> inheritedData,
    @required StageThemeData<T,S> manualNullable,
    @required Iterable<T> allMainPagesToFill,
    @required Iterable<S> allPanelPagesToFill, // can be null
  }) => _fromThemeAndNullableData(
    theme, 
    manualNullable?.fillWith(inheritedData) ?? inheritedData,
    allMainPagesToFill: allMainPagesToFill,
    allPanelPagesToFill: allPanelPagesToFill,
  );
  

  //==================================
  // Getters
  StageThemeData<T,S> fillWith(StageThemeData<T,S> other) => StageThemeData<T,S>._(
    colors: this.colors?.fillWith(other?.colors) ?? other?.colors, 
    brightness: this.brightness?.fillWith(other?.brightness) ?? other?.brightness,
    forceSystemNavBarStyle: this.forceSystemNavBarStyle ?? other?.forceSystemNavBarStyle,
    forcedPrimaryColorBrightnessOnLightTheme: this.forcedPrimaryColorBrightnessOnLightTheme ?? other?.forcedPrimaryColorBrightnessOnLightTheme,
    forcedPrimaryColorBrightnessOnDarkTheme: this.forcedPrimaryColorBrightnessOnDarkTheme ?? other?.forcedPrimaryColorBrightnessOnDarkTheme,
    accentSelectedPage: this.accentSelectedPage ?? other?.accentSelectedPage,
    pandaOpenedPanelNavBar: this.pandaOpenedPanelNavBar ?? other?.pandaOpenedPanelNavBar,
  );
  


  //=====================================
  // Default Data
  static const bool _defaultForceSystemNavBarStyle = true;
  static const bool _defaultAccentSelectedPage = false;
  static const bool _defaultPandaOpenedPanelNavBar = true;



}