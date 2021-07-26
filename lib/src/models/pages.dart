part of stage;


class StagePage {

  final String name;
  final String longName;
  final IconData icon;
  final IconData? unselectedIcon;

  const StagePage({
    required this.name,
    String? longName,
    required this.icon,
    this.unselectedIcon,
  }): longName = longName ?? name;

  StagePage copyWith({
    String? name,
    String? longName,
    Color? primaryColor,
    IconData? icon,
    IconData? unselectedIcon,
  })=> StagePage(
    name: name ?? this.name,
    longName: longName ?? this.longName,
    icon: icon ?? this.icon,
    unselectedIcon: unselectedIcon ?? this.unselectedIcon,
  );

  static bool compare(StagePage first, StagePage second){
    if(first.name != second.name)
      return false;
    if(first.longName != second.longName)
      return false;
    if(first.icon != second.icon)
      return false;
    if(first.unselectedIcon != second.unselectedIcon)
      return false;
    return true;
  }

}