part of stage;

class _StageColorsData<T,S> {

  //================================
  // Disposer
  void dispose(){
    lightAccent.dispose();
    lightMainPrimary.dispose();
    lightMainPageToPrimary.dispose();
    lightPanelPrimary.dispose();
    lightPanelPageToPrimary.dispose();
    darkAccents.dispose();
    darkMainPrimaries.dispose();
    darkMainPageToPrimaries.dispose();
    darkPanelPrimaries.dispose();
    darkPanelPageToPrimaries.dispose();
  }

  //================================
  // Values
  final _StageThemeData<T,S> parent;

  //==> Light Colors
  final BlocVar<Color> lightAccent;

  final BlocVar<Color> lightMainPrimary; 
  final BlocVar<Map<T,Color>?> lightMainPageToPrimary; /// could be null
  final BlocVar<Map<T,Color>?> _cachedLightMainPageToPrimary; /// To store its value when manually disabled

  final BlocVar<Color> lightPanelPrimary;
  final BlocVar<Map<S,Color>?> lightPanelPageToPrimary; /// could be null
  final BlocVar<Map<S,Color>?> _cachedLightPanelPageToPrimary; /// To store its value when manually disabled


  //==> Dark Colors (for each dark style)
  final BlocVar<Map<DarkStyle,Color>> darkAccents;

  final BlocVar<Map<DarkStyle,Color>> darkMainPrimaries; 
  final BlocVar<Map<DarkStyle,Map<T,Color>>?> darkMainPageToPrimaries; /// could be null
  final BlocVar<Map<DarkStyle,Map<T,Color>>?> _cachedDarkMainPageToPrimaries; /// To store its value when manually disabled

  final BlocVar<Map<DarkStyle,Color>> darkPanelPrimaries; 
  final BlocVar<Map<DarkStyle,Map<S,Color>>?> darkPanelPageToPrimaries; /// could be null
  final BlocVar<Map<DarkStyle,Map<S,Color>>?> _cachedDarkPanelPageToPrimaries; /// To store its value when manually disabled




  //================================
  // Constructor
  _StageColorsData(this.parent, {
    required StageColorPlace colorPlaceRef,
    required StageColorsData<T,S> initialData,
  }):
    lightAccent = BlocVar.modal<Color>(
      initVal: initialData.lightAccent!,
      key: parent.parent._getStoreKey("${colorPlaceRef.name}_stage_colors_lightAccent"), 
      toJson: (c) => c.value,
      fromJson: (j) => Color(j as int),
      readCallback: (_) => parent.parent._readCallback("stage_colors_lightAccent"),
    ),

    lightMainPrimary = BlocVar.modal<Color>(
      initVal: initialData.lightMainPrimary!,
      key: parent.parent._getStoreKey("${colorPlaceRef.name}stage_colors_lightMainPrimary"), 
      toJson: (c) => c.value,
      fromJson: (j) => Color(j as int),
      readCallback: (_) => parent.parent._readCallback("stage_colors_lightMainPrimary"),
    ),

    lightMainPageToPrimary = BlocVar.modal<Map<T,Color>?>(
      initVal: initialData.lightMainPageToPrimary, /// could be null
      key: parent.parent._getStoreKey("${colorPlaceRef.name}stage_colors_lightMainPageToPrimary"), 
      toJson: (map) => map == null ? null : <String,dynamic>{
        for(final entry in map.entries)
          jsonEncode(parent.parent._writeMainPage(entry.key)): entry.value.value,
      },
      fromJson: (j) => j == null ? null : <T,Color>{
        for(final entry in (j as Map).entries)
          parent.parent._readMainPage(jsonDecode(entry.key as String)): Color(entry.value as int),
      },
      readCallback: (_) => parent.parent._readCallback("stage_colors_lightMainPageToPrimary"),
    ),
    _cachedLightMainPageToPrimary = BlocVar.modal<Map<T,Color>?>(
      initVal: null,
      key: parent.parent._getStoreKey("${colorPlaceRef.name}stage_colors_lightMainPageToPrimary_CACHED"), 
      toJson: (map) => map == null ? null : <String,dynamic>{
        for(final entry in map.entries)
          jsonEncode(parent.parent._writeMainPage(entry.key)): entry.value.value,
      },
      fromJson: (j) => j == null ? null : <T,Color>{
        for(final entry in (j as Map).entries)
          parent.parent._readMainPage(jsonDecode(entry.key as String)): Color(entry.value as int),
      },
    ),

    lightPanelPrimary = BlocVar.modal<Color>(
      initVal: initialData.lightPanelPrimary!,
      key: parent.parent._getStoreKey("${colorPlaceRef.name}stage_colors_lightPanelPrimary"), 
      toJson: (c) => c.value,
      fromJson: (j) => Color(j as int),
      readCallback: (_) => parent.parent._readCallback("stage_colors_lightPanelPrimary"),
    ),

