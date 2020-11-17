part of stage;

//helper to make the snackbar child easier
class StageSnackBar extends StatelessWidget {
  final Widget title;
  final Widget subtitle;
  final Widget secondary;
  final double alignment; //-1 left 0 center +1 right
  final bool scrollable;
  final VoidCallback onTap;
  final EdgeInsets contentPadding;

  const StageSnackBar({
    @required this.title,
    this.subtitle,
    this.secondary,
    this.alignment,
    this.scrollable = false,
    this.onTap,
    this.contentPadding = defaultContentPadding,
  });
  static const EdgeInsets defaultContentPadding = const EdgeInsets.symmetric(horizontal: 12);

  @override
  Widget build(BuildContext context) {
    final StageData stage = Stage.of(context);
    final StageDimensions dimensions = stage.dimensionsController.dimensions.value;
    // Ok to access to it like that because the snackbars are temporary
    final double height = dimensions.collapsedPanelSize;

    final double xAlignment = alignment ?? secondary != null 
      ? 0 
      : stage.panelController.snackbarController.snackBarRightAligned
        ? 1
        : -1;

    final Widget secondaryChild = secondary != null 
      ? Container(
        alignment: Alignment.center,
        height: height,
        constraints: BoxConstraints(
          minWidth: height,
        ),
        child: secondary,
      )
      : null;
    
    final ThemeData theme = Theme.of(context);

    final Widget body = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Expanded(
          flex: 5, 
          child: Align(
            alignment: Alignment(
              xAlignment,
              subtitle != null ? 0.5 : 0.0
            ),
            child: DefaultTextStyle(
              style: theme.textTheme.subtitle1,
              child: title,
            ),
          ),
        ),
        if(subtitle != null)
          Expanded(
            flex: 4, 
            child: Align(
              alignment: Alignment(xAlignment,-0.5),
              child: DefaultTextStyle(
                style: theme.textTheme.subtitle2,
                child: subtitle,
              ),
            ),
          ),
      ],
    );

    final bool right = stage.panelController.snackbarController.snackBarRightAligned ?? false;

    final Widget result = InkWell(
      onTap: onTap,
      child: SizedBox(
        height: height,
        child: Row(children: <Widget>[
          if(secondary != null && right)
            secondaryChild,
          if(!right) StageSnackButton.placeHolder,

          Expanded(child: Padding(
            padding: contentPadding ?? defaultContentPadding,
            child: body,
          )),

          if(right) StageSnackButton.placeHolder,
          if(secondary != null && !right)
            secondaryChild,
        ],),
      ),
    );

    if(scrollable ?? false){
      return SnackBarClosingScrollable(result);
    }

    return result;
  }
}

class SnackBarClosingScrollable extends StatelessWidget {
  const SnackBarClosingScrollable(this.child);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final StageData stage = Stage.of(context);
    return LayoutBuilder(builder: (_, constraints)
      => ConstrainedBox(
        constraints: constraints,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: stage.panelController.snackbarController.snackBarScrollPhysics(
            bottom: !(stage.panelController.snackbarController.snackBarRightAligned ?? false),
            always: true,
          ),
          child: ConstrainedBox(
            constraints: constraints,
            child: child,
          ),
        ),
      ),
    );
  }
}


class StageSnackButton extends StatelessWidget {

  const StageSnackButton({
    @required this.onTap,
    @required this.child,
    this.autoClose = true,
    this.accent = false,
    this.backgroundColor,
  }) : isPlaceHolder = false;
  final bool isPlaceHolder;
  final Widget child;
  final Color backgroundColor;
  final VoidCallback onTap;
  final bool autoClose;
  final bool accent;

  const StageSnackButton.asPlaceHolder():
    onTap = null,
    child = null,
    autoClose = null,
    accent = null,
    isPlaceHolder = true,
    backgroundColor = null;

  static const StageSnackButton placeHolder = StageSnackButton.asPlaceHolder();

  @override
  Widget build(BuildContext context) {

    final StageData stage = Stage.of(context);

    return BlocVar.build2<StageDimensions,Color>( 
      stage.dimensionsController.dimensions,
      stage.themeController.derived.currentPrimaryColor,
      builder:(_, dimensions, color){
        
        final double height = dimensions.collapsedPanelSize;

        if(isPlaceHolder) return SizedBox(
          height: height, 
          width: height
        );
        
        return Material(
          color: backgroundColor ?? (accent 
            ? getColor(Theme.of(context), color) 
            : color),
          borderRadius: BorderRadius.circular(dimensions.panelRadiusClosed),
          child: InkResponse(
            radius: height/2,
            onTap: onTap == null ? null : (){
              this.onTap();
              if(this.autoClose ?? true){
                stage.closeSnackBar();
              }
            },
            child: Container(
              height: height,
              width: height,
              alignment: Alignment.center,
              child: this.child,
            ),
          ),
        );
      },
    );
  }
  static Color getColor(ThemeData theme, Color color) => Color.alphaBlend(
    theme.colorScheme.onSurface
        .withOpacity(0.1),
    color, 
  );

}

