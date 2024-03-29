import 'package:flutter/material.dart';
import 'package:stage/stage.dart';

class Alternative {
  final Color? color;
  final String title;
  final VoidCallback action;
  final IconData icon;
  final bool autoClose;
  final bool completelyAutoClose;
  const Alternative({
    required this.title,
    required this.icon,
    required this.action,
    this.autoClose = false,
    this.completelyAutoClose = false,
    this.color,
  });
}

class AlternativesAlert extends StatelessWidget {

  final String label;

  final List<Alternative> alternatives;


  final bool twoLinesLabel;

  static const double tileSize = 56.0;
  static double heightCalc(int alts) => tileSize * alts + PanelTitle.height;
  static double twoLinesheightCalc(int alts) => tileSize * alts + PanelTitle.twoLinesHeight;

  AlternativesAlert({
    required this.alternatives,
    required this.label,
    this.twoLinesLabel = false,
  }): assert(alternatives.isNotEmpty);

  @override
  Widget build(BuildContext context) {
    final stage = Stage.of(context);
    return IconTheme(
      data: IconThemeData(opacity: 1.0, color: Theme.of(context).colorScheme.onSurface),
      child: Material(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[

            PanelTitle(label, twoLines: twoLinesLabel,),

            for(final alt in alternatives)
              ListTile(
                onTap: (){
                  if(alt.completelyAutoClose){
                    stage!.panelController.closeCompletely();
                  } else if(alt.autoClose){
                    stage!.panelController.close();
                  }
                  alt.action();
                },
                leading: Icon(
                  alt.icon,
                  color: alt.color,
                ),
                title: Text(
                  alt.title,
                  style: TextStyle(color: alt.color),
                ),
              ),

          ],
        ),
      ),
    );
  }

}