    lightPanelPageToPrimary = BlocVar.modal<Map<S,Color>?>(
      initVal: initialData.lightPanelPageToPrimary, ///could be null
      key: parent.parent._getStoreKey("${colorPlaceRef.name}stage_colors_lightPanelPageToPrimary"), 
      toJson: (map) => map == null ? null : <String,dynamic>{
        for(final entry in map.entries)
          jsonEncode(parent.parent._writePanelPage(entry.key)): entry.value.value,
      },
      fromJson: (j) => j == null ? null : <S,Color>{
        for(final entry in (j as Map).entries)
          parent.parent._readPanelPage(jsonDecode(entry.key as String)): Color(entry.value as int),
      },
      readCallback: (_) => parent.parent._readCallback("stage_colors_lightPanelPageToPrimary"),
    ),
    _cachedLightPanelPageToPrimary = BlocVar.modal<Map<S,Color>?>(
      initVal: null,
      key: parent.parent._getStoreKey("${colorPlaceRef.name}stage_colors_lightPanelPageToPrimary_CACHED"), 
      toJson: (map) => map == null ? null : <String,dynamic>{
        for(final entry in map.entries)
          jsonEncode(parent.parent._writePanelPage(entry.key)): entry.value.value,
      },
      fromJson: (j) => j == null ? null : <S,Color>{
        for(final entry in (j as Map).entries)
          parent.parent._readPanelPage(jsonDecode(entry.key as String)): Color(entry.value as int),
      },
    ),

    darkAccents = BlocVar.modal<Map<DarkStyle,Color>>(
      initVal: initialData.darkAccents!,
      key: parent.parent._getStoreKey("${colorPlaceRef.name}stage_colors_darkAccents"), 
      toJson: (map) => <String?,dynamic>{
        for(final entry in map.entries)
          entry.key.name: entry.value.value,
      },
      fromJson: (j) => <DarkStyle,Color>{
        for(final entry in (j as Map).entries)
          DarkStyle.fromName(entry.key as String): Color(entry.value as int),
      },
      readCallback: (_) => parent.parent._readCallback("stage_colors_darkAccents"),
    ),

    darkMainPrimaries = BlocVar.modal<Map<DarkStyle,Color>>(
      initVal: initialData.darkMainPrimaries!,
      key: parent.parent._getStoreKey("${colorPlaceRef.name}stage_colors_darkMainPrimaries"), 
      toJson: (map) => <String?,dynamic>{
        for(final entry in map.entries)
          entry.key.name: entry.value.value,
      },
      fromJson: (j) => <DarkStyle,Color>{
        for(final entry in (j as Map).entries)
          DarkStyle.fromName(entry.key as String): Color(entry.value as int),
      },
      readCallback: (_) => parent.parent._readCallback("stage_colors_darkMainPrimaries"),
    ),

    darkMainPageToPrimaries = BlocVar.modal<Map<DarkStyle,Map<T,Color>>?>(
      initVal: initialData.darkMainPageToPrimaries, ///could be null
      key: parent.parent._getStoreKey("${colorPlaceRef.name}stage_colors_darkMainPageToPrimaries"),
      toJson: (mapOfMaps) => mapOfMaps == null ? null : <String?,dynamic>{
        for(final e in mapOfMaps.entries)
          e.key.name : <String,dynamic>{
            for(final entry in e.value.entries)
              jsonEncode(parent.parent._writeMainPage(entry.key)): entry.value.value
          },
      },
      fromJson: (json) => json == null ? null : <DarkStyle,Map<T,Color>>{
        for(final e in (json as Map).entries)
          DarkStyle.fromName(e.key as String): <T,Color>{
            for(final entry in (e.value as Map).entries)
              parent.parent._readMainPage(jsonDecode(entry.key as String)): Color(entry.value as int),
          }
      },
      readCallback: (_) => parent.parent._readCallback("stage_colors_darkMainPageToPrimaries"),
    ),
    _cachedDarkMainPageToPrimaries = BlocVar.modal<Map<DarkStyle,Map<T,Color>>?>(
      initVal: null,
      key: parent.parent._getStoreKey("${colorPlaceRef.name}stage_colors_darkMainPageToPrimaries_CACHED"),
      toJson: (mapOfMaps) => mapOfMaps == null ? null : <String?,dynamic>{
        for(final e in mapOfMaps.entries)
          e.key.name : <String,dynamic>{
            for(final entry in e.value.entries)
              jsonEncode(parent.parent._writeMainPage(entry.key)): entry.value.value
          },
      },
      fromJson: (json) => json == null ? null : <DarkStyle,Map<T,Color>>{
        for(final e in (json as Map).entries)
          DarkStyle.fromName(e.key as String): <T,Color>{
            for(final entry in (e.value as Map).entries)
              parent.parent._readMainPage(jsonDecode(entry.key as String)): Color(entry.value as int),
          }
      },
    ),

