part of stage;

class _BoxedExtendedPanel<T,S> extends StatelessWidget {

  final Widget content;
  final StageData<T,S> data;
  final StageDimensions dimensions;
  final _StageDerivedDimensions derived;

  _BoxedExtendedPanel(this.content, {
    required this.data,
    required this.dimensions,
    required this.derived,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: derived.panelWidthOpened,
      height: derived.totalPanelHeight,
      child: Column(
        children: <Widget>[
          Expanded(child: this.content),
          if(data.panelPagesController != null)
            SizedBox(
              height: dimensions.barSize,
              child: _PanelBottomBar(
                data: data, 
                dimensions: dimensions,
              ),
            ),
        ],
      ),
    );
  }

}