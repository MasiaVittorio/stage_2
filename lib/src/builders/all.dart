part of stage;

class StageBuild {

  static Widget offPrimaryColorBrightness(Widget Function(BuildContext, Brightness) builder) 
    => _StageBuildOffPrimaryColorBrightness(builder);

  static Widget offPrimaryColorAndItsBrightness(Widget Function(BuildContext, Color?, Brightness) builder)
    => _StageBuildOffPrimaryColorANDItsBrightness(builder);

  static Widget offMainPage<T>(Widget Function(BuildContext, T) builder) 
    => _StageBuildOffMainPage<T>(builder);

  static Widget offPanelPage<S>(Widget Function(BuildContext, S) builder) 
    => _StageBuildOffPanelPage<S>(builder);

  static Widget offOpenNonAlert(Widget Function(BuildContext, bool) builder) 
    => _StageBuildOffOpenNonAlert(builder);

  static Widget offPanelMostlyOpened(Widget Function(BuildContext, bool) builder) 
    => _StageBuildOffPanelMostlyOpened(builder);

  static Widget offOpenNonAlertAndPages<T,S>(Widget Function(BuildContext context, bool openNonAlert, T? mainPage, S? panelPage) builder)
    => _StageBuildOffOpenNonAlertAllPages<T,S>(builder);

  static Widget offMainPagesData<T>(Widget Function(BuildContext, Map<T,bool>?, List<T>, T) builder)
    => _StageBuildOffMainPagesData<T>(builder);

  static Widget offMainEnabledPages<T>(Widget Function(BuildContext, Map<T,bool>) builder)
    => _StageBuildOffMainEnabledPages<T>(builder);

  static Widget offPanelPagesData<S>(Widget Function(BuildContext, Map<S?,bool>, List<S?>, S) builder)
    => _StageBuildOffPanelPagesData<S>((con, map, list, s) => builder(con, map!, list!, s as S));

  static Widget offMainColors<T>(Widget Function(BuildContext, Color, Map<T,Color>?) builder) 
    => _StageBuildOffMainColors<T>(builder);

  static Widget offPanelColors<S>(Widget Function(BuildContext, Color, Map<S,Color>?) builder) 
    => _StageBuildOffPanelColors<S>(builder);
}

