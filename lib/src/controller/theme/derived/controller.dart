part of 'package:stage/stage.dart';

class _StageDerivedThemeData<T, S> {
  //=========================================
  // Disposer
  void dispose() {
    accentColor.dispose();
    mainPageToPrimaryColor.dispose();
    _mainPrimaryColor.dispose();
    panelPageToPrimaryColor.dispose();
    _panelPrimaryColor.dispose();
    currentPrimaryColor.removeListener(parent.updateSystemNavBarStyle);
    currentPrimaryColor.dispose();
    _lightThemeData.dispose();
    _darkThemeDatas.dispose();
    themeData.dispose();
  }

  //=========================================
  // Values
  final _StageThemeData<T, S> parent;

  late Reactive<Color> accentColor;

  late Reactive<Color> _mainPrimaryColor;
  late Reactive<Map<T, Color>?> mainPageToPrimaryColor;

  /// Could be null
  late Reactive<Color> _panelPrimaryColor;
  late Reactive<Map<S, Color>?> panelPageToPrimaryColor;

  /// Could be null

  late Reactive<Color> currentPrimaryColor;

  late Reactive<ThemeData> _lightThemeData;
  late Reactive<Map<DarkStyle, ThemeData>> _darkThemeDatas;
  late Reactive<ThemeData> themeData;

  //=========================================
  // Constructor
  _StageDerivedThemeData(this.parent) {
    accentColor = (
      parent.brightness.brightness,
      parent.brightness.darkStyle,
      parent.colorPlace,
      parent.backgroundColors.lightAccent,
      parent.backgroundColors.darkAccents,
      parent.textsColors.lightAccent,
      parent.textsColors.darkAccents,
    ).related(
      _currentWithBrightnessAndPlace<Color>,
    );

    _mainPrimaryColor = (
      parent.brightness.brightness,
      parent.brightness.darkStyle,
      parent.colorPlace,
      parent.backgroundColors.lightMainPrimary,
      parent.backgroundColors.darkMainPrimaries,
      parent.textsColors.lightMainPrimary,
      parent.textsColors.darkMainPrimaries,
    ).related(_currentWithBrightnessAndPlace<Color>);

    _panelPrimaryColor = (
      parent.brightness.brightness,
      parent.brightness.darkStyle,
      parent.colorPlace,
      parent.backgroundColors.lightPanelPrimary,
      parent.backgroundColors.darkPanelPrimaries,
      parent.textsColors.lightPanelPrimary,
      parent.textsColors.darkPanelPrimaries,
    ).related(_currentWithBrightnessAndPlace<Color>);

    mainPageToPrimaryColor = (
      parent.brightness.brightness,
      parent.brightness.darkStyle,
      parent.colorPlace,
      parent.backgroundColors.lightMainPageToPrimary,
      parent.backgroundColors.darkMainPageToPrimaries,
      parent.textsColors.lightMainPageToPrimary,
      parent.textsColors.darkMainPageToPrimaries,
    ).related(
      _currentWithBrightnessAndPlaceNullable<Map<T, Color>?>,
      equality: (f, s) => _StageUtils._compareMaps<T, Color>(f, s),
    );
    // copier: (m) => m == null ? null : Map<T, Color>.from(m),
    // TODO: copier should not be needed

    panelPageToPrimaryColor = (
      parent.brightness.brightness,
      parent.brightness.darkStyle,
      parent.colorPlace,
      parent.backgroundColors.lightPanelPageToPrimary,
      parent.backgroundColors.darkPanelPageToPrimaries,
      parent.textsColors.lightPanelPageToPrimary,
      parent.textsColors.darkPanelPageToPrimaries,
    ).related(
      _currentWithBrightnessAndPlaceNullable<Map<S, Color>?>,
      equality: (f, s) => _StageUtils._compareMaps<S?, Color?>(f, s),
    );
    // TODO: copier should not be needed
    // copier: (m) => m == null ? null : Map<S, Color>.from(m),

    currentPrimaryColor = (
      parent.parent.panelController.isMostlyOpenedNonAlert,
      parent.parent.mainPagesController._page,
      parent.parent.panelPagesController?._page as Reactive<S?>? ?? Reactive(null),
      _mainPrimaryColor,
      mainPageToPrimaryColor,
      _panelPrimaryColor,
      panelPageToPrimaryColor, //panel page could be null
    ).related(
      (openNonAlert, mainPage, panelPage, main, pagedMain, panel, pagedPanel) =>
          _currentWithPanelAndPages<Color?, T?, S?>(
              openNonAlert, mainPage, panelPage, main, pagedMain, panel, pagedPanel)!,
    );
    currentPrimaryColor.addListener(parent.updateSystemNavBarStyle);

    _darkThemeDatas = (
      parent.backgroundColors.darkAccents,
      parent.backgroundColors.darkMainPrimaries,
      parent.textsColors.darkAccents,
      parent.textsColors.darkMainPrimaries,
      parent.colorPlace,
    ).related((backAccents, backPrimaries, textsAccents, textsPrimaries, colorPlace) =>
        <DarkStyle, ThemeData>{
          for (final style in DarkStyle.values)
            style: StageThemeUtils.getThemeData(
              brightness: Brightness.dark,
              darkStyle: style,
              primary: colorPlace.isTexts ? textsPrimaries[style]! : backPrimaries[style]!,
              accent: colorPlace.isTexts ? textsAccents[style]! : backAccents[style]!,
            ),
        });

    _lightThemeData = (
      parent.backgroundColors.lightAccent,
      parent.backgroundColors.lightMainPrimary,
      parent.textsColors.lightAccent,
      parent.textsColors.lightMainPrimary,
      parent.colorPlace
    ).related(
      (backAccent, backPrimary, textsAccent, textsPrimary, colorPlace) =>
          StageThemeUtils.getThemeData(
        brightness: Brightness.light,
        darkStyle: null,
        primary: colorPlace.isTexts ? textsPrimary : backPrimary,
        accent: colorPlace.isTexts ? textsAccent : backAccent,
      ),
    );

    themeData = (
      parent.brightness.brightness,
      parent.brightness.darkStyle,
      _lightThemeData,
      _darkThemeDatas,
    ).related(
      (brightness, style, light, darks) =>
          _currentWithBrightness<ThemeData>(brightness, style, light, darks),
    );
  }

