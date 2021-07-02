part of stage;


class StageTopBarContent {

  final Widget? subtitle;

  final Alignment alignment;
  static const Alignment defaultAlignment = Alignment.center;

  final Widget title;

  const StageTopBarContent({
    required this.title,
    this.subtitle,
    Alignment? alignment,
    Map<StageColorPlace,double>? elevations,
  }): alignment = alignment ?? defaultAlignment;
  
}
