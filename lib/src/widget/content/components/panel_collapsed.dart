part of stage;

class _BoxedCollapsedPanel extends StatelessWidget {

  final Widget content;
  final StageDimensions dimensions;
  final _StageDerivedDimensions derived;

  _BoxedCollapsedPanel(this.content, {
    @required this.dimensions,
    @required this.derived,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Material(child: Align(
        alignment: Alignment.topCenter,
        child: SizedBox(
          width: derived.panelWidthClosed,
          height: dimensions.collapsedPanelSize,
          child: content,
        ),
      ),),
    );
  }
}