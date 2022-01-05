part of stage;


class _StageThemeData<T,S> {

  //================================
  // Disposer
  void dispose(){
    backgroundColors.dispose();
    textsColors.dispose();
    brightness.dispose();
    derived.dispose();
  }


  //================================
  // Values

  final StageData<T,S> parent;

  late _StageColorsData<T,S> backgroundColors;
  late _StageColorsData<T,S> textsColors;
  late _StageBrightnessData brightness;
  
  late _StageDerivedThemeData<T,S> derived;

  //==> Type of theme
  final BlocVar<StageColorPlace> colorPlace;
  final BlocVar<Map<StageColorPlace,double>?> topBarElevations;
  final BlocVar<bool> bottomBarShadow;

  // Optional settings
  final bool accentSelectedPage;
  final bool? pandaOpenedPanelNavBar; /// If the opened panel's bottom bar should be of the same color of the top bar
  final bool? forceSystemNavBarStyle; /// Wether the system nav bar should be colored as the stage's nav bar
  

  //================================
  // Constructor
  _StageThemeData(this.parent, {
    required StageThemeData<T,S> initialData,
  }): 
    accentSelectedPage = initialData.accentSelectedPage!,
    pandaOpenedPanelNavBar = initialData.pandaOpenedPanelNavBar,
    forceSystemNavBarStyle = initialData.forceSystemNavBarStyle,
    colorPlace = BlocVar.modal<StageColorPlace>(
      initVal: initialData.colorPlace ?? StageColorPlace.background,
      key: parent._getStoreKey("stage_theme_controller_themeType"), 
      toJson: (type) => type.name,
      fromJson: (name) => StageColorPlaces.fromName(name),
      readCallback: (_) => parent._readCallback("stage_theme_controller_themeType"),
      onChanged: (_) => parent.themeController.updateSystemNavBarStyle(),
    ),
    bottomBarShadow = BlocVar.modal<bool>(
      initVal: initialData.bottomBarShadow ?? StageThemeData.defaultBottomBarShadow,
      key: parent._getStoreKey("stage_theme_controller_bottomBarShadow"), 
      readCallback: (_) => parent._readCallback("stage_theme_controller_BottomBarShadow"),
    ),
    topBarElevations = BlocVar.modal<Map<StageColorPlace,double>?>(
      initVal: initialData.topBarElevations,
      key: parent._getStoreKey("stage_theme_controller_topBarElevations"), 
      toJson: (map) => <String?,double>{
        for(final e in map!.entries)
          e.key.name: e.value,
      },
      fromJson: (json) => <StageColorPlace,double>{
        for(final e in (json as Map).entries)
          StageColorPlaces.fromName(e.key): e.value,
      },
      readCallback: (_) => parent._readCallback("stage_theme_controller_topBarElevations"),
    )
  {
    backgroundColors = _StageColorsData<T,S>(
      this,
      colorPlaceRef: StageColorPlace.background,
      initialData: initialData.backgroundColors!,
    );
    textsColors = _StageColorsData<T,S>(
      this,
      colorPlaceRef: StageColorPlace.texts,
      initialData: initialData.textsColors!,
    );
    brightness = _StageBrightnessData(
      this, 
      initialData: initialData.brightness!,
    );
    derived = _StageDerivedThemeData<T,S>(this);
  } 
    

  //===============================
  // Getters
  bool get _isCurrentlyReading => this.parent.storeKey != null && (
    this.backgroundColors._isCurrentlyReading ||
    this.textsColors._isCurrentlyReading ||
    this.brightness._isCurrentlyReading ||
    this.colorPlace.modalReading ||
    this.topBarElevations.modalReading ||
    this.bottomBarShadow.modalReading 
  );

  _StageColorsData<T,S>? get currentColorsController => colorPlace.value.isTexts
    ? this.textsColors
    : this.backgroundColors;


  StageThemeData<T,S> get extractData => StageThemeData<T,S>._(
    colorPlace: this.colorPlace.value,
    topBarElevations: this.topBarElevations.value,
    backgroundColors: this.backgroundColors.extractData,
    textsColors: this.textsColors.extractData,
    brightness: this.brightness.extractData,
    forceSystemNavBarStyle: this.forceSystemNavBarStyle,
    accentSelectedPage: this.accentSelectedPage,
    pandaOpenedPanelNavBar: this.pandaOpenedPanelNavBar,
    bottomBarShadow: this.bottomBarShadow.value,
  );




}