part of 'package:stage/stage.dart';

class _StageBrightnessData {
  //================================
  // Disposer
  void dispose() {
    brightness.dispose();
    darkStyle.dispose();
    autoDark.dispose();
    autoDarkMode.dispose();
  }

  //================================
  // Values
  final _StageThemeData parent;

  //============================================
  // Actual State
  final Reactive<Brightness> brightness;
  final Reactive<DarkStyle> darkStyle;

  //============================================
  // Behavior (pseudo state, provide mediaquery to update manually)
  final Reactive<bool> autoDark;
  final Reactive<AutoDarkMode> autoDarkMode;

  ///wether the automatic light/dark switch has to be decided upon time
  ///  of day (current hour between 7 and 20) or system's mediaquery -> preferred brightness

  //===============================
  // Constructor
  _StageBrightnessData(
    this.parent, {
    required StageBrightnessData initialData,
  })  : brightness = Reactive.modal<Brightness>(
          initVal: initialData.brightness ?? StageBrightnessData.defaultBrightness,
          key: parent.parent._getStoreKey("stage_brightness_brightness"),
          toJsonEncodable: (b) => b.name,
          fromJsonDecoded: (j) => _Brightness.fromName(j as String?)!,
          readCallback: (_) => parent.parent._readCallback("stage_brightness_brightness"),
        ),
        autoDark = Reactive.modal<bool>(
          initVal: initialData.autoDark ?? StageBrightnessData.defaultAutoDark,
          key: parent.parent._getStoreKey("stage_brightness_aautoDark"),
          toJsonEncodable: (b) => b,
          fromJsonDecoded: (j) => j as bool,
          readCallback: (_) => parent.parent._readCallback("stage_brightness_aautoDark"),
          //WARNING: this read callback is never called, cannot figure out why the fuck
        ),
        autoDarkMode = Reactive.modal<AutoDarkMode>(
          initVal: initialData.autoDarkMode ?? StageBrightnessData.defaultAutoDarkMode,
          key: parent.parent._getStoreKey("stage_brightness_autoDarkMode"),
          toJsonEncodable: (auto) => auto.name,
          fromJsonDecoded: (j) => _AutoDarkMode.fromName(j as String)!,
          readCallback: (_) => parent.parent._readCallback("stage_brightness_autoDarkMode"),
          //WARNING: this read callback is never called, cannot figure out why the fuck
        ),
        darkStyle = Reactive.modal<DarkStyle>(
          initVal: initialData.darkStyle ?? StageBrightnessData.defaultDarkStyle,
          key: parent.parent._getStoreKey("stage_brightness_darkStyle"),
          toJsonEncodable: (style) => style.name,
          fromJsonDecoded: (j) => DarkStyle.fromName(j as String),
          readCallback: (_) => parent.parent._readCallback("stage_brightness_darkStyle"),
        );

  //==============================
  // Getters
  bool get _isCurrentlyReading =>
      parent.parent.storeKey != null &&
      (autoDark.modalReading ||
          autoDarkMode.modalReading ||
          brightness.modalReading ||
          darkStyle.modalReading);

  StageBrightnessData get extractData => StageBrightnessData._(
        autoDark: autoDark.value,
        brightness: brightness.value,
        darkStyle: darkStyle.value,
        autoDarkMode: autoDarkMode.value,
      );
}
