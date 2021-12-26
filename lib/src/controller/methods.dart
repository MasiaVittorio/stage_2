part of stage;


extension StageDataExt on StageData {


  //===============================================
  // Public
  void showAlert(Widget child, {
    double? size = StageAlertDataExt.defaultAlertSize, 
    bool? replace = false,
  }) => panelController.alertController.showAlert(
    child,
    size: size ?? StageAlertDataExt.defaultAlertSize,
    replace: replace ?? false,
  );

  void pickColor({
    required void Function(Color) onSubmitted,
    Color? initialColor, 
    double? size = 500, 
  }) => showAlert(
    ColorPickerAlert(
      initialColor: initialColor, 
      onSubmitted: onSubmitted,
    ),
    size: size ?? 500,
  );

  SidereusScrollPhysics get panelScrollPhysics => panelController.panelScrollPhysics();

  Future<void> closePanel() => panelController.close();

  Future<void> closePanelCompletely() => panelController.closeCompletely();

  void openPanel() => panelController.open();

  SidereusScrollPhysics snackBarScrollPhysics({
    bool bottom = false, 
    bool always = false,
    bool never = false,
  }) => panelController.snackbarController.snackBarScrollPhysics(
    bottom: bottom,
    always: always,
    never: never,
  );

  /// duration null == it stays shown until pop
  void showSnackBar(Widget child, {
    Duration? duration = _StageSnackBarDataExt.kSnackBarDuration, 
    bool rightAligned = false,
    bool pagePersistent = false,
    VoidCallback? onManualClose,
  }) => panelController.snackbarController.show(
    child, 
    duration: duration,
    rightAligned: rightAligned,
    pagePersistent: pagePersistent,
    onManualClose: onManualClose,
  );

  Future<void> closeSnackBar() => panelController.snackbarController.close();



  //===============================================
  // Private
  void _attachListeners({
    required double Function() panelPosition,
    required double Function() panelVelocity,
    required bool Function() panelIsAnimating,
    required Future<void> Function() openPanel,
    required Future<void> Function() closePanel,

    required double Function() snackBarPosition,
    required double Function() snackBarVelocity,
    required bool Function() snackBarIsAnimating,
    required Future<void> Function() openSnackBar,
    required Future<void> Function() closeSnackBar,
  }){
    this.panelController._closeInternal = closePanel;
    this.panelController._openInternal = openPanel;
    this.panelController._getIsAnimating = panelIsAnimating;
    this.panelController._getPosition = panelPosition;
    this.panelController._getVelocity = panelVelocity;

    this.panelController.snackbarController._closeSnackInternal = closeSnackBar;
    this.panelController.snackbarController._openSnackInternal = openSnackBar;
    this.panelController.snackbarController._getSnackIsAnimating = snackBarIsAnimating;
    this.panelController.snackbarController._getSnackPosition = snackBarPosition;
    this.panelController.snackbarController._getSnackVelocity = snackBarVelocity;
  }


}

