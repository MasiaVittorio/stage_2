part of stage;

class _TopBar<T,S> extends StatelessWidget {
  _TopBar({
    required this.animation,
    required this.openedPanelSubtitle,
    required this.alignment,
    required this.appBarTitle,
    required this.secondary,
  });

  final Widget appBarTitle;
  final Widget? openedPanelSubtitle;

  final Widget? secondary;

  final Alignment alignment;

  final Animation animation;

  @override
  Widget build(BuildContext context) {

    final StageData<T,S> data = Stage.of<T,S>(context)!;
    final ThemeData theme = Theme.of(context);
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    final double topPadding = mediaQuery.padding.top;

    final Widget subtitle = _Subtitle(this.openedPanelSubtitle);

    final Widget alignedTitles = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: _AlignedTitles(
        alignment: alignment,
        animation: animation,
        appBarTitle: appBarTitle,
        subtitle: openedPanelSubtitle == null ? null : subtitle,
      ),
    );

    Widget child = Padding(
      padding: EdgeInsets.only(top: topPadding),
      child: data.dimensionsController.dimensions.build(((_, dimensions)
        => _RowOfContent(
          dimensions: dimensions,
          alignedTitles: alignedTitles,
          secondary: secondary,
        )),
      ),
    );

    return StageBuild.offPrimaryColorAndItsBrightness((_, currentColor, brightness)
      => data.themeController.colorPlace.build(((context, place) 
      => data.themeController.topBarElevations.build((context,elevations) {
        final Color color = place.isTexts 
          ? theme.canvasColor : (currentColor ?? Colors.blue);
        final Color textColor = place.isTexts 
          ? theme.colorScheme.onSurface : brightness.contrast;

        return Material(
          color: color,
          elevation: elevations![place] 
            ?? StageThemeData.defaultTopBarElevations[place]!,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            color: color,
            child: Material(
              type: MaterialType.transparency,
              child: DefaultTextStyle.merge(
                style: theme.primaryTextTheme.headline6!.copyWith(
                  color: textColor,
                  fontWeight: FontWeight.w600,
                ),
                child: IconTheme(
                  data: IconThemeData(
                    color: textColor, 
                    opacity: 1.0, 
                    size: 24.0,
                  ),
                  child: child,
                ),
              ),
            ),
          ),
        );
      },
      )),),);

  }

}


class _RowOfContent extends StatelessWidget {

  _RowOfContent({
    required this.dimensions,
    required this.alignedTitles,
    required this.secondary,
  });

  final Widget alignedTitles;
  final StageDimensions dimensions;
  final Widget? secondary;

  @override
  Widget build(BuildContext context) {

    final MediaQueryData mediaQuery = MediaQuery.of(context);

    return Align(
      alignment: Alignment(0.0,mediaQuery.size.aspectRatio >= 1.0 ? -1.0 : 0.0),
      child: SizedBox(
        height: dimensions.barSize,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              width: dimensions.barSize,
              height: dimensions.barSize,
              alignment: Alignment.center,
              child: const _MenuButton(),
            ),
            Expanded(
              child: alignedTitles,
            ),
            if(secondary != null) Container(
              width: dimensions.barSize,
              height: dimensions.barSize,
              alignment: Alignment.center,
              child: secondary,
            )
            else SizedBox(
              width: dimensions.barSize,
            ),
          ],
        ),
      ),
    );
  }
}


class _MenuButton extends StatelessWidget {

  const _MenuButton();

  @override
  Widget build(BuildContext context) {
    
    final StageData data = Stage.of(context)!;

    return data.badgesController.panelPages.build(((_, panelBadges) 
      => data.panelController.isMostlyOpenedNonAlert.build(((_, openNonAlert) 
      => Badge(
        showBadge: !(openNonAlert) && panelBadges.values.any((v) => v == true),
        badgeContent: null,
        toAnimate: false,
        shape: BadgeShape.circle,
        // alignment: Alignment.topRight,
        badgeColor: Theme.of(context).accentColor,
        position: BadgePosition.topEnd(top: 8, end: 8),
        ignorePointer: true,
        child: IconButton(
          onPressed: (){
            if(data.panelController.isMostlyOpenedNonAlert.value){
              data.panelController.close();
            } else {
              data.panelController.open();
            }
          },
          icon: ImplicitlySwitchingIcon(
            firstIcon: AnimatedIcons.menu_close,
            secondIcon: AnimatedIcons.close_menu,
            duration: const Duration(milliseconds: 300),
            progress: openNonAlert ? 1.0 : 0.0, 
          ),
        ),
      )),
    )));
  }
}


class _AlignedTitles extends StatelessWidget {

  _AlignedTitles({
    required this.alignment,
    required this.animation,
    required this.appBarTitle,
    required this.subtitle,
  });

  final Alignment alignment;
  final Animation animation;
  final Widget appBarTitle;
  final Widget? subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Align(
          alignment: this.alignment,
          child: appBarTitle,
        ),
        if(subtitle != null)
          _AnimateSubtitle(
            animation: animation,
            alignment: alignment,
            subtitle: subtitle,
          ),
      ],
    );
  }
}


class _AnimateSubtitle extends StatelessWidget {

  _AnimateSubtitle({
    required this.animation,
    required this.subtitle,
    required this.alignment,
  });

  final Animation animation;
  final Alignment alignment;
  final Widget? subtitle;

  @override
  Widget build(BuildContext context) {
    
    final StageData data = Stage.of(context)!;

    return data.panelController.alertController!.isShowing!.build((context, alert){
      if(alert){
        return Container();
      } else {
        return AnimatedBuilder(
          animation: animation,
          child: Align(
            alignment: alignment,
            child: subtitle,
          ),
          builder: (_, child) {
            final double clampedVal = animation.value.clamp(0.0, 1.0);
            return ClipRect(
              child: Align(
                alignment: AlignmentDirectional(-1.0, 1.0),
                heightFactor: clampedVal,
                child: Opacity(
                  opacity: DoubleExt.mapToRange(clampedVal, 0.0, 1.0, fromMin: 0.4), 
                  // it disappears by fading before disappearing by clipping
                  child: child, 
                ),
              ),
            );
          },
        );
      }
    });
 
  }
}


class _Subtitle extends StatelessWidget {

  const _Subtitle(this.child);
  
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    if(child == null) return Container();

    final TextStyle def = DefaultTextStyle.of(context).style;

    return DefaultTextStyle.merge(
      style: TextStyle(
        fontSize: def.fontSize! - 4,
        fontWeight: def.fontWeight!.thinner,
      ),
      child: child!,
    );

  }
}


extension _FontWeightExt on FontWeight {
  FontWeight get thinner => FontWeight.values[
    (FontWeight.values.indexOf(this) - 1)
    .clamp(3, FontWeight.values.length -1)
  ];
  // FontWeight get bolder => FontWeight.values[
  //   (FontWeight.values.indexOf(this) - 1)
  //   .clamp(0, FontWeight.values.length - 1)
  // ];
}