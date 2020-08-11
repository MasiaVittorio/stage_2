import 'package:stage/stage.dart';
import 'package:flutter/material.dart';
import 'package:sid_ui/sid_ui.dart';

class StageSinglePrimaryColor extends StatelessWidget {

  const StageSinglePrimaryColor({
    this.extraChildren,
  });

  final List<Widget> extraChildren;

  @override
  Widget build(BuildContext context) {
    
    final StageData stage = Stage.of(context);

    return StageBuild.offMainColors((_, singleMain, __){
        
      // singlePanel should be equal to singleMain, 
      // if not the next pick will make them equal

      final List<Widget> children = <Widget>[
        ListTile(
          title: const Text("Primary"),
          leading: ColorCircleDisplayer(singleMain),
          onTap: () => stage.pickColor(
            initialColor: singleMain,
            onSubmitted: (Color color){
              stage.themeController.currentColorsController.editMainPrimary(color);
              stage.themeController.currentColorsController.editPanelPrimary(color);
            },
          ),
        ),
        ...(extraChildren ?? const <Widget>[]),
      ];

      return Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          for(final List<Widget> couple in children.part(2))
            Row(children: <Widget>[
              for(final child in couple)
                Expanded(child: child),
            ],),
        ],
      );

    },);
  }


}



