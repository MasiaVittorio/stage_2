import 'package:flutter/material.dart';
import 'all.dart';

class AlertTitleCustom extends StatelessWidget {
  final Widget title;

  const AlertTitleCustom(this.title);

  @override
  Widget build(BuildContext context) {
    if(AlertComponents.drag){
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const AlertDrag(),
          title,
        ],
      );
    } else return title;
  }
}