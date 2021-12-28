part of stage;

class _PanelBackground extends StatelessWidget {

  _PanelBackground({
    required this.animation,
    required this.backgroundColor,
    required this.backgroundOpacity,
  });

  final StageBackgroundGetter? backgroundColor;
  final double? backgroundOpacity;
  final Animation? animation;

  @override
  Widget build(BuildContext context) {
    final StageData stage = Stage.of(context)!;
    final ThemeData theme = Theme.of(context);
    final themeController = stage.themeController;

    return stage.panelController.alertController.isShowing.build(((_, alert)
      => AnimatedBuilder(
        animation: animation!,
        builder: (_, __) {
          final double? clampedVal = animation!.value.clamp(0.0,1.0);
          return IgnorePointer(
            ignoring: clampedVal == 0.0 || alert,
            child: GestureDetector(
              onTap: stage.panelController.close,
              child: themeController.colorPlace.build(((context, place) 
                => Container(
                  color: (backgroundColor?.call(theme, place) ?? Color(0xFF000000))
                      .withOpacity(alert ? 0.0 : clampedVal! * (backgroundOpacity ?? 1/1.3),),
                )),
              ),
            ),
          );
        }
      )),
    );
  }

}