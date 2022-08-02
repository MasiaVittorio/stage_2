import 'package:example/core.dart';

class ThemeEx extends StatelessWidget {
  const ThemeEx({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: Stage.of(context)!.panelScrollPhysics,
      children: const <Widget>[
        Section(<Widget>[
          PanelTitle("Brightness", centered: false,),
          StageBrightnessToggle(),
        ]),

        Section(<Widget>[
          SectionTitle("Main Colors"),
          StageMainColors<MainPage>(switchPagesVsSingle: true),
        ]),

        // Section(<Widget>[
        //   SectionTitle("Panel Colors"),
        //   StagePanelColors<PanelPage>(switchPagesVsSingle: true),
        // ]),

        // Section(<Widget>[
        //   SectionTitle("Accent Color"),
        //   StageAccentColor(),
        // ]),

        DimensionsSwitcher(),

      ],
    );
  }
}


class DimensionsSwitcher extends StatelessWidget {
  const DimensionsSwitcher({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final StageData stage = Stage.of(context)!;

    return stage.dimensionsController.dimensions.build((_, dimensions){
      return Section(<Widget>[
        const SectionTitle("Dimensions"),
        RadioSliderOf<double>(
          hideOpenIcons: true,
          title: const Text("Collapsed"),
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
          title: const Text("Radius"),
          items: const <bool,RadioSliderItem>{
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