part of stage;


class _BottomGesture extends StatelessWidget {
  
  _BottomGesture({
    required this.onPanelDrag,
    required this.onPanelDragEnd,
  });

  final void Function(DragUpdateDetails) onPanelDrag;
  final void Function(DragEndDetails) onPanelDragEnd;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragUpdate: onPanelDrag,
      onVerticalDragEnd: onPanelDragEnd,
      behavior: HitTestBehavior.translucent,
      child: Container(
        //color null => touch events pass to the bottom bars
      ),
    );
  }
}