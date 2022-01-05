part of stage;

extension _StageThemeDataExt<T,S> on _StageThemeData<T,S> {

  //===========================================
  // System UI Style
  void updateSystemNavBarStyle(){
    if(forceSystemNavBarStyle ?? false){
      final Color? color =  colorPlace.value.isTexts 
        ? derived.themeData.value.canvasColor 
        : derived.currentPrimaryColor.value;
      final Brightness colorBrightness = ThemeData.estimateBrightnessForColor(color!);

      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        systemNavigationBarColor: color,
        systemNavigationBarIconBrightness: colorBrightness.opposite,
        statusBarIconBrightness: colorBrightness.opposite, 
        statusBarColor: Colors.black12,
      ));
    }
  }


}