import 'package:stage/stage.dart';
import 'package:flutter/material.dart';


class StageBody<T> extends StatelessWidget {

  const StageBody({
    required this.children,
    this.customBackground,
  });

  final Color Function(ThemeData)? customBackground;
  final Map<T,Widget> children;

  @override
  Widget build(BuildContext context) {
    return StageBuild.offMainPagesData<T>((_, __, orderedPages, page)
      => RadioPageTransition<T?>(
        page: page, 
        children: children, 
        orderedPages: orderedPages, 
        backgroundColor: customBackground?.call(Theme.of(context)),
      ),
    );

  }

}
