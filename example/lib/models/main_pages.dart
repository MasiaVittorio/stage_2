import 'package:example/core.dart';


enum MainPage {
  alerts,
  snackBars,
  other,
}



extension MainPageExt on MainPage {
  String get name => MainPages._names[this]!;
  String get longName => MainPages._longNames[this]!;
  IconData get iconFilled => MainPages._iconsFilled[this]!;
  IconData get iconOutline => MainPages._iconsOutlined[this]!;
}

class MainPages {

  static MainPage fromName(String name)=> reversedNames[name]!;

  static const Map<MainPage,String> _names = <MainPage,String>{
    MainPage.alerts: "Alerts",
    MainPage.snackBars: "Snacks",
    MainPage.other: "Other",
  };
  static const Map<String,MainPage> reversedNames = <String,MainPage>{
    "Alerts": MainPage.alerts,
    "Snacks": MainPage.snackBars,
    "Other": MainPage.other,
  };

  static const Map<MainPage,String> _longNames = <MainPage,String>{
    MainPage.alerts: "Panel alerts",
    MainPage.snackBars: "SnackBars",
    MainPage.other: "Other stuff",
  };

  static const Map<MainPage,IconData> _iconsFilled = <MainPage,IconData>{
    MainPage.alerts: McIcons.alert,
    MainPage.snackBars: Icons.notifications_active,
    MainPage.other: Icons.menu,
  };
  static const Map<MainPage,IconData> _iconsOutlined = <MainPage,IconData>{
    MainPage.alerts: McIcons.alert_outline,
    MainPage.snackBars: Icons.notifications_none,
    MainPage.other: Icons.menu,
  };

  

}