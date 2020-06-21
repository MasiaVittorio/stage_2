part of stage;


class _StageThemeData<T,S> {

  //================================
  // Disposer
  void dispose(){
    colors?.dispose();
    brightness?.dispose();
    derived?.dispose();
  }


  //================================
  // Values

  final StageData<T,S> parent;

  _StageColorsData<T,S> colors;
  _StageBrightnessData brightness;
  
  _StageDerivedThemeData<T,S> derived;

  // Optional settings
  final Brightness forcedPrimaryColorBrightnessOnLightTheme; /// Could be null
  final Brightness forcedPrimaryColorBrightnessOnDarkTheme; /// Could be null
  final bool accentSelectedPage;
  final bool pandaOpenedPanelNavBar; /// If the opened panel's bottom bar should be of the same color of the top bar
  final bool forceSystemNavBarStyle; /// Wether the system nav bar should be colored as the stage's nav bar
  

  //================================
  // Constructor
  _StageThemeData(this.parent, {
    @required StageThemeData<T,S> initialData,
  }): 
    assert(initialData != null),
    forcedPrimaryColorBrightnessOnLightTheme = initialData.forcedPrimaryColorBrightnessOnLightTheme,
    forcedPrimaryColorBrightnessOnDarkTheme = initialData.forcedPrimaryColorBrightnessOnDarkTheme,
    accentSelectedPage = initialData.accentSelectedPage,
    pandaOpenedPanelNavBar = initialData.pandaOpenedPanelNavBar,
    forceSystemNavBarStyle = initialData.forceSystemNavBarStyle
  {
    colors = _StageColorsData<T,S>(
      this,
      initialData: initialData.colors,
    );
    brightness = _StageBrightnessData(
      this, 
      initialData: initialData.brightness,
    );
    derived = _StageDerivedThemeData<T,S>(this);
  } 
    

  //===============================
  // Getters
  bool get _isCurrentlyReading => this.parent.storeKey != null && (
    (this.colors?._isCurrentlyReading ?? true) ||
    (this.brightness?._isCurrentlyReading ?? true)
  );


  StageThemeData<T,S> get extractData => StageThemeData<T,S>._(
    colors: this.colors.extractData,
    brightness: this.brightness.extractData,
    forceSystemNavBarStyle: this.forceSystemNavBarStyle,
    accentSelectedPage: this.accentSelectedPage,
    forcedPrimaryColorBrightnessOnDarkTheme: this.forcedPrimaryColorBrightnessOnDarkTheme,
    forcedPrimaryColorBrightnessOnLightTheme: this.forcedPrimaryColorBrightnessOnLightTheme,
    pandaOpenedPanelNavBar: this.pandaOpenedPanelNavBar,
  );




}