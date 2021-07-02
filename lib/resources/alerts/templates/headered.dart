import 'package:flutter/material.dart';
import 'package:stage/stage.dart';

class HeaderedAlert extends StatelessWidget {

  const HeaderedAlert(this.title, {
    required this.child,
    this.bottom,
    this.alreadyScrollableChild = false,
    this.canvasBackground = false,
    this.withoutHeader = false,
    this.customTitleColor,
  });

  final String title;
  final Widget child;
  final Widget? bottom;
  final bool alreadyScrollableChild;
  final bool canvasBackground;
  final bool withoutHeader;
  final Color? customTitleColor;

  @override
  Widget build(BuildContext context) {
    return HeaderedAlertCustom(
      PanelTitle(title, animated: true, customColor: customTitleColor), 
      titleSize: PanelTitle.height, 
      child: this.child,
      bottom: this.bottom,
      alreadyScrollableChild: this.alreadyScrollableChild,
      canvasBackground: this.canvasBackground,
      withoutHeader: this.withoutHeader ?? false,
    );
  }
}
