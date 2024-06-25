part of 'package:stage/stage.dart';

// ignore: library_private_types_in_public_api
extension StageBrightnessDataExt on _StageBrightnessData {
  //==========================================
  // Public

  void enableAutoDark(BuildContext context) {
    if (autoDark.update(true)) {
      // If it was false before
      _updateBrightness(context);
    }
  }

  void disableAutoDark(Brightness toBrightness) {
    autoDark.update(false);
    brightness.update(toBrightness);
  }

  void autoDarkBasedOnTime() {
    if (autoDarkMode.update(AutoDarkMode.timeOfDay)) {
      _updateBrightness(null);
    }
  }

  void autoDarkBasedOnSystem(BuildContext context) {
    if (autoDarkMode.update(AutoDarkMode.system)) {
      _updateBrightness(context);
    }
  }

  //========================================
  // Private
  void _checkBrightness<T, S>(BuildContext context) {
    if (autoDark case PersistentReactive aD) {
      aD.accessAfterReading((_) => _updateBrightness(context));
    }
    if (autoDarkMode case PersistentReactive aDM) {
      aDM.accessAfterReading((_) => _updateBrightness(context));
    }
    _updateBrightness(context);
  }

  void _updateBrightness(BuildContext? context) =>
      SchedulerBinding.instance.addPostFrameCallback((_) {
        if (!autoDark.value) {
          return; // checking this first because it can happen more often than reading
        }
        if (autoDarkMode.modalReading) return;
        if (autoDark.modalReading) return;

        brightness.update(
            autoDarkMode.value.currentBrightness(context != null ? MediaQuery.of(context) : null)

            /// It is very crucial to call this MediaQuery.of(context) here and not before the postFrameCallback.
            /// Because this method is called in the initState of the Stage itself so it may be detrimental to access
            /// the .of(context) during that frame.
            );
      });
}

extension _ModalReading on Reactive? {
  bool get modalReading {
    if (this case PersistentReactive persistent) {
      return !persistent.finishedReading;
    }
    return false;
  }
}
