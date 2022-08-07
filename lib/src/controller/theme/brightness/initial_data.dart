part of stage;

class StageBrightnessData {
  //=================================
  // Values

  //============================================
  // Actual State
  final Brightness? brightness;
  final DarkStyle? darkStyle;

  //============================================
  // Behavior (pseudo state, provide mediaquery to update manually)
  final bool? autoDark;
  ///wether the automatic light/dark switch has to be decided upon time
  ///  of day (current hour between 7 and 20) or system's mediaquery -> preferred brightness
  final AutoDarkMode? autoDarkMode;


  //=================================
  // Constructors
  const StageBrightnessData._({
    required Brightness? brightness,
    required DarkStyle? darkStyle, 
    required bool? autoDark, 
    required AutoDarkMode? autoDarkMode, 
  }): 
    brightness = brightness ?? defaultBrightness,
    darkStyle = darkStyle ?? defaultDarkStyle,
    autoDark = autoDark ?? defaultAutoDark,
    autoDarkMode = autoDarkMode ?? defaultAutoDarkMode;
  
  const StageBrightnessData.nullable({
    this.brightness,
    this.darkStyle, 
    this.autoDark, 
    this.autoDarkMode, 
  });
  
  static StageBrightnessData _fromThemeAndNullableData(
    ThemeData? theme,
    StageBrightnessData? nullableData,
  ) => _fromTheme(
    theme,
    brightness: nullableData?.brightness,
    darkStyle: nullableData?.darkStyle, 
    autoDark: nullableData?.autoDark, 
    autoDarkMode: nullableData?.autoDarkMode, 
  );

  static StageBrightnessData _fromTheme(ThemeData? theme, {
    Brightness? brightness,
    DarkStyle? darkStyle, 
    bool? autoDark, 
    AutoDarkMode? autoDarkMode, 
  }) => StageBrightnessData._(
    autoDark: autoDark,
    brightness: brightness ?? theme?.brightness,
    darkStyle: darkStyle,
    autoDarkMode: autoDarkMode,
  );


  //=================================
  // Getters
  StageBrightnessData fillWith(StageBrightnessData? other) => StageBrightnessData._(
    brightness: brightness ?? other?.brightness, 
    darkStyle: darkStyle ?? other?.darkStyle, 
    autoDark: autoDark ?? other?.autoDark, 
    autoDarkMode: autoDarkMode ?? other?.autoDarkMode, 
  );


  //=================================
  // Default Data
  static const Brightness defaultBrightness = Brightness.light;
  static const bool defaultAutoDark = false;
  static const AutoDarkMode defaultAutoDarkMode = AutoDarkMode.timeOfDay;
  static const DarkStyle defaultDarkStyle = DarkStyle.nightBlue;
  static const StageBrightnessData defaultData = StageBrightnessData._(
    brightness: defaultBrightness, 
    darkStyle: defaultDarkStyle, 
    autoDark: defaultAutoDark, 
    autoDarkMode: defaultAutoDarkMode, 
  );


}