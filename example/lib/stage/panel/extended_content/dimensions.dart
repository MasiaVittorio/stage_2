import 'package:example/core.dart';
import 'package:segmented_slider/segmented_slider.dart';

class DimensionsEx extends StatelessWidget {
  const DimensionsEx({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: Stage.of(context)!.panelScrollPhysics,
      children: const <Widget>[DimensionsSwitcher()],
    );
  }
}

class DimensionsSwitcher extends StatelessWidget {
  const DimensionsSwitcher({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final StageData stage = Stage.of(context)!;

    final dim = stage.dimensionsController.dimensions;
    return dim.build((_, dimensions) {
      return Section(<Widget>[
        const PanelTitle("Dimensions"),
        const SectionTitle("Collapsed panel size"),
        SegmentedSlider<double>(
          segments: [
            for (final v in <double>[
              StageDimensions.defaultCollapsedPanelSize,
              56,
              48,
            ])
              SliderSegment(label: Text("$v"), value: v),
          ],
          allowDeselectOnTap: false,
          value: dimensions.collapsedPanelSize,
          onSelect: (v) =>
              dim.update(dim.value.copyWith(collapsedPanelSize: v)),
        ),
        const SectionTitle("Panel border radius"),
        SegmentedSlider<bool>(
          segments: const [
            SliderSegment(value: true, label: Text("Round")),
            SliderSegment(value: false, label: Text("Regular")),
          ],
          value: dimensions.panelRadiusClosed > 8,
          allowDeselectOnTap: false,
          onSelect: (b) => stage.dimensionsController.dimensions.update(
            stage.dimensionsController.dimensions.value.copyWith(
              panelRadiusClosed: (b ?? false)
                  ? dimensions.collapsedPanelSize / 2
                  : StageDimensions.defaultPanelRadius,
            ),
          ),
        ),
      ]);
    });
  }
}
