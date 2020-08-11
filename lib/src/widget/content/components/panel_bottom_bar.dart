part of stage;

class _PanelBottomBar<T,S> extends StatelessWidget {

  _PanelBottomBar({
    @required this.data,
    @required this.dimensions,
  });

  final StageData<T,S> data;
  final StageDimensions dimensions;

  @override
  Widget build(BuildContext context) {

    final ThemeData theme = Theme.of(context);
    final thCon = data.themeController;
    final pages = data.panelPagesController;

    return MediaQuery.removePadding(
      context: context,
      removeBottom: true,
      removeLeft: true,
      removeRight: true,
      removeTop: true,
      child: Container(
        decoration: const BoxDecoration(
          boxShadow: [BoxShadow(
            blurRadius: 6.0,
            color: const Color(0x40000000), 
            offset: Offset(0,0.5),
          )]
        ),
        // the paged colors map cannot be used in batch because could be null
        child: pages._orderedPages.build((_, orderedPages) 
          => pages._enabledPages.build((_, enabled) 
          => thCon.derived.panelPageToPrimaryColor.build((_, primaryColorsMap) 
          => thCon.derived._panelPrimaryColor.build((_, currentColor) 
          => thCon.colorPlace.build((_, place) 
          => pages._page.build((_, panelPage) {

            final bool googleLike = place.isTexts;

            final bool single = primaryColorsMap == null;
            final Color singleBackground = currentColor;

            final Color finalColor = thCon.pandaOpenedPanelNavBar == true 
              ? (singleBackground ?? theme.primaryColor)
              : theme.canvasColor;

            return RadioNavBar(
              selectedValue: panelPage,
              orderedValues: [
                for(final page in orderedPages) 
                  if(enabled[panelPage])
                    page,
              ],
              items: {
                for(final entry in data.panelPagesController.pagesData.entries)
                  entry.key: RadioNavBarItem(
                    title: entry.value.name,
                    icon: entry.value.icon,
                    unselectedIcon: entry.value.unselectedIcon,
                    color: single ? null : primaryColorsMap[entry.key],
                  ),
              },
              onSelect: (page) => data.panelPagesController.goToPage(page),
              duration: const Duration(milliseconds: 250),
              tileSize: dimensions.barSize,
              topPadding: 0.0,

              googleLike: googleLike,
              accentTextColor: googleLike ? finalColor : null,

              forceSingleColor: single,
              singleBackgroundColor: finalColor,
              forceBrightness: thCon
                  ._currentForcedPrimaryColorBrightness,
            );

          },))))),
        ),
      ),
    );
  }
}