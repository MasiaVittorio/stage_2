part of stage;

extension _StageThemeDataExt<T,S> on _StageThemeData<T,S> {

  Brightness get _currentBrightness => brightness.brightness.value;

  Brightness get _currentForcedPrimaryColorBrightness => _currentBrightness.isLight 
    ? forcedPrimaryColorBrightnessOnLightTheme
    : forcedPrimaryColorBrightnessOnDarkTheme;

  //===========================================
  // System UI Style
  void updateSystemNavBarStyle(){
    if(forceSystemNavBarStyle ?? false){
      final Color color =  colorPlace.value.isTexts 
        ? derived.themeData.value.canvasColor 
        : derived.currentPrimaryColor.value;
      final Brightness colorBrightness = _currentForcedPrimaryColorBrightness 
        ?? ThemeData.estimateBrightnessForColor(color);

      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        systemNavigationBarColor: color,
        systemNavigationBarIconBrightness: colorBrightness.opposite,
        statusBarIconBrightness: colorBrightness.opposite, 
        statusBarColor: Colors.black12,
      ));
    }
  }


}