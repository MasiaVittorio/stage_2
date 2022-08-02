import 'package:example/core.dart';


enum PanelPage {
  theme,
  pages,
  dimensions,
  stateless,
}



extension PanelPageExt on PanelPage {
  String get name => PanelPages._names[this]!;
  String get longName => PanelPages._longNames[this]!;
  String get subTitle => PanelPages._subtitles[this]!;
  IconData get iconFilled => PanelPages._iconsFilled[this]!;
  IconData get iconOutline => PanelPages._iconsOutlined[this]!;
}

class PanelPages {

  static PanelPage fromName(String name)=> reversedNames[name]!;

  static const Map<PanelPage,String> _names = <PanelPage,String>{
    PanelPage.theme: "Theme",
    PanelPage.stateless: "Stateless",
    PanelPage.dimensions: "Dimensions",
    PanelPage.pages: "Pages",
  };
  static const Map<String,PanelPage> reversedNames = <String,PanelPage>{
    "Stored": PanelPage.theme,
    "Theme": PanelPage.theme,
    "Stateless": PanelPage.stateless,
    "Dimensions": PanelPage.dimensions,
    "Pages": PanelPage.pages,
  };

  static const Map<PanelPage,String> _longNames = <PanelPage,String>{
    PanelPage.theme: "Theme settings",
    PanelPage.pages: "Pages settings",
    PanelPage.dimensions: "Stage's geometry",
    PanelPage.stateless: "Stateless Variables",
  };

  static const Map<PanelPage,String> _subtitles = <PanelPage,String>{
    PanelPage.theme: "Change colors",
    PanelPage.stateless: "Set once by the dev",
    PanelPage.dimensions: "Set boundaries",
    PanelPage.pages: "Customize main screen",
  };

  static const Map<PanelPage,IconData> _iconsFilled = <PanelPage,IconData>{
    PanelPage.theme: McIcons.palette,
    PanelPage.stateless: McIcons.cog,
    PanelPage.dimensions: McIcons.ruler,
    PanelPage.pages: McIcons.cards,
  };
  static const Map<PanelPage,IconData> _iconsOutlined = <PanelPage,IconData>{
    PanelPage.theme: McIcons.palette_outline,
    PanelPage.stateless: McIcons.cog_outline,
    PanelPage.dimensions: McIcons.ruler,
    PanelPage.pages: McIcons.cards_outline,
  };

}