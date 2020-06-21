import 'package:flutter/material.dart';
import 'package:sid_ui/sid_ui.dart';
import 'all.dart';
import 'package:stage/stage.dart';

class PanelTitle extends StatelessWidget {
  final String title;
  final bool twoLines;
  final bool centered;
  final bool animated;
  final bool autoClose;

  const PanelTitle(this.title, {
    this.centered = true, 
    this.twoLines = false,
    this.animated = false,
    this.autoClose = true,
  }): assert(centered != null);

  static const double _minHeight = 30.0;
  static const double _minHeightTwoLines = 55.0;

  static const double height = AlertComponents.drag 
    ? _minHeight + AlertDrag.height 
    : _minHeight;

  static const double twoLinesHeight = AlertComponents.drag 
    ? _minHeightTwoLines + AlertDrag.height 
    : _minHeightTwoLines;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextStyle style = DefaultTextStyle.of(context).style;
    final StageData stage = Stage.of(context);

    final title = Container(
      height: twoLines 
        ? _minHeightTwoLines
        : _minHeight,
      alignment: this.centered 
        ? Alignment.center 
        : AlignmentDirectional.centerStart,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: animated 
          ? AnimatedText(
            this.title,
            textAlign: this.centered ? TextAlign.center : TextAlign.start,
            maxLines: this.twoLines ? 2: 1, 
            overflow: TextOverflow.ellipsis,
            style: style.copyWith(
              color: RightContrast(
                theme, 
                fallbackOnTextTheme: true
              ).onCanvas,
              fontWeight: style.fontWeight.increment,
            ),
          )
          : Text(
            this.title,
            textAlign: this.centered ? TextAlign.center : TextAlign.start,
            maxLines: this.twoLines ? 2: 1, 
            overflow: TextOverflow.ellipsis,
            style: style.copyWith(
              color: RightContrast(
                theme, 
                fallbackOnTextTheme: true
              ).onCanvas,
              fontWeight: style.fontWeight.increment,
            ),
          ),
      ),
    );

    return Material(
      type: MaterialType.transparency,
      child: InkResponse(
        onTap: (autoClose ?? false) 
          ? () => stage.panelController.close()
          : null,
        child: Container(
          alignment: Alignment.center,
          height: this.twoLines ? twoLinesHeight : height,
          child: AlertComponents.drag 
            ? Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const AlertDrag(),
                title,
              ],
            )
            : title,
        ),
      ),
    );
  }
}