part of stage;

extension StageBrightnessDataExt on _StageBrightnessData {

  //==========================================
  // Public

  void enableAutoDark(BuildContext context){
    if(autoDark.setDistinct(true)){ // If it was false before
      this._updateBrightness(context);
    }
  }

  void disableAutoDark(Brightness toBrightness){
    this.autoDark.setDistinct(false);
    this.brightness.setDistinct(toBrightness);
  }


  void autoDarkBasedOnTime(){
    if(this.autoDarkMode.setDistinct(AutoDarkMode.timeOfDay)){
      this._updateBrightness(null);
    }
  }

  void autoDarkBasedOnSystem(BuildContext context){
    if(this.autoDarkMode.setDistinct(AutoDarkMode.system)){
      this._updateBrightness(context);
    }
  }




  //========================================
  // Private
  void _checkBrightness<T,S>(BuildContext context){

    if(autoDark.modalReading){
      (autoDark as PersistentVar).readCallback = ((_) => _updateBrightness(context));
    }
    if(autoDarkMode.modalReading){
      (autoDarkMode as PersistentVar).readCallback = ((_) => _updateBrightness(context));
    }

    _updateBrightness(context);
  }

  void _updateBrightness(BuildContext context) => SchedulerBinding.instance.addPostFrameCallback((_){
    if(!autoDark.value) return; // checking this first because it can happen more often than reading
    if(autoDarkMode.modalReading) return;
    if(autoDark.modalReading) return;

    this.brightness.setDistinct(
      autoDarkMode.value.currentBrightness(context != null ? MediaQuery.of(context) : null)
      /// It is very crucial to call this MediaQuery.of(context) here and not before the postFrameCallback.
      /// Because this method is called in the initState of the Stage itself so it may be detrimental to access
      /// the .of(context) during that frame.
    );
  });

}

extension _ModalReading on BlocVar {
  bool get modalReading {
    if(this is PersistentVar){
      return (this as PersistentVar).reading;
    }
    return false;
  }
}