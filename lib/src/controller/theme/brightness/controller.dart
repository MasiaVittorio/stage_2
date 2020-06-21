part of stage;


class _StageBrightnessData {
  //================================
  // Disposer
  void dispose(){
    brightness?.dispose();
    darkStyle?.dispose();
    autoDark?.dispose();
    autoDarkMode?.dispose();
  }

  //================================
  // Values
  final _StageThemeData parent;

  //============================================
  // Actual State
  final BlocVar<Brightness> brightness;
  final BlocVar<DarkStyle> darkStyle;

  //============================================
  // Behavior (pseudo state, provide mediaquery to update manually)
  final BlocVar<bool> autoDark;
  final BlocVar<AutoDarkMode> autoDarkMode;
  ///wether the automatic light/dark switch has to be decided upon time
  ///  of day (current hour between 7 and 20) or system's mediaquery -> preferred brightness


  //===============================
  // Constructor
  _StageBrightnessData(this.parent, {
    @required StageBrightnessData initialData,
  }): 
    brightness = BlocVar.modal<Brightness>(
      initVal: initialData.brightness,
      key: parent.parent._getStoreKey("stage_brightness_brightness"), 
      toJson: (b) => b.name,
      fromJson: (j) => _Brightness.fromName(j as String),
      readCallback: (_) => parent.parent._readCallback("stage_brightness_brightness"),
    ),
    autoDark = BlocVar.modal<bool>(
      initVal: initialData.autoDark,
      key: parent.parent._getStoreKey("stage_brightness_aautoDark"), 
      toJson: (b) => b,
      fromJson: (j) => j as bool,
      readCallback: (_) => parent.parent._readCallback("stage_brightness_aautoDark"),
      //WARNING: this read callback is never called, cannot figure out why the fuck
    ),
    autoDarkMode = BlocVar.modal<AutoDarkMode>(
      initVal: initialData.autoDarkMode,
      key: parent.parent._getStoreKey("stage_brightness_autoDarkMode"), 
      toJson: (auto) => auto.name,
      fromJson: (j) => _AutoDarkMode.fromName(j as String),
      readCallback: (_) => parent.parent._readCallback("stage_brightness_autoDarkMode"),
      //WARNING: this read callback is never called, cannot figure out why the fuck
    ),
    darkStyle = BlocVar.modal<DarkStyle>(
      initVal: initialData.darkStyle,
      key: parent.parent._getStoreKey("stage_brightness_darkStyle"), 
      toJson: (style) => style.name,
      fromJson: (j) => DarkStyles.fromName(j as String),
      readCallback: (_) => parent.parent._readCallback("stage_brightness_darkStyle"),
    );


  //==============================
  // Getters
  bool get _isCurrentlyReading => this.parent.parent.storeKey != null && (
    this.autoDark.modalReading ||
    this.autoDarkMode.modalReading ||
    this.brightness.modalReading ||
    this.darkStyle.modalReading 
  );

  StageBrightnessData get extractData => StageBrightnessData._(
    autoDark: autoDark.value,
    brightness: brightness.value,
    darkStyle: darkStyle.value,
    autoDarkMode: autoDarkMode.value,
  );

}


