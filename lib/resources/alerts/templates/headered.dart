import 'package:flutter/material.dart';
import 'package:stage/stage.dart';

class HeaderedAlert extends StatelessWidget {

  const HeaderedAlert(this.title, {
    required this.child,
    this.bottom,
    this.alreadyScrollableChild = false,
    this.customBackground,
    this.withoutHeader = false,
    this.customTitleColor,
  });

  final String title;
  final Widget child;
  final Widget? bottom;
  final bool alreadyScrollableChild;
  final Color Function(ThemeData)? customBackground;
  final bool withoutHeader;
  final Color? customTitleColor;

  @override
  Widget build(BuildContext context) {
    return HeaderedAlertCustom(
      PanelTitle(title, animated: true, customColor: customTitleColor), 
      titleSize: PanelTitle.height,
      bottom: bottom,
      alreadyScrollableChild: alreadyScrollableChild,
      customBackground: customBackground,
      withoutHeader: withoutHeader, 
      child: child,
    );
  }
}
