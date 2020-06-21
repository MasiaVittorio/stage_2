part of stage;


class _StageDimensionsData {

  //================================
  // Disposer
  void dispose(){
    dimensions?.dispose();
  }



  //================================
  // Values
  final StageData parent;

  final BlocVar<StageDimensions> dimensions;

  //================================
  // Constructor
  _StageDimensionsData(this.parent, {
    @required StageDimensions initialDimensions,
  }):
    assert(initialDimensions != null), 
    dimensions = BlocVar.modal<StageDimensions>(
      initVal: initialDimensions,
      key: parent._getStoreKey("stage_dimensions"), 
      toJson: (dim) => dim.json,
      fromJson: (json) => StageDimensions.fromJson(json),
      readCallback: (_) => parent._readCallback("stage_dimensions"),
    );


  //===========================================
  // Getters
  bool get _isCurrentlyReading => parent.storeKey != null && (
    this.dimensions.modalReading
  );

}