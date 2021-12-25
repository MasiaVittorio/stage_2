import 'package:flutter/material.dart';
import 'package:stage/stage.dart';

class HeaderedAlertCustom extends StatelessWidget {
  
  const HeaderedAlertCustom(this.title, {
    required this.titleSize,
    required this.child,
    this.bottom,
    this.canvasBackground = false,
    this.alreadyScrollableChild = false,
    this.withoutHeader = false,
  });

  final Widget title;
  final double titleSize;
  final Widget child;
  final Widget? bottom;
  final bool alreadyScrollableChild;
  final bool canvasBackground;
  final bool withoutHeader;


  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Color background = canvasBackground
      ? theme.canvasColor
      : theme.scaffoldBackgroundColor;

    return Material(
      color: background,
       child: MediaQuery(
         data: MediaQuery.of(context).copyWith(
           padding: withoutHeader ? null : EdgeInsets.only(top: titleSize),
         ),
         child: Stack(children: <Widget>[
          Positioned.fill(child: Column(children: <Widget>[

            Expanded(child: alreadyScrollableChild ? child : SingleChildScrollView(
              physics: Stage.of(context)!.panelController.panelScrollPhysics(),
              padding: EdgeInsets.only(top: withoutHeader ? 0.0 : titleSize),
              child: child,
            ),),

            if(bottom != null)
              UpShadower(child: bottom!,),

          ],),),

          if(!withoutHeader)
            Positioned(
              top: 0.0,
              height: titleSize,
              left: 0.0,
              right: 0.0,
              child: Container(
                color: background.withOpacity(0.8),
                child: title,
              ),
            ),

      ],),
       ),
    );
  }
}