//what is actually shown 
class _StageSnackBar extends StatelessWidget {

  _StageSnackBar({
    @required this.animation,
    @required this.child,
  });

  final Animation animation;
  final Widget child;

  static const double textOpacity = 0.9;

  @override
  Widget build(BuildContext context) {

    final StageData stage = Stage.of(context);
    final ThemeData theme = Theme.of(context);
    
    final Widget closeButton = StageSnackButton(
      onTap: (){
        stage.panelController.snackbarController._onNextManualClose
          .forEach((f) => f?.call());
        stage.panelController.snackbarController._onNextManualClose
          .clear();
      },
      autoClose: true,
      child: const Icon(Icons.close),
      accent: true,
    );

    final bool right = stage.panelController.snackbarController.snackBarRightAligned ?? false;

    return BlocVar.build2(
      stage.themeController.derived.currentPrimaryColor,
      stage.themeController.derived.forcedPrimaryColorBrightness,
      builder: (_,color, forcedPrimaryColorBrightness) {
        final Brightness colorBrightness 
            = forcedPrimaryColorBrightness
            ?? ThemeData.estimateBrightnessForColor(color);
        final Color iconColor = colorBrightness.contrast;

        return Theme(
          data: theme.copyWith(
            iconTheme: theme.primaryIconTheme.copyWith(
              color: iconColor,
              opacity: textOpacity,
            ),
            textTheme: theme.primaryTextTheme.apply(
              bodyColor: iconColor.withOpacity(textOpacity), 
            ),
          ),
          child: stage.dimensionsController.dimensions.build((_, dimensions) {
            
            final double height = dimensions.collapsedPanelSize;
            final Offset center = Offset(height / 2, height / 2);

            final Widget alert = Container(
              // color: color,
              child: Container(
                // color: color,
                child: Material(
                  color: color,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      // if(!right) SizedBox(width: height,),
                      Expanded(child: this.child),
                      // if(right) SizedBox(width: height,),
                    ],
                  ),
                ),
              ),
            );

            return SizedBox(
              height: height,
              child: AnimatedBuilder(
                animation: this.animation,
                child: alert, 
                builder: (_, alert){
                  final double val = animation.value;
                  // not clamped because they clamp it already in mapToRange

                  final double scale = Curves.easeOut.transform(
                    DoubleExt.mapToRange(val, 0.0, 1.0, fromMin: 0.0, fromMax: 0.6)
                  );

                  final double clip = Curves.easeOut.transform(
                    DoubleExt.mapToRange(val, 0.0, 1.0, fromMin: 0.4, fromMax: 1.0)
                  );
                  final _CircleClipper clipper = _CircleClipper(
                    center: center,
                    radiusFraction: clip,
                    offsetFromRight: right,
                  );

                  return Stack(
                    fit: StackFit.expand,
                    overflow: Overflow.clip,
                    children: <Widget>[

                      Positioned(
                        left: 0.0,
                        right: 0.0,
                        top: 0.0,
                        height: height,
                        child: ClipOval(
                          clipper: clipper,
                          child: alert,
                        ),
                      ),

                      Positioned(
                        left: !right ? 0.0 : null,
                        right: right ? 0.0 : null,
                        top: 0.0,
                        height: height,
                        width: height,
                        child: Transform.scale(
                          scale: scale,
                          child: closeButton,
                          alignment: Alignment.center,
                        ),
                      ),

                    ],
                  );
                },
              ),
            );
          },),
        );
      },
    );
  }
}


class _CircleClipper extends CustomClipper<Rect> {
  _CircleClipper({
    @required this.center, 
    @required this.radiusFraction,
    @required this.offsetFromRight,
  });

  final Offset center;
  final double radiusFraction;
  final bool offsetFromRight;

  @override
  Rect getClip(Size size) {

    final double xRemaining = math.max(size.width - center.dx, center.dx);
    final double yRemaining = math.max(size.height - center.dy, center.dy);
    final double maxRadius = math.sqrt(xRemaining * xRemaining + yRemaining * yRemaining);

    final Rect rect = Rect.fromCircle(
      radius: radiusFraction * maxRadius, 
      center: offsetFromRight 
        ? Offset(
          size.width - center.dx,
          center.dy
        )
        : center,
    );

    return rect;
  }

  @override
  bool shouldReclip(_CircleClipper oldClipper) 
      => oldClipper.radiusFraction != this.radiusFraction 
      || oldClipper.center != this.center
      || oldClipper.offsetFromRight != this.offsetFromRight;
}
