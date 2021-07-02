part of stage;

extension _StageSnackBarDataExt on _StageSnackBarData {

  //=======================
  // Getters
  double get position {
    assert(this._getSnackPosition != null, _StagePanelData._warning);
    return this._getSnackPosition!();
  }

  double get velocity {
    assert(this._getSnackVelocity != null, _StagePanelData._warning);
    return this._getSnackVelocity!();
  }

  bool get isAnimating {
    assert(this._getSnackIsAnimating != null, _StagePanelData._warning);
    return this._getSnackIsAnimating!();
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
    VoidCallback? onManualClose,
  }) async {
    assert(_openSnackInternal != null, _StagePanelData._warning);
    
    ++snackBarId;
    if(pagePersistent ?? false) _pagePersistentSnackBarId = snackBarId;
    if(parent.isMostlyOpened.value){
      parent._onNextClose.add(() => _realShow(child, duration, rightAligned));
    } else {
      _realShow(child, duration, rightAligned);
    }
    if(onManualClose != null){
      _onNextManualClose.add(onManualClose);
    }
  }

  void _realShow(Widget newChild, Duration duration, bool rightAligned) async {

    if(this.position > 0.0){
      this.child.value = null; // so it is not set to null in close()
      await close();
    }

    snackBarRightAligned = rightAligned ?? false; /// Changing this before showing snackbar so the build methods get it right

    this.child.set(newChild);
    await _openSnackInternal!();
    _delaySnackBarClosure(duration, snackBarId);
  }
  
  Future<void> close() async {
    assert(_closeSnackInternal != null, _StagePanelData._warning);

    ++snackBarId;

    if(position != 0.0){
      if(!isAnimating || velocity > 0){
        await _closeSnackInternal!();
        _onNextSnackClose.forEach((f) => f?.call());
        _onNextSnackClose.clear();
        _onNextManualClose.clear();
      }
    } 

    if(child.value != null){
      if(position == 0.0){
        child.set(null);
      }
    }
    return Future.value();

  }

  void onNextSnackClose(VoidCallback callback){
    if(callback != null){
      _onNextSnackClose.add(callback);
    }
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