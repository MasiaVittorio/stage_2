part of stage;


class StageTopBarData {


  final double elevation;
  final Widget subtitle;
  final Alignment alignment;
  final Widget title;

  const StageTopBarData({
    @required this.title,
    this.subtitle,
    Alignment alignment,
    double elevation,
  }):
    assert(title != null),
    alignment = alignment ?? defaultAlignment,
    elevation = elevation ?? defaultElevation;

  static const Alignment defaultAlignment = Alignment.center;
  static const double defaultElevation = 4.0;
  
}
