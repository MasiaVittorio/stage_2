part of stage;

extension StageColorsMethods<T,S> on _StageColorsData<T,S> {

  //============================================
  // Dark Primary Colors
  bool _editDarkMainPageToPrimary({@required T page, @required DarkStyle style, @required Color color}){
    if(darkMainPageToPrimaries.value[style][page] == color) return false;
    darkMainPageToPrimaries.value[style][page] = color;
    darkMainPageToPrimaries.refresh();
    return true;
  }
  void _editDarkMainPagedPrimaries({@required DarkStyle style, @required Map<T,Color> perPage}){
    darkMainPageToPrimaries.value[style] = perPage;
    darkMainPageToPrimaries.refresh();
  }

  bool _editDarkMainPrimary({@required DarkStyle style, @required Color color}){
    if(darkMainPrimaries.value[style] == color) return false;
    darkMainPrimaries.value[style] = color;
    darkMainPrimaries.refresh();
    return true;
  }

  bool _editDarkPanelPageToPrimary({@required S page, @required DarkStyle style, @required Color color}){
    if(darkPanelPageToPrimaries.value[style][page] == color) return false;
    darkPanelPageToPrimaries.value[style][page] = color;
    darkPanelPageToPrimaries.refresh();
    return true;
  }

  void _editDarkPanelPagedPrimaries({@required DarkStyle style, @required Map<S,Color> perPage}){
    darkPanelPageToPrimaries.value[style] = perPage;
    darkPanelPageToPrimaries.refresh();
  }

  bool _editDarkPanelPrimary({@required DarkStyle style, @required Color color}){
    if(darkPanelPrimaries.value[style] == color) return false;
    darkPanelPrimaries.value[style] = color;
    darkPanelPrimaries.refresh();
    return true;
  }

  bool _enableDarkMainPagedColors(){
    if(darkMainPageToPrimaries.value != null) return false;
    this.darkMainPageToPrimaries.set(
      this._cachedDarkMainPageToPrimaries.value ?? <DarkStyle,Map<T,Color>>{
        for(final style in DarkStyle.values)
          style: <T,Color>{
            for(final key in parent.parent.mainPagesController.pagesData.keys)
              key: this.darkMainPrimaries.value[style],
          },
      },
    );
    return true;
  }
  bool _disableDarkMainPagedColors() {
    if(darkMainPageToPrimaries.value == null) return false;
    this._cachedDarkMainPageToPrimaries.set(
      this.darkMainPageToPrimaries.value,
    );
    this.darkMainPageToPrimaries.set(null);
    return true;
  }
  bool _enableDarkPanelPagedColors(){
    if(darkPanelPageToPrimaries.value != null) return false;
    this.darkPanelPageToPrimaries.set(
      this._cachedDarkPanelPageToPrimaries.value ?? <DarkStyle,Map<S,Color>>{
        for(final style in DarkStyle.values)
          style: <S,Color>{
            for(final key in parent.parent.panelPagesController.pagesData.keys)
              key: this.darkPanelPrimaries.value[style],
          },
      },
    );
    return true;
  }
  bool _disableDarkPanelPagedColors() {
    if(darkPanelPageToPrimaries.value == null) return false;
    this._cachedDarkPanelPageToPrimaries.set(
      this.darkPanelPageToPrimaries.value,
    );
    this.darkPanelPageToPrimaries.set(null);
    return true;
  }


  //============================================
  // Light Primary Colors
  bool _editLightMainPageToPrimary(T page, Color color){
    if(lightMainPageToPrimary.value[page] == color) return false;
    lightMainPageToPrimary.value[page] = color;
    lightMainPageToPrimary.refresh();
    return true;
  }

  void _editLightMainPagedPrimaries(Map<T,Color> perPage){
    lightMainPageToPrimary.value = perPage;
    lightMainPageToPrimary.refresh();
  }

  bool _editLightMainPrimary(Color color) => lightMainPrimary.setDistinct(color);

  bool _editLightPanelPageToPrimary(S page, Color color){
    if(lightPanelPageToPrimary.value[page] == color) return false;
    lightPanelPageToPrimary.value[page] = color;
    lightPanelPageToPrimary.refresh();
    return true;
  }

  void _editLightPanelPagedPrimaries(Map<S,Color> perPage){
    lightPanelPageToPrimary.value = perPage;
    lightPanelPageToPrimary.refresh();
  }

  bool _editLightPanelPrimary(Color color) => lightPanelPrimary.setDistinct(color);

