part of stage;

extension StagePanelDataExt on _StagePanelData {

  //=======================
  // Getters
  double get position {
    assert(this._getPosition != null, _StagePanelData._warning);
    return this._getPosition();
  }

  double get velocity {
    assert(this._getVelocity != null, _StagePanelData._warning);
    return this._getVelocity();
  }
  
  bool get isAnimating {
    assert(this._getIsAnimating != null, _StagePanelData._warning);
    return this._getIsAnimating();
  }

  SidereusScrollPhysics panelScrollPhysics() => SidereusScrollPhysics(
    topBounce: true,
    topBounceCallback: this.close,
    alwaysScrollable: false,
    neverScrollable: false,
  );



  //=======================
  // Public
  Future<void> close() async {
    assert(_closeInternal != null, _StagePanelData._warning);
    await _closeInternal();
    _closedRoutine();
    return;
  }

  void closeCompletely(){
    assert(_closeInternal != null, _StagePanelData._warning);
    _closeInternal().then((_){
      _completelyClosedRoutine();
    });
  }

  void open(){
    assert(_openInternal != null, _StagePanelData._warning);
    _openInternal().then((_){
      _openedRoutine();
    });
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
    _forgetPanelPage();
    onPanelClose?.call();
    for(final c in _onNextClose){
      c();
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
    double _vel = - details.velocity.pixelsPerSecond.dy;
    if(_vel.abs() >= minFlingVelocity){
      
      if(_vel < 0){
        close();
        return;
      } else if(_vel > 0){
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