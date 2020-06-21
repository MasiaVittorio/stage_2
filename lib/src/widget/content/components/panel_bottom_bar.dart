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
        child: data.themeController.derived.panelPageToPrimaryColor.build((_, primaryColorsMap) 
          => BlocVar.build4<List<S>,S,Map<S,bool>,Color>(
            data.panelPagesController._orderedPages,
            data.panelPagesController._page,
            data.panelPagesController._enabledPages,
            data.themeController.derived._panelPrimaryColor,
            builder: (_, orderedPages, panelPage, enabled, currentColor) {

              final bool single = primaryColorsMap == null; 
              final Color finalColor = this.data.themeController.pandaOpenedPanelNavBar == true 
                ? (currentColor ?? theme.primaryColor)
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
                tileSize: dimensions.barSize,
                topPadding: 0.0,
                forceSingleColor: single,
                forceBrightness: data.themeController.colors._currentForcedPrimaryColorBrightness,
                duration: const Duration(milliseconds: 250),
                singleBackgroundColor: finalColor,
              );

            },
          ),
        ),
      ),
    );
  }
}