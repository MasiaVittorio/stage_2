part of stage;


class StageTopBarContent {


  final Widget subtitle;
  final Alignment alignment;
  final Widget title;

  const StageTopBarContent({
    @required this.title,
    this.subtitle,
    Alignment alignment,
    Map<StageColorPlace,double> elevations,
  }):
    assert(title != null),
    alignment = alignment ?? defaultAlignment;

  static const Alignment defaultAlignment = Alignment.center;
  
}
