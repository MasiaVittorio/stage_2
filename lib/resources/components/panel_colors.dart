import 'package:stage/stage.dart';
import 'package:flutter/material.dart';
import 'package:sid_ui/sid_ui.dart';
import 'main_colors.dart'; // for the color circle displayer lol

class StagePanelColors<S> extends StatelessWidget {

  const StagePanelColors({
    this.switchPagesVsSingle = false,
    this.extraChildren,
  });

  final bool switchPagesVsSingle;
  final List<Widget>? extraChildren;

  @override
  Widget build(BuildContext context) 
    => StageBuild.offPanelColors<S>((_, singleColor, pageColors) {
      
      final Widget child = pageColors != null
        ? StagePanelColorsPerPage<S>(extraChildren: extraChildren)
        : StagePanelSingleColor(extraChildren: extraChildren!);

      if(switchPagesVsSingle){
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            _MultiPageColorsTogglePanel<S>(),
            child,    
          ],
        );
      } else {
        return child;
      }

    },);


}

class StagePanelColorsPerPage<S> extends StatelessWidget {

  const StagePanelColorsPerPage({this.extraChildren = const <Widget>[]});

  final List<Widget>? extraChildren;

  @override
  Widget build(BuildContext context) {

    final StageData<dynamic,S> stage = Stage.of<dynamic,S>(context)!;
    final Map<S?,StagePage?>? pagesData = stage.panelPagesController!.pagesData;

    return StageBuild.offPanelColors<S>((_,__, pageColors){

      if(pageColors == null) return Container();

      final List<Widget> children = <Widget>[
        for(final page in pagesData!.keys)
          ListTile(
            title: Text(pagesData[page]!.name),
            leading: ColorCircleDisplayer(pageColors[page!], icon: pagesData[page]!.icon,),
            onTap: () => pickPageColor(stage, page, pageColors[page]),
          ),
        ...(extraChildren ?? const <Widget>[]),
      ];

      return Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          for(final List<Widget>? couple in children.part(2))
            Row(children: <Widget>[
              for(final child in couple!)
                Expanded(child: child),
            ],),
        ],
      );
    },);
  }

  void pickPageColor(StageData<dynamic,S> stage, S? page, Color? initialColor)
    => stage.pickColor(
      initialColor: initialColor,
      onSubmitted: (color) => stage.themeController!.currentColorsController!.editPanelPageToPrimary(page, color),
    );

}


class StagePanelSingleColor extends StatelessWidget {

  const StagePanelSingleColor({this.extraChildren = const <Widget>[]});

  final List<Widget> extraChildren;

  @override
  Widget build(BuildContext context) {

    final StageData? stage = Stage.of(context);

    return StageBuild.offPanelColors((_, singleColor, __){

      final List<Widget> children = <Widget>[
        ListTile(
          title: const Text("Primary"),
          leading: ColorCircleDisplayer(singleColor),
          onTap: () => pickSingleColor(stage!, singleColor),
        ),
        ...(extraChildren),
      ];

      return Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          for(final List<Widget>? couple in children.part(2))
            Row(children: <Widget>[
              for(final child in couple!)
                Expanded(child: child),
            ],),
        ],
      );
    },);
  }

  void pickSingleColor(StageData stage, Color? initialColor) => stage.pickColor(
    onSubmitted: (Color color) => stage.themeController!.currentColorsController!.editPanelPrimary(color),
    initialColor: initialColor,
  );

}




class _MultiPageColorsTogglePanel<S> extends StatelessWidget {
  
  const _MultiPageColorsTogglePanel();
 
  @override
  Widget build(BuildContext context) {
    final StageData<dynamic,S>? stage = Stage.of<dynamic,S>(context);

    return StageBuild.offPanelColors((_, __, pageColors){
      final colors = stage!.themeController!.currentColorsController;
      return RadioSliderOf<bool>(
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
            colors!.enablePanelPagedColors();
          } else {
            colors!.disablePanelPagedColors();
          }
        },
        selectedItem: pageColors != null,
      );
    },
    );
  }
}