  //===========================================
  // Maps

  static A _currentWithBrightnessAndPlace<A>(
    Brightness brightness,
    DarkStyle style,
    StageColorPlace place,
    A backgroundLight,
    Map<DarkStyle, A> backgroundDarks,
    A textsLight,
    Map<DarkStyle, A> textsDarks,
  ) {
    if (brightness.isDark) {
      if (place.isTexts) {
        return textsDarks[style]!;
      } else {
        return backgroundDarks[style]!;
      }
    } else {
      if (place.isTexts) {
        return textsLight;
      } else {
        return backgroundLight;
      }
    }
  }

  static A? _currentWithBrightnessAndPlaceNullable<A>(
    Brightness brightness,
    DarkStyle style,
    StageColorPlace place,
    A? backgroundLight,
    Map<DarkStyle, A>? backgroundDarks,
    A? textsLight,
    Map<DarkStyle, A>? textsDarks,
  ) {
    if (brightness.isDark) {
      if (place.isTexts) {
        return textsDarks?[style]!;
      } else {
        return backgroundDarks?[style]!;
      }
    } else {
      if (place.isTexts) {
        return textsLight;
      } else {
        return backgroundLight;
      }
    }
  }

  static A _currentWithBrightness<A>(
    Brightness brightness,
    DarkStyle style,
    A light,
    Map<DarkStyle, A> darks,
  ) {
    if (brightness.isDark) {
      return darks[style] ?? light;
    } else {
      return light;
    }
  }

  static A _currentWithPanelAndPages<A, T, S>(
          bool openNonAlert,
          T mainPage,
          S panelPage, // Could be null if panel does not have pages
          A main,
          Map<T, A>? pagedMain,
          A panel,
          Map<S, A>? pagedPanel) =>
      openNonAlert
          ? pagedPanel != null && panelPage != null
              ? pagedPanel[panelPage] ?? panel
              : panel
          : pagedMain != null
              ? pagedMain[mainPage] ?? main
              : main;
}
