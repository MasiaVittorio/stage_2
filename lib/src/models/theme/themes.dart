part of stage;

enum StageColorPlace {
  background,
  texts,
}

class StageColorPlaces {
  static const Map<String,StageColorPlace> map = <String,StageColorPlace>{
    "Background": StageColorPlace.background,
    "Texts": StageColorPlace.texts,
  }; 

  static StageColorPlace fromName(String? s) => map[s!] ?? StageColorPlace.background;
}

extension StageColorPlaceExt on StageColorPlace? {
  static const Map<StageColorPlace,String> map = <StageColorPlace,String>{
    StageColorPlace.background: "Background",
    StageColorPlace.texts: "Texts",
  }; 

  String? get name => map[this!];

  bool get isTexts => this == StageColorPlace.texts;
  bool get notTexts => !isTexts;
  bool get isBackground => this == StageColorPlace.background;
  bool get notBackground => !isBackground;
}

class StageThemeUtils {

  static ThemeData getThemeData({
    required Brightness brightness, 
    required DarkStyle? darkStyle,
    required Color primary,
    required Color accent, 
  }) {
    
    final Color toggleable = accent;
    final Color canvas = brightness.isLight
      ? Colors.grey.shade50
      : _darkCanvasColors[darkStyle!]!;

    return ThemeData(
      splashFactory: InkRipple.splashFactory,
      highlightColor: Colors.transparent,

      brightness: brightness,

      primaryColor: primary,

      canvasColor: canvas,

      scaffoldBackgroundColor: brightness.isLight 
        ? Colors.grey.shade200 
        : _darkBackgroundColors[darkStyle!],

      // TODO: check if still surface doesn't reflect canvas?
      colorScheme: (brightness.isLight 
        ? const ColorScheme.light()
        : const ColorScheme.dark()).copyWith(
          secondary: accent,
          brightness: brightness,
          primary: primary,
          surface: canvas,
          onPrimary: primary.contrast,
          onSecondary: accent.contrast,
        ),

      textTheme: _textTheme.apply(
        bodyColor: brightness.isLight ? _onLight : _onDark,
        displayColor: brightness.isLight ? _onLight : _onDark,
      ),

      primaryTextTheme: _textTheme,

      iconTheme: IconThemeData(opacity: 0.75, color: brightness.contrast),
      primaryIconTheme: IconThemeData(opacity: 1.0, color: primary.contrast),

      sliderTheme: SliderThemeData(
        activeTickMarkColor: toggleable,
        activeTrackColor: toggleable,
        thumbColor: toggleable,
        overlayColor: toggleable.withAlpha(0x1f),
        inactiveTickMarkColor: toggleable.withAlpha(0x3d),
        inactiveTrackColor: toggleable.withAlpha(0x3d),
        thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 9.0),
        showValueIndicator: ShowValueIndicator.always,
      ), switchTheme: SwitchThemeData(
 thumbColor: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
 if (states.contains(MaterialState.disabled)) { return null; }
 if (states.contains(MaterialState.selected)) { return toggleable; }
 return null;
 }),
 trackColor: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
 if (states.contains(MaterialState.disabled)) { return null; }
 if (states.contains(MaterialState.selected)) { return toggleable; }
 return null;
 }),
 ), radioTheme: RadioThemeData(
 fillColor: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
 if (states.contains(MaterialState.disabled)) { return null; }
 if (states.contains(MaterialState.selected)) { return toggleable; }
 return null;
 }),
 ), checkboxTheme: CheckboxThemeData(
 fillColor: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
 if (states.contains(MaterialState.disabled)) { return null; }
 if (states.contains(MaterialState.selected)) { return toggleable; }
 return null;
 }),
 ),
    );
  } 

  static const Map<DarkStyle, Color> _darkCanvasColors = <DarkStyle, Color>{
    DarkStyle.dark : Color(0xFF303030),
    DarkStyle.nightBlack : Color(0xFF141414),
    DarkStyle.amoled : Color(0xFF000000),
    // DarkStyle.nightBlue : NordTheme.nord1,
    DarkStyle.nightBlue : Color(0xFF1C2733),
  };

  static const Map<DarkStyle, Color> _darkBackgroundColors = <DarkStyle, Color>{
    DarkStyle.dark : Color(0xFF212121),
    DarkStyle.nightBlack : Color(0xFF000000),
    DarkStyle.amoled : Color(0xFF000000),
    // DarkStyle.nightBlue : NordTheme.nord0,
    DarkStyle.nightBlue : Color(0xFF151D26),
  };


  static const _onLight = Color(0xA5000000);
  static const _onDark = Color(0xCCFFFFFF);
  static const _normalWeight = FontWeight.w600;
  static const _thinWeight = FontWeight.w200;
  static const _mediumWeight = FontWeight.w700;


  static const _display4 = TextStyle(
    inherit: true,
    fontSize: 112.0,
    fontWeight: _thinWeight,
  );
  static const _display3 = TextStyle(
    inherit: true,
    fontSize: 56.0,
    fontWeight: _normalWeight,
  );
  static const _display2 = TextStyle(
    inherit: true,
    fontSize: 45.0,
    fontWeight: _normalWeight,
  );
  static const _display1 = TextStyle(
    inherit: true,
    fontSize: 34.0,
    fontWeight: _normalWeight,
  );
  static const _headline = TextStyle(
    inherit: true,
    fontSize: 24.0,
    fontWeight: _normalWeight,
  );
  static const _title = TextStyle(
    inherit: true,
    fontSize: 20.0,
    fontWeight: _mediumWeight,
  );
  static const _subhead = TextStyle(
    inherit: true,
    fontSize: 16.0,
    fontWeight: _normalWeight,
  );
  static const _body2 = TextStyle(
    inherit: true,
    fontSize: 14.0,
    fontWeight: _mediumWeight,
  );
  static const _body1 = TextStyle(
    inherit: true,
    fontSize: 14.0,
    fontWeight: _normalWeight,
  );
  static const _caption = TextStyle(
    inherit: true,
    fontSize: 12.0,
    fontWeight: _normalWeight,
  );
  static const _button = TextStyle(
    inherit: true,
    fontSize: 14.0,
    fontWeight: _mediumWeight,
  );
  static const _subtitle = _button;
  static const _overline = TextStyle(
    inherit: true,
    fontSize: 10.0,
    fontWeight: _normalWeight,
  );

  static const _textTheme = TextTheme(
    bodyMedium: _body1,
    bodyLarge: _body2,
    titleLarge: _title,
    headlineMedium: _display1,
    displaySmall: _display2,
    displayMedium: _display3,
    displayLarge: _display4,
    headlineSmall: _headline,
    titleMedium: _subhead,
    bodySmall: _caption,
    labelLarge: _button,
    titleSmall: _subtitle,
    labelSmall: _overline,
  );


}