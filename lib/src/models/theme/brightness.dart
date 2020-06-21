part of stage;

class _Brightness {

  static const Map<String,Brightness> invertedNames = <String,Brightness>{
    "Light": Brightness.light,
    "Dark": Brightness.dark,
  };
  static Brightness fromName(String name) => invertedNames[name];

}


enum AutoDarkMode {
  timeOfDay,
  system,  
}

extension AutoDarkExt on AutoDarkMode {
  String get name => _AutoDarkMode.names[this];

  IconData get icon => _AutoDarkMode.icons[this];

  Brightness currentBrightness(MediaQueryData mediaQuery){
    switch (this) {
      case AutoDarkMode.system:
        return mediaQuery?.platformBrightness ?? Brightness.light;
        break;
      case AutoDarkMode.timeOfDay:
        final DateTime now = DateTime.now();
        // LOW PRIORITY: better hours
        return now.hour >= 7 && now.hour <= 20
          ? Brightness.light
          : Brightness.dark;
        break;
      default:
        return StageBrightnessData.defaultBrightness;
    }
  }
}

class _AutoDarkMode {
  static const Map<AutoDarkMode, String> names = <AutoDarkMode,String>{
    AutoDarkMode.timeOfDay: "Time of day",
    AutoDarkMode.system: "System",
  };

  static const Map<String,AutoDarkMode> invertedNames = <String,AutoDarkMode>{
    "Time of day": AutoDarkMode.timeOfDay,
    "System": AutoDarkMode.system,
  };

  static AutoDarkMode fromName(String name) => invertedNames[name];

  static const Map<AutoDarkMode,IconData> icons = <AutoDarkMode,IconData>{
    AutoDarkMode.system: Icons.timeline,
    AutoDarkMode.timeOfDay: MaterialCommunityIcons.theme_light_dark,
  };

}
