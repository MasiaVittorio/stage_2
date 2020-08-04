part of stage;


class _BottomBar<T,S> extends StatelessWidget {

  const _BottomBar();

  @override
  Widget build(BuildContext context) {

    final StageData<T,S> data = Stage.of<T,S>(context);
    final ThemeData theme = Theme.of(context);
    final bool _useAccent = data.themeController.accentSelectedPage;
    final Map<T,StagePage> pagesData = data.mainPagesController.pagesData;

    /// [primaryColorsMap] can be null, so cannot be used in batch with .build6!!
    return data.mainPagesController._orderedPages.build((_, orderedPages) 
      => data.dimensionsController.dimensions.build((_, dimensions) 
      => data.themeController.derived.mainPageToPrimaryColor.build((_, primaryColorsMap) 
      => data.themeController.derived._mainPrimaryColor.build((_, color) 
      => data.mainPagesController._enabledPages.build((_, enabled) 
      => data.themeController.colors.themeType.build((_, type)
      => data.mainPagesController._page.build((_, page) {

        final bool googleLike = type.isGoogle;

        final bool single = primaryColorsMap == null;
        final Color singleBackground = color;
        final bool useAccent = single && _useAccent;
        final Color singleAccent = useAccent ? theme.accentColor : null;
        /// all that is ignored by radionavbar if googleLike


        return UpShadower(
          child: RadioNavBar<T>(
            selectedValue: page,
            orderedValues: <T>[
              for(final page in orderedPages) 
                if(enabled[page]) page,
            ],
            items: <T,RadioNavBarItem>{
              for(final entry in pagesData.entries)
                entry.key: RadioNavBarItem(
                  title: entry.value.name,
                  icon: entry.value.icon,
                  unselectedIcon: entry.value.unselectedIcon,
                  color: single ? null : primaryColorsMap[entry.key],
                ),
            },
            onSelect: data.mainPagesController.goToPage,
            topPadding: dimensions.collapsedPanelSize/2,
            tileSize: dimensions.barSize,
            duration: const Duration(milliseconds: 250),

            /// "white" (canvas) background, different accent color per page
            googleLike: googleLike, 

            forceSingleColor: single,
            singleBackgroundColor: singleBackground,
            forceBrightness: data.themeController.colors
                ._currentForcedPrimaryColorBrightness,
            accentTextColor: singleAccent,
          ),
        );
      },)))))),
    );
  }
}
