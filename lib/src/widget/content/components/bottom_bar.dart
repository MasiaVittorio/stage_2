part of stage;


class _BottomBar<T,S> extends StatelessWidget {

  const _BottomBar();

  @override
  Widget build(BuildContext context) {

    final StageData<T,S> data = Stage.of<T,S>(context)!;
    final Map<T,StagePage?> pagesData = data.mainPagesController.pagesData;

    /// [primaryColorsMap] can be null, so cannot be used in batch with .build6!!
    return data.mainPagesController._orderedPages.build(((_, orderedPages) 
      => data.dimensionsController.dimensions.build(((_, dimensions) 
      => data.themeController.derived.mainPageToPrimaryColor.build(((_, primaryColorsMap) 
      => data.themeController.derived._mainPrimaryColor.build(((_, color) 
      => data.themeController.derived.themeData.build((_, theme)
      => data.mainPagesController._enabledPages.build(((_, enabled) 
      => data.themeController.colorPlace.build(((_, place)
      => data.mainPagesController._page.build(((_, page) 
      => data.badgesController.mainPages.build((_, badges) {

        final bool googleLike = place.isTexts;

        final bool single = primaryColorsMap == null;
        final Color singleBackground = color;
        final bool useAccent 
          =  single 
          && data.themeController.accentSelectedPage;
        final Color? singleAccent = useAccent 
          ? theme.colorScheme.secondary 
          : null;
        /// all that is ignored by radionavbar if googleLike

        final Widget child = RadioNavBar<T>(
          selectedValue: page,
          orderedValues: <T>[
            for(final page in orderedPages) 
              if(enabled[page]!) page,
          ],
          items: <T,RadioNavBarItem>{
            for(final entry in pagesData.entries)
              entry.key: RadioNavBarItem(
                title: entry.value!.name,
                icon: entry.value!.icon,
                unselectedIcon: entry.value!.unselectedIcon,
                color: single ? null : primaryColorsMap[entry.key!],
              ),
          },
          badges: badges,
          onSelect: (p) => data.mainPagesController.goToPage(p),
          topPadding: dimensions.collapsedPanelSize/2,
          tileSize: dimensions.barSize,
          duration: const Duration(milliseconds: 250),

          /// "white" (canvas) background, different accent color per page
          googleLike: googleLike, 

          forceSingleColor: single,
          singleBackgroundColor: singleBackground,
          accentTextColor: singleAccent,
        );

        return data.themeController.bottomBarShadow.build((context, val){
          if(val){
            return UpShadower(
              child: child,
            );
          } else {
            return child;
          }
        });

      }))))))))))))))),
    );
  }
}
