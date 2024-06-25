part of 'package:stage/stage.dart';

class _StageDimensionsData {
  //================================
  // Disposer
  void dispose() {
    dimensions.dispose();
  }

  //================================
  // Values
  final StageData parent;

  final Reactive<StageDimensions> dimensions;

  //================================
  // Constructor
  _StageDimensionsData(
    this.parent, {
    required StageDimensions initialDimensions,
  }) : dimensions = Reactive.modal<StageDimensions>(
          initVal: initialDimensions,
          key: parent._getStoreKey("stage_dimensions"),
          toJsonEncodable: (dim) => dim.json,
          fromJsonDecoded: (json) => StageDimensions.fromJson(json),
          readCallback: (_) => parent._readCallback("stage_dimensions"),
        );

  //===========================================
  // Getters
  bool get _isCurrentlyReading => parent.storeKey != null && (dimensions.modalReading);
}
