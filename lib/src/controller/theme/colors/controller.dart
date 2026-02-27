part of 'package:stage/stage.dart';

class _StageColorsData<T, S> {
  //================================
  // Disposer
  void dispose() {
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
  final _StageThemeData<T, S> parent;

  //==> Light Colors
  final Reactive<Color> lightAccent;

  final Reactive<Color> lightMainPrimary;
  final Reactive<Map<T, Color>?> lightMainPageToPrimary;

  /// could be null
  final Reactive<Map<T, Color>?> _cachedLightMainPageToPrimary;

  /// To store its value when manually disabled

  final Reactive<Color> lightPanelPrimary;
  final Reactive<Map<S, Color>?> lightPanelPageToPrimary;

  /// could be null
  final Reactive<Map<S, Color>?> _cachedLightPanelPageToPrimary;

  /// To store its value when manually disabled

  //==> Dark Colors (for each dark style)
  final Reactive<Map<DarkStyle, Color>> darkAccents;

  final Reactive<Map<DarkStyle, Color>> darkMainPrimaries;
  final Reactive<Map<DarkStyle, Map<T, Color>>?> darkMainPageToPrimaries;

  /// could be null
  final Reactive<Map<DarkStyle, Map<T, Color>>?> _cachedDarkMainPageToPrimaries;

  /// To store its value when manually disabled

  final Reactive<Map<DarkStyle, Color>> darkPanelPrimaries;
  final Reactive<Map<DarkStyle, Map<S, Color>>?> darkPanelPageToPrimaries;

  /// could be null
  final Reactive<Map<DarkStyle, Map<S, Color>>?>
      _cachedDarkPanelPageToPrimaries;

  /// To store its value when manually disabled

  //================================
  // Constructor
  _StageColorsData(
    this.parent, {
    required StageColorPlace colorPlaceRef,
    required StageColorsData<T, S> initialData,
  })  : lightAccent = Reactive.modal<Color>(
          initVal: initialData.lightAccent!,
          key: parent.parent
              ._getStoreKey("${colorPlaceRef.name}_stage_colors_lightAccent"),
          toJsonEncodable: (c) => c.toARGB32(),
          fromJsonDecoded: (j) => Color(j as int),
          readCallback: (_) =>
              parent.parent._readCallback("stage_colors_lightAccent"),
        ),
        lightMainPrimary = Reactive.modal<Color>(
          initVal: initialData.lightMainPrimary!,
          key: parent.parent._getStoreKey(
              "${colorPlaceRef.name}stage_colors_lightMainPrimary"),
          toJsonEncodable: (c) => c.toARGB32(),
          fromJsonDecoded: (j) => Color(j as int),
          readCallback: (_) =>
              parent.parent._readCallback("stage_colors_lightMainPrimary"),
        ),
        lightMainPageToPrimary = Reactive.modal<Map<T, Color>?>(
          initVal: initialData.lightMainPageToPrimary,

          /// could be null
          key: parent.parent._getStoreKey(
              "${colorPlaceRef.name}stage_colors_lightMainPageToPrimary"),
          toJsonEncodable: (map) => map == null
              ? null
              : <String, dynamic>{
                  for (final entry in map.entries)
                    jsonEncode(parent.parent._writeMainPage(entry.key)):
                        entry.value.toARGB32(),
                },
          fromJsonDecoded: (j) => j == null
              ? null
              : <T, Color>{
                  for (final entry in (j as Map).entries)
                    parent.parent
                            ._readMainPage(jsonDecode(entry.key as String)):
                        Color(entry.value as int),
                },
          readCallback: (_) => parent.parent
              ._readCallback("stage_colors_lightMainPageToPrimary"),
        ),
        _cachedLightMainPageToPrimary = Reactive.modal<Map<T, Color>?>(
          initVal: null,
          key: parent.parent._getStoreKey(
              "${colorPlaceRef.name}stage_colors_lightMainPageToPrimary_CACHED"),
          toJsonEncodable: (map) => map == null
              ? null
              : <String, dynamic>{
                  for (final entry in map.entries)
                    jsonEncode(parent.parent._writeMainPage(entry.key)):
                        entry.value.toARGB32(),
                },
          fromJsonDecoded: (j) => j == null
              ? null
              : <T, Color>{
                  for (final entry in (j as Map).entries)
                    parent.parent
                            ._readMainPage(jsonDecode(entry.key as String)):
                        Color(entry.value as int),
                },
        ),
        lightPanelPrimary = Reactive.modal<Color>(
          initVal: initialData.lightPanelPrimary!,
          key: parent.parent._getStoreKey(
              "${colorPlaceRef.name}stage_colors_lightPanelPrimary"),
          toJsonEncodable: (c) => c.toARGB32(),
          fromJsonDecoded: (j) => Color(j as int),
          readCallback: (_) =>
              parent.parent._readCallback("stage_colors_lightPanelPrimary"),
        ),
        lightPanelPageToPrimary = Reactive.modal<Map<S, Color>?>(
          initVal: initialData.lightPanelPageToPrimary,

          ///could be null
          key: parent.parent._getStoreKey(
              "${colorPlaceRef.name}stage_colors_lightPanelPageToPrimary"),
          toJsonEncodable: (map) => map == null
              ? null
              : <String, dynamic>{
                  for (final entry in map.entries)
                    jsonEncode(parent.parent._writePanelPage(entry.key)):
                        entry.value.toARGB32(),
                },
          fromJsonDecoded: (j) => j == null
              ? null
              : <S, Color>{
                  for (final entry in (j as Map).entries)
                    parent.parent
                            ._readPanelPage(jsonDecode(entry.key as String)):
                        Color(entry.value as int),
                },
          readCallback: (_) => parent.parent
              ._readCallback("stage_colors_lightPanelPageToPrimary"),
        ),
        _cachedLightPanelPageToPrimary = Reactive.modal<Map<S, Color>?>(
          initVal: null,
          key: parent.parent._getStoreKey(
              "${colorPlaceRef.name}stage_colors_lightPanelPageToPrimary_CACHED"),
          toJsonEncodable: (map) => map == null
              ? null
              : <String, dynamic>{
                  for (final entry in map.entries)
                    jsonEncode(parent.parent._writePanelPage(entry.key)):
                        entry.value.toARGB32(),
                },
          fromJsonDecoded: (j) => j == null
              ? null
              : <S, Color>{
                  for (final entry in (j as Map).entries)
                    parent.parent
                            ._readPanelPage(jsonDecode(entry.key as String)):
                        Color(entry.value as int),
                },
        ),
        darkAccents = Reactive.modal<Map<DarkStyle, Color>>(
          initVal: initialData.darkAccents!,
          key: parent.parent
              ._getStoreKey("${colorPlaceRef.name}stage_colors_darkAccents"),
          toJsonEncodable: (map) => <String?, dynamic>{
            for (final entry in map.entries)
              entry.key.name: entry.value.toARGB32(),
          },
          fromJsonDecoded: (j) => <DarkStyle, Color>{
            for (final entry in (j as Map).entries)
              DarkStyle.fromName(entry.key as String):
                  Color(entry.value as int),
          },
          readCallback: (_) =>
              parent.parent._readCallback("stage_colors_darkAccents"),
        ),
        darkMainPrimaries = Reactive.modal<Map<DarkStyle, Color>>(
          initVal: initialData.darkMainPrimaries!,
          key: parent.parent._getStoreKey(
              "${colorPlaceRef.name}stage_colors_darkMainPrimaries"),
          toJsonEncodable: (map) => <String?, dynamic>{
            for (final entry in map.entries)
              entry.key.name: entry.value.toARGB32(),
          },
          fromJsonDecoded: (j) => <DarkStyle, Color>{
            for (final entry in (j as Map).entries)
              DarkStyle.fromName(entry.key as String):
                  Color(entry.value as int),
          },
          readCallback: (_) =>
              parent.parent._readCallback("stage_colors_darkMainPrimaries"),
        ),
        darkMainPageToPrimaries =
            Reactive.modal<Map<DarkStyle, Map<T, Color>>?>(
          initVal: initialData.darkMainPageToPrimaries,

          ///could be null
          key: parent.parent._getStoreKey(
              "${colorPlaceRef.name}stage_colors_darkMainPageToPrimaries"),
          toJsonEncodable: (mapOfMaps) => mapOfMaps == null
              ? null
              : <String?, dynamic>{
                  for (final e in mapOfMaps.entries)
                    e.key.name: <String, dynamic>{
                      for (final entry in e.value.entries)
                        jsonEncode(parent.parent._writeMainPage(entry.key)):
                            entry.value.toARGB32()
                    },
                },
          fromJsonDecoded: (json) => json == null
              ? null
              : <DarkStyle, Map<T, Color>>{
                  for (final e in (json as Map).entries)
                    DarkStyle.fromName(e.key as String): <T, Color>{
                      for (final entry in (e.value as Map).entries)
                        parent.parent
                                ._readMainPage(jsonDecode(entry.key as String)):
                            Color(entry.value as int),
                    }
                },
          readCallback: (_) => parent.parent
              ._readCallback("stage_colors_darkMainPageToPrimaries"),
        ),
        _cachedDarkMainPageToPrimaries =
            Reactive.modal<Map<DarkStyle, Map<T, Color>>?>(
          initVal: null,
          key: parent.parent._getStoreKey(
              "${colorPlaceRef.name}stage_colors_darkMainPageToPrimaries_CACHED"),
          toJsonEncodable: (mapOfMaps) => mapOfMaps == null
              ? null
              : <String?, dynamic>{
                  for (final e in mapOfMaps.entries)
                    e.key.name: <String, dynamic>{
                      for (final entry in e.value.entries)
                        jsonEncode(parent.parent._writeMainPage(entry.key)):
                            entry.value.toARGB32()
                    },
                },
          fromJsonDecoded: (json) => json == null
              ? null
              : <DarkStyle, Map<T, Color>>{
                  for (final e in (json as Map).entries)
                    DarkStyle.fromName(e.key as String): <T, Color>{
                      for (final entry in (e.value as Map).entries)
                        parent.parent
                                ._readMainPage(jsonDecode(entry.key as String)):
                            Color(entry.value as int),
                    }
                },
        ),
        darkPanelPrimaries = Reactive.modal<Map<DarkStyle, Color>>(
          initVal: initialData.darkPanelPrimaries!,
          key: parent.parent._getStoreKey(
              "${colorPlaceRef.name}stage_colors_darkPanelPrimaries"),
          toJsonEncodable: (map) => <String?, dynamic>{
            for (final entry in map.entries)
              entry.key.name: entry.value.toARGB32(),
          },
          fromJsonDecoded: (j) => <DarkStyle, Color>{
            for (final entry in (j as Map).entries)
              DarkStyle.fromName(entry.key as String):
                  Color(entry.value as int),
          },
          readCallback: (_) =>
              parent.parent._readCallback("stage_colors_darkPanelPrimaries"),
        ),
        darkPanelPageToPrimaries =
            Reactive.modal<Map<DarkStyle, Map<S, Color>>?>(
          initVal: initialData.darkPanelPageToPrimaries,

          ///could be null
          key: parent.parent._getStoreKey(
              "${colorPlaceRef.name}stage_colors_darkPanelPageToPrimaries"),
          toJsonEncodable: (mapOfMaps) => mapOfMaps == null
              ? null
              : <String?, dynamic>{
                  for (final e in mapOfMaps.entries)
                    e.key.name: <String, dynamic>{
                      for (final entry in e.value.entries)
                        jsonEncode(parent.parent._writePanelPage(entry.key)):
                            entry.value.toARGB32()
                    },
                },
          fromJsonDecoded: (json) => json == null
              ? null
              : <DarkStyle, Map<S, Color>>{
                  for (final e in (json as Map).entries)
                    DarkStyle.fromName(e.key as String): <S, Color>{
                      for (final entry in (e.value as Map).entries)
                        parent.parent._readPanelPage(
                                jsonDecode(entry.key as String)):
                            Color(entry.value as int),
                    }
                },
          readCallback: (_) => parent.parent
              ._readCallback("stage_colors_darkPanelPageToPrimaries"),
        ),
        _cachedDarkPanelPageToPrimaries =
            Reactive.modal<Map<DarkStyle, Map<S, Color>>?>(
          initVal: null,
          key: parent.parent._getStoreKey(
              "${colorPlaceRef.name}stage_colors_darkPanelPageToPrimaries_CACHED"),
          toJsonEncodable: (mapOfMaps) => mapOfMaps == null
              ? null
              : <String?, dynamic>{
                  for (final e in mapOfMaps.entries)
                    e.key.name: <String, dynamic>{
                      for (final entry in e.value.entries)
                        jsonEncode(parent.parent._writePanelPage(entry.key)):
                            entry.value.toARGB32()
                    },
                },
          fromJsonDecoded: (json) => json == null
              ? null
              : <DarkStyle, Map<S, Color>>{
                  for (final e in (json as Map).entries)
                    DarkStyle.fromName(e.key as String): <S, Color>{
                      for (final entry in (e.value as Map).entries)
                        parent.parent._readPanelPage(
                                jsonDecode(entry.key as String)):
                            Color(entry.value as int),
                    }
                },
        );

  //===============================
  // Getters

  bool get _isCurrentlyReading =>
      parent.parent.storeKey != null &&
      (lightAccent.modalReading ||
          lightMainPrimary.modalReading ||
          lightMainPageToPrimary.modalReading ||
          lightPanelPrimary.modalReading ||
          lightPanelPageToPrimary.modalReading ||
          darkAccents.modalReading ||
          darkMainPrimaries.modalReading ||
          darkMainPageToPrimaries.modalReading ||
          darkPanelPrimaries.modalReading ||
          darkPanelPageToPrimaries.modalReading);

  StageColorsData<T, S> get extractData => StageColorsData<T, S>._(
        allMainPagesToFill: null,
        allPanelPagesToFill: null,
        lightAccent: lightAccent.value,
        lightMainPrimary: lightMainPrimary.value,
        lightMainPageToPrimary: lightMainPageToPrimary.value,
        lightPanelPrimary: lightPanelPrimary.value,
        lightPanelPageToPrimary: lightPanelPageToPrimary.value,
        darkAccents: darkAccents.value,
        darkMainPrimaries: darkMainPrimaries.value,
        darkMainPageToPrimaries: darkMainPageToPrimaries.value,
        darkPanelPrimaries: darkPanelPrimaries.value,
        darkPanelPageToPrimaries: darkPanelPageToPrimaries.value,
      );
}
