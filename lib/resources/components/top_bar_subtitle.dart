import 'package:sid_ui/sid_ui.dart';
import 'package:stage/stage.dart';
import 'package:flutter/material.dart';

class StageTopBarSubtitle<S> extends StatelessWidget {

  const StageTopBarSubtitle(this.getSubTitle);
  final String Function(S) getSubTitle;
  
  @override
  Widget build(BuildContext context) {
    return StageBuild.offPanelPage<S>((_, S panelPage)
      => AnimatedText(getSubTitle(panelPage)),
    );
  }
}