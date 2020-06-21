part of stage;

class _AlertBackground extends StatelessWidget {

  _AlertBackground({
    @required this.backgroundColor,
    @required this.backgroundOpacity,
    @required this.onPanelDrag,
    @required this.onPanelDragEnd,
  });

  final void Function(DragUpdateDetails) onPanelDrag;
  final void Function(DragEndDetails) onPanelDragEnd;
  final Color Function(ThemeData theme) backgroundColor;
  final double backgroundOpacity;

  @override
  Widget build(BuildContext context) {
    final StageData stage = Stage.of(context);
    final ThemeData theme = Theme.of(context);

    return stage.panelController.alertController.isShowing.build((_, alert)
      => IgnorePointer(
        ignoring: !alert,
        child: GestureDetector(
          onTap: stage.panelController.close,
          onVerticalDragUpdate: onPanelDrag,
          onVerticalDragEnd: onPanelDragEnd,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            color: (backgroundColor?.call(theme) ?? Color(0xFF000000))
                .withOpacity(alert ? (backgroundOpacity ?? 1/1.3) : 0.0),
          ),
        ),
      ),
    );

  }

}