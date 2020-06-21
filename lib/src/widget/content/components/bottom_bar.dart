part of stage;


class _BottomBar<T,S> extends StatelessWidget {

  const _BottomBar();

  @override
  Widget build(BuildContext context) {

    final StageData<T,S> data = Stage.of<T,S>(context);
    final ThemeData theme = Theme.of(context);
    final bool accentSelectedPage = data.themeController.accentSelectedPage;
    final Map<T,StagePage> pagesData = data.mainPagesController.pagesData;

    /// [primaryColorsMap] can be null, so cannot be used in batch with .build6!!
    return data.themeController.derived.mainPageToPrimaryColor.build((_, primaryColorsMap) => BlocVar.build5(
      data.themeController.derived._mainPrimaryColor,
      data.mainPagesController._page,
      data.mainPagesController._orderedPages,
      data.mainPagesController._enabledPages,
      data.dimensionsController.dimensions,
      builder: (_, Color color, T page, List<T> orderedPages, Map<T,bool> enabled, StageDimensions dimensions){

        final bool single = primaryColorsMap == null;

        return UpShadower(
          child: RadioNavBar<T>(
            selectedValue: page,
            orderedValues: <T>[for(final page in orderedPages) if(enabled[page]) page],
            items: <T,RadioNavBarItem>{
              for(final entry in pagesData.entries)
                entry.key: RadioNavBarItem(
                  title: entry.value.name,
                  icon: entry.value.icon,
                  unselectedIcon: entry.value.unselectedIcon,
                  color: single ? null : primaryColorsMap[entry.key],
                ),
            },
            forceSingleColor: single,
            singleBackgroundColor: color,
            onSelect: data.mainPagesController.goToPage,
            tileSize: dimensions.barSize,
            topPadding: dimensions.collapsedPanelSize/2,
            duration: const Duration(milliseconds: 250),
            forceBrightness: data.themeController.colors._currentForcedPrimaryColorBrightness,
            accentTextColor: (single && accentSelectedPage) ? theme.accentColor : null,
          ),
        );
      },
    ));
  }
}
