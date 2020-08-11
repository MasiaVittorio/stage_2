part of stage;


class _StageThemeData<T,S> {

  //================================
  // Disposer
  void dispose(){
    backgroundColors?.dispose();
    textsColors?.dispose();
    brightness?.dispose();
    derived?.dispose();
  }


  //================================
  // Values

  final StageData<T,S> parent;

  _StageColorsData<T,S> backgroundColors;
  _StageColorsData<T,S> textsColors;
  _StageBrightnessData brightness;
  
  _StageDerivedThemeData<T,S> derived;

  //==> Type of theme
  final BlocVar<StageColorPlace> colorPlace;

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
    forceSystemNavBarStyle = initialData.forceSystemNavBarStyle,
    colorPlace = BlocVar.modal<StageColorPlace>(
      initVal: initialData.colorPlace,
      key: parent._getStoreKey("stage_theme_controller_themeType"), 
      toJson: (type) => type.name,
      fromJson: (name) => StageColorPlaces.fromName(name),
      readCallback: (_) => parent._readCallback("stage_theme_controller_themeType"),
      onChanged: (_) => parent.themeController.updateSystemNavBarStyle(),
    )
  {
    backgroundColors = _StageColorsData<T,S>(
      this,
      colorPlaceRef: StageColorPlace.background,
      initialData: initialData.backgroundColors,
    );
    textsColors = _StageColorsData<T,S>(
      this,
      colorPlaceRef: StageColorPlace.texts,
      initialData: initialData.textsColors,
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
    (this.backgroundColors?._isCurrentlyReading ?? true) ||
    (this.textsColors?._isCurrentlyReading ?? true) ||
    (this.brightness?._isCurrentlyReading ?? true)
  );

  _StageColorsData<T,S> get currentColorsController => colorPlace.value.isTexts
    ? this.textsColors
    : this.backgroundColors;


  StageThemeData<T,S> get extractData => StageThemeData<T,S>._(
    colorPlace: this.colorPlace.value,
    backgroundColors: this.backgroundColors.extractData,
    textsColors: this.textsColors.extractData,
    brightness: this.brightness.extractData,
    forceSystemNavBarStyle: this.forceSystemNavBarStyle,
    accentSelectedPage: this.accentSelectedPage,
    forcedPrimaryColorBrightnessOnDarkTheme: this.forcedPrimaryColorBrightnessOnDarkTheme,
    forcedPrimaryColorBrightnessOnLightTheme: this.forcedPrimaryColorBrightnessOnLightTheme,
    pandaOpenedPanelNavBar: this.pandaOpenedPanelNavBar,
  );




}