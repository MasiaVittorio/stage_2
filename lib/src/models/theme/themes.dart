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

  static StageColorPlace fromName(String s) => map[s] ?? StageColorPlace.background;
}

extension StageColorPlaceExt on StageColorPlace {
  static const Map<StageColorPlace,String> map = <StageColorPlace,String>{
    StageColorPlace.background: "Background",
    StageColorPlace.texts: "Texts",
  }; 

  String get name => map[this];

  bool get isTexts => this == StageColorPlace.texts;
  bool get notTexts => !isTexts;
  bool get isBackground => this == StageColorPlace.background;
  bool get notBackground => !isBackground;
}

class StageThemeUtils {

  static ThemeData getThemeData({
    @required Brightness brightness, 
    @required DarkStyle darkStyle,
    @required Color primary,
    @required Color accent, 
    @required Brightness forcedPrimaryColorBrightness, /// Could be null
  }) {
    
    final Color _toggleable = accent;

    return ThemeData(
      splashFactory: InkRipple.splashFactory,
      highlightColor: Colors.transparent,

      brightness: brightness,
      primaryColorBrightness: forcedPrimaryColorBrightness,

      canvasColor: brightness.isLight
        ? Colors.grey.shade50
        : _darkCanvasColors[darkStyle],
      // colorScheme: , TODO: surface non riflette canvas?
      scaffoldBackgroundColor: brightness.isLight 
        ? Colors.grey.shade200 
        : _darkBackgroundColors[darkStyle],
      primaryColor: primary,
      accentColor: accent,
      textTheme: _textTheme.apply(
        bodyColor: brightness.isLight ? _onLight : _onDark,
        displayColor: brightness.isLight ? _onLight : _onDark,
      ),
      primaryTextTheme: _textTheme,
      accentTextTheme: _textTheme,
      iconTheme: IconThemeData(opacity: 0.75, color: brightness.contrast),
      accentIconTheme: IconThemeData(opacity: 1.0, color: accent.contrast),
      primaryIconTheme: IconThemeData(opacity: 1.0, color: primary.contrast),
      toggleableActiveColor: _toggleable,
      sliderTheme: SliderThemeData(
        activeTickMarkColor: _toggleable,
        activeTrackColor: _toggleable,
        thumbColor: _toggleable,
        overlayColor: _toggleable.withAlpha(0x1f),
        inactiveTickMarkColor: _toggleable.withAlpha(0x3d),
        inactiveTrackColor: _toggleable.withAlpha(0x3d),
        thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 9.0),
        showValueIndicator: ShowValueIndicator.always,
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
    bodyText2: _body1,
    bodyText1: _body2,
    headline6: _title,
    headline4: _display1,
    headline3: _display2,
    headline2: _display3,
    headline1: _display4,
    headline5: _headline,
    subtitle1: _subhead,
    caption: _caption,
    button: _button,
    subtitle2: _subtitle,
    overline: _overline,
  );


}