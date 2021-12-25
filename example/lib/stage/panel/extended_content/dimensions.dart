import 'package:example/core.dart';

class DimensionsEx extends StatelessWidget {
  const DimensionsEx();
  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: Stage.of(context).panelScrollPhysics,
      children: <Widget>[
        DimensionsSwitcher(),
      ],
    );
  }
}


class DimensionsSwitcher extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final StageData stage = Stage.of(context);

    return stage.dimensionsController.dimensions.build((_, dimensions){
      return Section(<Widget>[
        const PanelTitle("Dimensions"),
        RadioSliderOf<double>(
          hideOpenIcons: true,
          title: Text("Collapsed"),
          items: <double,RadioSliderItem>{
            for(final v in <double>[StageDimensions.defaultCollapsedPanelSize, 56, 48])
              v: RadioSliderItem(
                icon: Text("$v"),
                title: Text("$v"),
              ),
          },
          selectedItem: dimensions.collapsedPanelSize,
          onSelect: (v) => stage.dimensionsController.dimensions.set(
            stage.dimensionsController.dimensions.value.copyWith(
              collapsedPanelSize: v,
            ),
          ),
        ),
        RadioSliderOf<bool>(
          hideOpenIcons: true,
          title: Text("Radius"),
          items: <bool,RadioSliderItem>{
            true: RadioSliderItem(
              icon: Text("Round"),
              title: Text("Round"),
            ),
            false: RadioSliderItem(
              icon: Text("Regular"),
              title: Text("Regular"),
            ),
          },
          selectedItem: dimensions.panelRadiusClosed > 8,
          onSelect: (b) => stage.dimensionsController.dimensions.set(
            stage.dimensionsController.dimensions.value.copyWith(
              panelRadiusClosed: b ? dimensions.collapsedPanelSize / 2 : StageDimensions.defaultPanelRadius,
            ),
          ),
        ),
      ]);      
    });
  }
}