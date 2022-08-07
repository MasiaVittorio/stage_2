part of stage;

// ignore: library_private_types_in_public_api
extension StagePanelDataExt on _StagePanelData {

  //=======================
  // Getters
  double get position {
    assert(_getPosition != null, _StagePanelData._warning);
    return _getPosition!();
  }

  double get velocity {
    assert(_getVelocity != null, _StagePanelData._warning);
    return _getVelocity!();
  }
  
  bool get isAnimating {
    assert(_getIsAnimating != null, _StagePanelData._warning);
    return _getIsAnimating!();
  }

  SidereusScrollPhysics panelScrollPhysics() => SidereusScrollPhysics(
    topBounce: true,
    topBounceCallback: close,
    alwaysScrollable: false,
    neverScrollable: false,
  );



  //=======================
  // Public
  Future<void> close() async {
    assert(_closeInternal != null, _StagePanelData._warning);
    await _closeInternal!();
    _closedRoutine();
    return;
  }

  Future<void> closeCompletely() async {
    assert(_closeInternal != null, _StagePanelData._warning);
    await _closeInternal!();
    _completelyClosedRoutine();
  }

  Future<void> open() async {
    assert(_openInternal != null, _StagePanelData._warning);
    await _openInternal!();
    _openedRoutine();
  }

  void onNextSnackBarClose(VoidCallback callback)
    => snackbarController.onNextSnackClose(callback);

  void onNextPanelClose(VoidCallback callback){
    _onNextClose.add(callback);
  }


  //=======================
  // Private
  void _closedRoutine(){
    if(position == 0.0){

      final bool reopened = alertController._closedAlertRoutine();

      if(!reopened){
        _confirmClosed();
      }

    }
  }


  void _completelyClosedRoutine(){
    if(position == 0.0){
      alertController._completelyCloseAlertRoutine();
      _confirmClosed();
    }
  }

  void _confirmClosed(){
    alertController.savedStates.clear();
    _forgetPanelPage();
    onPanelClose?.call();
    for(final c in _onNextClose){
      c.call();
    }
    _onNextClose.clear();
    alertController.previouslyOpenedPanel = false;
  }

  void _forgetPanelPage(){
    if(parent.panelPagesController == null) return;
    if(
      parent.popBehavior.rememberPanelPage != true &&
      parent.panelPagesController?.defaultPage != null 
    ){
      parent.panelPagesController?.goToPage(parent.panelPagesController?.defaultPage);
    }
  }

  void _openedRoutine(){
    if(position == 1.0){
      onPanelOpen?.call();
    }
  }



  static const double minFlingVelocity = 365.0;

  void _onPanelDragEnd(DragEndDetails details){

    //let the current animation finish before starting a new one
    if(isAnimating){
      //can happen if you swipe up and down like a maniac
      return;
    }

    //check if the velocity is sufficient to constitute fling
    double vel = - details.velocity.pixelsPerSecond.dy;
    if(vel.abs() >= minFlingVelocity){
      
      if(vel < 0){
        close();
        return;
      } else if(vel > 0){
        open();
        return;
      } else {
        assert(false);
        return;
      }
      
    } else {
      final val = position;
      if(val >= openedThreshold){
        open();
        return;
      } else if(val <= closedThreshold){
        close();
        return;
      } else {
        if(isMostlyOpened.value){
          open();
          return;
        } else {
          close();
          return;
        }
      }
    }

  }


}