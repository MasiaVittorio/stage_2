part of stage;


class _StagePanelData {

  //================================
  // Disposer
  void dispose(){
    isMostlyOpened.dispose();
    alertController.dispose();
    snackbarController.dispose();
  }


  //================================
  // Values
  final StageData parent;

  /// To be checked and updated every time the panel scrolls
  final BlocVar<bool> isMostlyOpened = BlocVar<bool>(false);

  /// Derived
  late BlocVar<bool> isMostlyOpenedNonAlert;

  /// Callbacks to be attached from the widget 
  /// (that contains the animation controller that drives the panel)
  Future<void> Function()? _openInternal;
  Future<void> Function()? _closeInternal;
  double Function()? _getPosition;
  double Function()? _getVelocity;
  bool Function()? _getIsAnimating;

  late _StageAlertData alertController; /// Showing alerts and stuff
  late _StageSnackBarData snackbarController; /// Showing snacbkars and stuff

  // Data
  final VoidCallback? onPanelClose;
  final List<VoidCallback> _onNextClose = <VoidCallback>[];
  final VoidCallback? onPanelOpen;
  final double openedThreshold;
  final double closedThreshold;

  //================================
  // Constructor
  _StagePanelData(this.parent,{
    required StagePanelData initialData, /// Could be null
  }): 
    onPanelClose = initialData.onPanelClose,
    onPanelOpen = initialData.onPanelOpen,
    openedThreshold = initialData.openedThreshold,
    closedThreshold = initialData.closedThreshold
  {
    alertController = _StageAlertData(this);
    snackbarController = _StageSnackBarData(this);

    isMostlyOpenedNonAlert = BlocVar.fromCorrelateLatest2<bool, bool, bool>(
      alertController.isShowing!,
      isMostlyOpened,
      map: (bool alert, bool open) => open && !alert,
    );
  }


  //===========================================
  // Static
  static const String _warning = "this panel controller is not attached to a widget";


}

