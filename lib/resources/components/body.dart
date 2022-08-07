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

    final StageData<T,dynamic>? stage = Stage.of<T,dynamic>(context);
  
    return StageBuild.offMainPagesData<T>((_, __, orderedPages, page)
      => RadioPageTransition<T?>(
        previous: stage!.mainPagesController.previousPage,
        page: page, 
        children: children, 
        orderedPages: orderedPages, 
        backgroundColor: customBackground?.call(Theme.of(context)),
      ),
    );

  }

}
