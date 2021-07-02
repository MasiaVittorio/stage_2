import 'package:sid_ui/sid_ui.dart';
import 'package:stage/stage.dart';
import 'package:flutter/material.dart';

class StageTopBarTitle<T,S> extends StatelessWidget {

  const StageTopBarTitle({this.panelTitle});

  /// If the panel does not have pages of its own, or if you want to override those titles nonetheless
  final String? panelTitle;
  
  @override
  Widget build(BuildContext context) {
    final StageData<T,S> stage = Stage.of<T,S>(context)!;
    final Map<S?,StagePage?>? panelPagesData = stage.panelPagesController?.pagesData;
    final Map<T?,StagePage?>? mainPagesData = stage.mainPagesController!.pagesData;

    return StageBuild.offOpenNonAlertAndPages((_, openNonAlert, dynamic mainPage, dynamic panelPage){
      return AnimatedText(
        openNonAlert 
          ? panelTitle ?? ((panelPagesData == null) ? "Not specified!" : panelPagesData[panelPage]!.longName)
          : mainPagesData![mainPage]!.longName,
      );
    });
  }
}