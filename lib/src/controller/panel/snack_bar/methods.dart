part of stage;

extension _StageSnackBarDataExt on _StageSnackBarData {

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

  SidereusScrollPhysics snackBarScrollPhysics({
    bool bottom = false, 
    bool always = false,
    bool never = false,
  }) => (bottom??false) 
    ? SidereusScrollPhysics(
      bottomBounce: true,
      bottomBounceCallback: this.close,
      alwaysScrollable: always ?? false,
      neverScrollable: never ?? false,
    ) : SidereusScrollPhysics(
      topBounce: true,
      topBounceCallback: this.close,
      alwaysScrollable: always ?? false,
      neverScrollable: never ?? false,
    );


  //=======================
  // Public

  static const Duration kSnackBarDuration = Duration(seconds: 3);
  
  /// duration null == it stays shown until pop
  void show(Widget child, {
    Duration duration = kSnackBarDuration, 
    bool rightAligned = false,
    bool pagePersistent = false,
  }) async {
    assert(_openInternal != null, _StagePanelData._warning);
    
    ++snackBarId;
    if(pagePersistent ?? false) _pagePersistentSnackBarId = snackBarId;
    if(parent.isMostlyOpened.value){
      parent._onNextClose.add(() => _realShow(child, duration, rightAligned));
    } else {
      _realShow(child, duration, rightAligned);
    }
  }

  void _realShow(Widget newChild, Duration duration, bool rightAligned) async {

    if(this.position > 0.0){
      this.child.value = null; // so it is not set to null in close()
      await close();
    }

    snackBarRightAligned = rightAligned ?? false; /// Changing this before showing snackbar so the build methods get it right

    this.child.set(newChild);
    await _openInternal();
    _delaySnackBarClosure(duration, snackBarId);
  }
  
  Future<void> close() async {
    assert(_closeInternal != null, _StagePanelData._warning);

    ++snackBarId;

    if(position != 0.0){
      if(!isAnimating || velocity > 0){
        await _closeInternal();
      }
    } 

    if(child.value != null){
      if(position == 0.0){
        child.set(null);
      }
    }
    return Future.value();

  }



  //======================================
  // Private


  void _delaySnackBarClosure(Duration duration, int oldId) async {
    if(duration != null){ 
      /// Duration null == it stays shown until pop
      await Future.delayed(duration);
      
      if(!isAnimating && oldId == snackBarId){
        this.close();
      }
    } 
  }



}