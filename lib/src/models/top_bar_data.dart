part of stage;


class StageTopBarData {


  final Map<StageColorPlace,double> elevations;
  final Widget subtitle;
  final Alignment alignment;
  final Widget title;

  const StageTopBarData({
    @required this.title,
    this.subtitle,
    Alignment alignment,
    Map<StageColorPlace,double> elevations,
  }):
    assert(title != null),
    alignment = alignment ?? defaultAlignment,
    elevations = elevations ?? defaultElevations;

  static const Alignment defaultAlignment = Alignment.center;
  static const Map<StageColorPlace,double> defaultElevations = <StageColorPlace,double>{
    StageColorPlace.texts: 4,
    StageColorPlace.background: 8,
  };
  
}
