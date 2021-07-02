part of stage;


class StageTopBarData {

  final Map<StageColorPlace,double> elevations;

  const StageTopBarData({
    Map<StageColorPlace,double>? elevations,
  }):
    elevations = elevations ?? defaultElevations;

  static const Map<StageColorPlace,double> defaultElevations = <StageColorPlace,double>{
    StageColorPlace.texts: 4,
    StageColorPlace.background: 8,
  };
  
}
