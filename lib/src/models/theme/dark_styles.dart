part of stage;

enum DarkStyle {
  dark(
    "Dark",
    StageDefaultColors.darkPrimary,
    StageDefaultColors.darkAccent,
  ),
  nightBlack(
    "Night Black",
    StageDefaultColors.nightBlackPrimary,
    StageDefaultColors.nightBlackAccent,
  ),
  amoled(
    "Amoled",
    StageDefaultColors.amoledPrimary,
    StageDefaultColors.amoledAccent,
  ),
  nightBlue(
    "Night Blue",
    StageDefaultColors.nightBluePrimary,
    StageDefaultColors.nightBlueAccent,
  );

  final Color defaultPrimary;
  final Color defaultAccent;
  final String name;

  const DarkStyle(
    this.name,
    this.defaultPrimary,
    this.defaultAccent,
  );

  static DarkStyle fromName(String name) 
    => values.firstWhere((e) => e.name == name);
  
  
  static const Map<DarkStyle,DarkStyle> _next = {
    DarkStyle.dark: DarkStyle.nightBlack,
    DarkStyle.nightBlack: DarkStyle.amoled,
    DarkStyle.amoled: DarkStyle.nightBlue,
    DarkStyle.nightBlue: DarkStyle.dark,
  };

  DarkStyle get  next => _next[this]!;
  
  static Map<DarkStyle,T> mapWithSingleValue<T>(T value) => <DarkStyle,T>{
    for(final style in DarkStyle.values)
      style: value,
  };
}


