part of stage;

enum DarkStyle {
  dark,
  nightBlack,
  amoled,
  nightBlue,
}

extension DarkStyleExtensions on DarkStyle {
  Color get defaultAccent => StageDefaultColors.darkAccents[this];
  Color get defaultPrimary => StageDefaultColors.darkPrimaries[this];

  String get name => DarkStyles.names[this];
}

class DarkStyles {

  static DarkStyle fromName(String string) => namesReverse[string];

  static const Map<DarkStyle, String> names = <DarkStyle, String>{
    DarkStyle.dark: "Dark",
    DarkStyle.nightBlack: "Night Black",
    DarkStyle.amoled: "Amoled",
    DarkStyle.nightBlue: "Night Blue",
  };
  static const namesReverse = {
    "Dark": DarkStyle.dark,
    "Night Black": DarkStyle.nightBlack,
    "Amoled": DarkStyle.amoled,
    "Night Blue": DarkStyle.nightBlue,
  };
  static const Map<DarkStyle,DarkStyle> next = {
    DarkStyle.dark: DarkStyle.nightBlack,
    DarkStyle.nightBlack: DarkStyle.amoled,
    DarkStyle.amoled: DarkStyle.nightBlue,
    DarkStyle.nightBlue: DarkStyle.dark,
  };

  static Map<DarkStyle,T> mapWithSingleValue<T>(T value) => <DarkStyle,T>{
    for(final style in DarkStyle.values)
      style: value,
  };

}
