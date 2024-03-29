part of stage;


class StageDefaultColors {

  static const Color nightBluePrimary = Color(0xFF222E3C);
  static const Color darkPrimary = Color(0xFF1E1E1E);
  static const Color nightBlackPrimary = Color(0xFF191919);
  static const Color amoledPrimary = Color(0xFF151515);
  static const Map<DarkStyle,Color> darkPrimaries = <DarkStyle,Color>{
    DarkStyle.amoled: amoledPrimary,
    DarkStyle.dark: darkPrimary,
    DarkStyle.nightBlack: nightBlackPrimary,
    DarkStyle.nightBlue: nightBluePrimary,
  };

  // static const Color nightBlueAccent = NordTheme.nord8;
  static const Color nightBlueAccent = Color(0xFF64FFDA);
  static const Color darkAccent = Color(0xFFECEFF1);
  static const Color nightBlackAccent = Color(0xFFCFD8DC);
  static const Color amoledAccent = Color(0xFFCFD8DC);
  static const Map<DarkStyle,Color> darkAccents = <DarkStyle,Color>{
    DarkStyle.amoled: amoledAccent,
    DarkStyle.dark: darkAccent,
    DarkStyle.nightBlack: nightBlackAccent,
    DarkStyle.nightBlue: nightBlueAccent,
  };
  // From counterspell: wrong?
  // static const Map<DarkStyle,Color> darkAccents = const <DarkStyle,Color>{
  //   DarkStyle.nightBlue: const Color(0xFF64FFDA), 
  //   DarkStyle.dark: const Color(0xFF212121),
  //   DarkStyle.amoled: const Color(0xFF212121),
  //   DarkStyle.nightBlack: const Color(0xFF212121),
  // };

  static const Color primary = Color(0xFF1A3452);
  static const Color accent = Color(0xFFE55A52);

  static const Color delete = Color(0xFFE45356);

}