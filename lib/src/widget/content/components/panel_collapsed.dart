part of stage;

class _BoxedCollapsedPanel extends StatelessWidget {

  final Widget content;
  final StageDimensions dimensions;
  final _StageDerivedDimensions derived;
  final bool transparency;

  const _BoxedCollapsedPanel(this.content, {
    required this.dimensions,
    required this.derived,
    required this.transparency,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Material(
        type: transparency 
          ? MaterialType.transparency 
          : MaterialType.canvas,
        child: Align(
          alignment: Alignment.topCenter,
          child: SizedBox(
            width: derived.panelWidthClosed,
            height: dimensions.collapsedPanelSize,
            child: content,
          ),
        ),
      ),
    );
  }
}