  bool _enableLightMainPagedColors(){
    if(lightMainPageToPrimary.value != null) return false;
    this.lightMainPageToPrimary.set(
      this._cachedLightMainPageToPrimary.value ?? <T,Color>{
        for(final T key in parent.parent.mainPagesController.pagesData.keys)
          key: this.lightMainPrimary.value,
      },
    );
    return true;
  }
  bool _disableLightMainPagedColors() {
    if(lightMainPageToPrimary.value == null) return false;
    this._cachedLightMainPageToPrimary.set(
      this.lightMainPageToPrimary.value,
    );
    this.lightMainPageToPrimary.set(null);
    return true;
  }
  bool _enableLightPanelPagedColors(){
    if(lightPanelPageToPrimary.value != null) return false;
    this.lightPanelPageToPrimary.set(
      this._cachedLightPanelPageToPrimary.value ?? <S,Color>{
        for(final key in parent.parent.panelPagesController.pagesData.keys)
          key: this.lightPanelPrimary.value,
      },
    );
    return true;
  }
  bool _disableLightPanelPagedColors() {
    if(lightPanelPageToPrimary.value == null) return false;
    this._cachedLightPanelPageToPrimary.set(
      this.lightPanelPageToPrimary.value,
    );
    this.lightPanelPageToPrimary.set(null);
    return true;
  }


  //============================================
  // Light Accent Color
  bool _editLightAccent(Color color) => lightAccent.setDistinct(color);

  //============================================
  // Dark Accent Colors
  bool _editDarkAccent({@required DarkStyle style, @required Color color}) {
    if(darkAccents.value[style] == color) return false;
    darkAccents.value[style] = color;
    darkAccents.refresh();
    return true;
  }



  //============================================
  // State Agnostic Color Editors
  Brightness get _currentBrightness => parent.brightness.brightness.value;
  DarkStyle get _currentDarkStyle => parent.brightness.darkStyle.value;

  Brightness get _currentForcedPrimaryColorBrightness => _currentBrightness.isLight 
    ? parent.forcedPrimaryColorBrightnessOnLightTheme
    : parent.forcedPrimaryColorBrightnessOnDarkTheme;

  bool editMainPageToPrimary(T page, Color color){
    if(_currentBrightness.isLight){
      return _editLightMainPageToPrimary(page, color);
    } else {
      return _editDarkMainPageToPrimary(
        color: color,
        page: page,
        style: _currentDarkStyle,
      );
    }
  }

  void editMainPagedPrimaries(Map<T,Color> perPage){
    if (_currentBrightness.isLight) {
      _editLightMainPagedPrimaries(perPage);
    } else {
      _editDarkMainPagedPrimaries(
        perPage: perPage,
        style: _currentDarkStyle,
      );
    }
  }

  bool editMainPrimary(Color color){
    if(_currentBrightness.isLight){
      return _editLightMainPrimary(color);
    } else {
      return _editDarkMainPrimary(
        color: color,
        style: _currentDarkStyle,
      );
    }
  }

  bool editPanelPageToPrimary(S page, Color color){
    if(_currentBrightness.isLight){
      return _editLightPanelPageToPrimary(page, color);
    } else {
      return _editDarkPanelPageToPrimary(
        color: color,
        page: page,
        style: _currentDarkStyle,
      );
    }
  }

  void editPanelPagedPrimaries(Map<S,Color> perPage){
    if (_currentBrightness.isLight) {
      _editLightPanelPagedPrimaries(perPage);
    } else {
      _editDarkPanelPagedPrimaries(
        perPage: perPage,
        style: _currentDarkStyle,
      );
    }
  }

  bool editPanelPrimary(Color color){
    if(_currentBrightness.isLight){
      return _editLightPanelPrimary(color);
    } else {
      return _editDarkPanelPrimary(
        color: color,
        style: _currentDarkStyle,
      );
    }
  }

  bool editAccent(Color color){
    if(_currentBrightness.isLight){
      return _editLightAccent(color);
    } else {
      return _editDarkAccent(
        color: color,
        style: _currentDarkStyle,
      );
    }
  }

  bool enableMainPagedColors(){
    if(_currentBrightness.isLight){
      return _enableLightMainPagedColors();
    } else {
      return _enableDarkMainPagedColors();
    }
  }
  bool disableMainPagedColors(){
    if(_currentBrightness.isLight){
      return _disableLightMainPagedColors();
    } else {
      return _disableDarkMainPagedColors();
    }
  }

  bool enablePanelPagedColors(){
    if(_currentBrightness.isLight){
      return _enableLightPanelPagedColors();
    } else {
      return _enableDarkPanelPagedColors();
    }
  }
  bool disablePanelPagedColors(){
    if(_currentBrightness.isLight){
      return _disableLightPanelPagedColors();
    } else {
      return _disableDarkPanelPagedColors();
    }
  }


  //===========================================
  // System UI Style
  void updateSystemNavBarStyle(){
    if(parent.forceSystemNavBarStyle ?? false){
      final Color color =  colorPlace.value.isTexts 
        ? parent.derived.themeData.value.canvasColor 
        : parent.derived.currentPrimaryColor.value;
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
