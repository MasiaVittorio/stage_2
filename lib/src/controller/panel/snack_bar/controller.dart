part of stage;


typedef StageSnackBarShower = Future<void> Function(Widget, Duration, bool);

class _StageSnackBarData {

  //================================
  // Disposer
  void dispose(){
    child?.dispose();
    isShowing?.dispose();
  }


  //=====================================
  // Values
  final _StagePanelData parent;

  bool snackBarRightAligned = false;
  
  BlocVar<Widget> child = BlocVar<Widget>(null);
  int snackBarId = 0; 
  /// ++snackBarId one every snackbar you show, so the delayed closure does not close 
  /// a new snackbar (if it was manually closed and reopened in some way)
  
  int _pagePersistentSnackBarId;

  /// Derived
  BlocVar<bool> isShowing;

  /// Callbacks to be attached from the widget 
  /// (that contains the animation controller that drives the panel)
  Future<void> Function() _openSnackInternal; /// This future completes as soon as the SnackBar is opened, not closed
  Future<void> Function() _closeSnackInternal;
  double Function() _getSnackPosition;
  double Function() _getSnackVelocity;
  bool Function() _getSnackIsAnimating;

  /// Data
  final List<VoidCallback> _onNextSnackClose = <VoidCallback>[];
  final List<VoidCallback> _onNextManualClose = <VoidCallback>[];
  

  //========================================
  // Constructor
  _StageSnackBarData(this.parent){
    isShowing = BlocVar.fromCorrelate<bool,Widget>(
      from: child, 
      map: (c) => c != null
    );
  }


}