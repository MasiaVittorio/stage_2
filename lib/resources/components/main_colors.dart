import 'package:stage/stage.dart';
import 'package:flutter/material.dart';
import 'package:sid_ui/sid_ui.dart';

class StageMainColors<T> extends StatelessWidget {

  const StageMainColors({
    this.switchPagesVsSingle = false,
    this.extraChildren,
  });

  final bool switchPagesVsSingle;
  final List<Widget> extraChildren;

  @override
  Widget build(BuildContext context) 
    => StageBuild.offMainColors<T>((_, singleColor, pageColors) {
      
      final Widget child = pageColors != null
        ? StageMainColorsPerPage<T>(extraChildren: extraChildren)
        : StageMainSingleColor(extraChildren: extraChildren);

      if(switchPagesVsSingle ?? false){
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            _MultiPageColorsToggleMain<T>(),
            child,    
          ],
        );
      } else {
        return child;
      }

    },);


}

class StageMainColorsPerPage<T> extends StatelessWidget {

  const StageMainColorsPerPage({this.extraChildren = const <Widget>[]});

  final List<Widget> extraChildren;

  @override
  Widget build(BuildContext context) {

    final StageData<T,dynamic> stage = Stage.of<T,dynamic>(context);
    final Map<T,StagePage> pagesData = stage.mainPagesController.pagesData;

    return StageBuild.offMainColors<T>((_,__, pageColors){

      if(pageColors == null) return Container();

      final List<Widget> children = <Widget>[
        for(final page in pagesData.keys)
          ListTile(
            title: Text(pagesData[page].name),
            leading: ColorCircleDisplayer(pageColors[page], icon: pagesData[page].icon,),
            onTap: () => pickPageColor(stage, page, pageColors[page]),
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

  void pickPageColor(StageData<T,dynamic> stage, T page, Color initialColor)
    => stage.pickColor(
      initialColor: initialColor,
      onSubmitted: (color) => stage.themeController.colors.editMainPageToPrimary(page, color),
    );

}


class StageMainSingleColor extends StatelessWidget {

  const StageMainSingleColor({this.extraChildren = const <Widget>[]});

  final List<Widget> extraChildren;

  @override
  Widget build(BuildContext context) {

    final StageData stage = Stage.of(context);

    return StageBuild.offMainColors((_, singleColor, __){

      final List<Widget> children = <Widget>[
        ListTile(
          title: const Text("Primary"),
          leading: ColorCircleDisplayer(singleColor),
          onTap: () => pickSingleColor(stage, singleColor),
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

  void pickSingleColor(StageData stage, Color initialColor) => stage.pickColor(
    onSubmitted: (Color color) => stage.themeController.colors.editMainPrimary(color),
    initialColor: initialColor,
  );

}


class ColorCircleDisplayer extends StatelessWidget {
  final Color color;
  final IconData icon;
  const ColorCircleDisplayer(this.color, {this.icon});

  @override
  Widget build(BuildContext context) {

    final ThemeData theme = Theme.of(context);
    final BorderRadius borderRadius = BorderRadius.circular(100);

    return Material(
      color: color,
      elevation: 4,
      borderRadius: borderRadius,
      child: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          color: color,
          border: theme.isDark && color.notLegibleOn(theme.canvasColor)
            ? Border.all(color: theme.colorScheme.onSurface, width: 1)
            : null,
        ),
        child: icon == null ? null : Icon(
          icon, 
          size: 22,
          color: color.contrast,
        ),
      ),
    );
  }
}



class _MultiPageColorsToggleMain<T> extends StatelessWidget {
  
  const _MultiPageColorsToggleMain();
 
  @override
  Widget build(BuildContext context) {
    final StageData<T,dynamic> stage = Stage.of<T,dynamic>(context);
    final colors = stage.themeController.colors;

    return StageBuild.offMainColors((_, singleColor, pageColors) 
      => RadioSliderOf<bool>(
        items: <bool,RadioSliderItem>{
          false: RadioSliderItem(
            icon: Icon(McIcons.circle),
            title: Text("Single"),
          ),
          true: RadioSliderItem(
            icon: Icon(McIcons.cards_outline),
            title: Text("Per page"),
          ),
        },
        orderedItems: <bool>[false, true],
        onSelect: (multi){
          if(multi){
            colors.enableMainPagedColors();
          } else {
            colors.disableMainPagedColors();
          }
        },
        selectedItem: pageColors != null,
      ),
    );
  }
}