    darkPanelPrimaries = BlocVar.modal<Map<DarkStyle,Color>>(
      initVal: initialData.darkPanelPrimaries!,
      key: parent.parent._getStoreKey("${colorPlaceRef.name}stage_colors_darkPanelPrimaries"), 
      toJson: (map) => <String?,dynamic>{
        for(final entry in map.entries)
          entry.key.name: entry.value.value,
      },
      fromJson: (j) => <DarkStyle,Color>{
        for(final entry in (j as Map).entries)
          DarkStyle.fromName(entry.key as String): Color(entry.value as int),
      },
      readCallback: (_) => parent.parent._readCallback("stage_colors_darkPanelPrimaries"),
    ),

    darkPanelPageToPrimaries = BlocVar.modal<Map<DarkStyle,Map<S,Color>>?>(
      initVal: initialData.darkPanelPageToPrimaries, ///could be null
      key: parent.parent._getStoreKey("${colorPlaceRef.name}stage_colors_darkPanelPageToPrimaries"),
      toJson: (mapOfMaps) => mapOfMaps == null ? null : <String?,dynamic>{
        for(final e in mapOfMaps.entries)
          e.key.name : <String,dynamic>{
            for(final entry in e.value.entries)
              jsonEncode(parent.parent._writePanelPage(entry.key)): entry.value.value
          },
      },
      fromJson: (json) => json == null ? null : <DarkStyle,Map<S,Color>>{
        for(final e in (json as Map).entries)
          DarkStyle.fromName(e.key as String): <S,Color>{
            for(final entry in (e.value as Map).entries)
              parent.parent._readPanelPage(jsonDecode(entry.key as String)): Color(entry.value as int),
          }
      },
      readCallback: (_) => parent.parent._readCallback("stage_colors_darkPanelPageToPrimaries"),
    ),
    _cachedDarkPanelPageToPrimaries = BlocVar.modal<Map<DarkStyle,Map<S,Color>>?>(
      initVal: null,
      key: parent.parent._getStoreKey("${colorPlaceRef.name}stage_colors_darkPanelPageToPrimaries_CACHED"),
      toJson: (mapOfMaps) => mapOfMaps == null ? null : <String?,dynamic>{
        for(final e in mapOfMaps.entries)
          e.key.name : <String,dynamic>{
            for(final entry in e.value.entries)
              jsonEncode(parent.parent._writePanelPage(entry.key)): entry.value.value
          },
      },
      fromJson: (json) => json == null ? null : <DarkStyle,Map<S,Color>>{
        for(final e in (json as Map).entries)
          DarkStyle.fromName(e.key as String): <S,Color>{
            for(final entry in (e.value as Map).entries)
              parent.parent._readPanelPage(jsonDecode(entry.key as String)): Color(entry.value as int),
          }
      },
    );




  //===============================
  // Getters

  bool get _isCurrentlyReading => this.parent.parent.storeKey != null && (
    this.lightAccent.modalReading ||
    this.lightMainPrimary.modalReading ||
    this.lightMainPageToPrimary.modalReading ||
    this.lightPanelPrimary.modalReading ||
    this.lightPanelPageToPrimary.modalReading ||
    this.darkAccents.modalReading ||
    this.darkMainPrimaries.modalReading ||
    this.darkMainPageToPrimaries.modalReading ||
    this.darkPanelPrimaries.modalReading ||
    this.darkPanelPageToPrimaries.modalReading 
  );


  StageColorsData<T,S> get extractData => StageColorsData<T,S>._(
    allMainPagesToFill: null,
    allPanelPagesToFill: null,
    lightAccent: this.lightAccent.value, 
    lightMainPrimary: this.lightMainPrimary.value, 
    lightMainPageToPrimary: this.lightMainPageToPrimary.value, 
    lightPanelPrimary: this.lightPanelPrimary.value, 
    lightPanelPageToPrimary: this.lightPanelPageToPrimary.value, 
    darkAccents: this.darkAccents.value, 
    darkMainPrimaries: this.darkMainPrimaries.value, 
    darkMainPageToPrimaries: this.darkMainPageToPrimaries.value, 
    darkPanelPrimaries: this.darkPanelPrimaries.value, 
    darkPanelPageToPrimaries: this.darkPanelPageToPrimaries.value,
  );

}