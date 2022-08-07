// import 'package:sid_ui/sid_ui.dart';
import 'package:stage/stage.dart';
import 'package:flutter/material.dart';
// import 'page_transition.dart';

class StageExtendedPanel<S> extends StatelessWidget {

  const StageExtendedPanel({
    required this.children,
    this.customBackground, // If false, scaffold background is used
  });

  final Map<S,Widget> children;
  final Color Function(ThemeData)? customBackground;

  @override
  Widget build(BuildContext context) {

    final StageData<dynamic,S>? stage = Stage.of<dynamic,S>(context);
  
    return StageBuild.offPanelPagesData<S>((_, __, orderedPages, page){
      final S? previous = stage!.panelPagesController!.previousPage;
      return RadioPageTransition<S?>(
        page: page, 
        previous: previous, 
        children: children, 
        orderedPages: orderedPages,
        backgroundColor: customBackground?.call(Theme.of(context)),
      );
    },);

  }

}


