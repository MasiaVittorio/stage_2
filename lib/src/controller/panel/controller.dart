part of 'package:stage/stage.dart';

class _StagePanelData {
  //================================
  // Disposer
  void dispose() {
    isMostlyOpened.dispose();
    alertController.dispose();
    snackbarController.dispose();
  }

  //================================
  // Values
  final StageData parent;

  /// To be checked and updated every time the panel scrolls
  final Reactive<bool> isMostlyOpened = Reactive<bool>(false);

  /// Derived
  late Reactive<bool> isMostlyOpenedNonAlert;

  /// Callbacks to be attached from the widget
  /// (that contains the animation controller that drives the panel)
  Future<void> Function()? _openInternal;
  Future<void> Function()? _closeInternal;
  double Function()? _getPosition;
  double Function()? _getVelocity;
  bool Function()? _getIsAnimating;

  late _StageAlertData alertController;

  /// Showing alerts and stuff
  late _StageSnackBarData snackbarController;

  /// Showing snacbkars and stuff

  // Data
  final VoidCallback? onPanelClose;
  final List<VoidCallback> _onNextClose = <VoidCallback>[];
  final VoidCallback? onPanelOpen;
  final double openedThreshold;
  final double closedThreshold;

  //================================
  // Constructor
  _StagePanelData(
    this.parent, {
    required StagePanelData initialData,

    /// Could be null
  })  : onPanelClose = initialData.onPanelClose,
        onPanelOpen = initialData.onPanelOpen,
        openedThreshold = initialData.openedThreshold,
        closedThreshold = initialData.closedThreshold {
    alertController = _StageAlertData(this);
    snackbarController = _StageSnackBarData(this);

    isMostlyOpenedNonAlert = (
      alertController.isShowing,
      isMostlyOpened,
    ).related((bool alert, bool open) => open && !alert);
  }

  //===========================================
  // Static
  static const String _warning = "this panel controller is not attached to a widget";
}
