part of stage;


class StageColorsData<T,S> {

  //=================================
  // Values
  //==> Light Colors
  final Color lightAccent;

  final Color lightMainPrimary;
  final Map<T,Color> lightMainPageToPrimary; ///could be null

  final Color lightPanelPrimary;
  final Map<S,Color> lightPanelPageToPrimary; ///could be null


  //==> Dark Colors (for each dark style)
  final Map<DarkStyle,Color> darkAccents;

  final Map<DarkStyle,Color> darkMainPrimaries;
  final Map<DarkStyle,Map<T,Color>> darkMainPageToPrimaries; ///could be null

  final Map<DarkStyle,Color> darkPanelPrimaries;
  final Map<DarkStyle,Map<S,Color>> darkPanelPageToPrimaries; ///could be null



  //=================================
  // Constructors
  StageColorsData._({
    @required Iterable<T> allMainPagesToFill,
    @required Iterable<S> allPanelPagesToFill,

    @required Color lightAccent,
    @required Color lightMainPrimary,
    @required Map<T,Color> lightMainPageToPrimary,
    @required Color lightPanelPrimary,
    @required Map<S,Color> lightPanelPageToPrimary,

    @required Map<DarkStyle,Color> darkAccents,
    @required Map<DarkStyle,Color> darkMainPrimaries,
    @required Map<DarkStyle,Map<T,Color>> darkMainPageToPrimaries,
    @required Map<DarkStyle,Color> darkPanelPrimaries,
    @required Map<DarkStyle,Map<S,Color>> darkPanelPageToPrimaries,
  }):
    lightAccent = lightAccent ?? StageDefaultColors.accent,
    lightMainPrimary = lightMainPrimary ?? StageDefaultColors.primary,
    lightMainPageToPrimary = _getFullMapPages<T>(lightMainPageToPrimary, allMainPagesToFill), ///could be null
    lightPanelPrimary = lightPanelPrimary ?? StageDefaultColors.primary,
    lightPanelPageToPrimary = _getFullMapPages<S>(lightPanelPageToPrimary, allPanelPagesToFill), ///could be null
    darkAccents = _getFullMapDarkAccents(darkAccents),
    darkMainPrimaries = _getFullMapDarkPrimaries(darkMainPrimaries),
    darkMainPageToPrimaries = _getFullMapDarkPagesPrimaries<T>(darkMainPageToPrimaries, allMainPagesToFill), ///could be null
    darkPanelPrimaries = _getFullMapDarkPrimaries(darkPanelPrimaries),
    darkPanelPageToPrimaries = _getFullMapDarkPagesPrimaries<S>(darkPanelPageToPrimaries, allPanelPagesToFill); ///could be null

  StageColorsData.nullable({
    this.lightAccent,
    this.lightMainPageToPrimary,
    this.darkAccents,
    this.darkMainPageToPrimaries,
    this.darkMainPrimaries,
    this.darkPanelPageToPrimaries,
    this.darkPanelPrimaries,
    this.lightMainPrimary,
    this.lightPanelPageToPrimary,
    this.lightPanelPrimary,
  });

  static StageColorsData<T,S> _fromThemeAndNullableData<T,S>(
    ThemeData theme, 
    StageColorsData<T,S> nullableData,
    {
      Iterable<T> allMainPagesToFill,
      Iterable<S> allPanelPagesToFill, /// Can be null
    }
  ) => _fromTheme<T,S>(
    theme,
    allMainPagesToFill: allMainPagesToFill,
    allPanelPagesToFill: allPanelPagesToFill,

    lightAccent: nullableData?.lightAccent,
    lightMainPrimary: nullableData?.lightMainPrimary,
    lightMainPageToPrimary: nullableData?.lightMainPageToPrimary,
    lightPanelPrimary: nullableData?.lightPanelPrimary,
    lightPanelPageToPrimary: nullableData?.lightPanelPageToPrimary,
    darkAccents: nullableData?.darkAccents,
    darkMainPrimaries: nullableData?.darkMainPrimaries,
    darkMainPageToPrimaries: nullableData?.darkMainPageToPrimaries,
    darkPanelPrimaries: nullableData?.darkPanelPrimaries,
    darkPanelPageToPrimaries: nullableData?.darkPanelPageToPrimaries,
  );

  static StageColorsData<T,S> _fromTheme<T,S>(ThemeData theme, {
    Iterable<T> allMainPagesToFill,
    Iterable<S> allPanelPagesToFill, /// Can be null
    Color lightAccent,
    Color lightMainPrimary,
    Map<T,Color> lightMainPageToPrimary,
    Color lightPanelPrimary,
    Map<S,Color> lightPanelPageToPrimary,
    Map<DarkStyle,Color> darkAccents,
    Map<DarkStyle,Color> darkMainPrimaries,
    Map<DarkStyle,Map<T,Color>> darkMainPageToPrimaries,
    Map<DarkStyle,Color> darkPanelPrimaries,
    Map<DarkStyle,Map<S,Color>> darkPanelPageToPrimaries,
  }) => StageColorsData<T,S>._(
    allMainPagesToFill: allMainPagesToFill,
    allPanelPagesToFill: allPanelPagesToFill,
    lightAccent: lightAccent ?? ((theme == null) ? null : ((theme.isLight) ? theme.accentColor : null)), 
    lightMainPrimary: lightMainPrimary ?? ((theme == null) ? null : (theme.isLight ? theme.primaryColor : null)), 
    lightMainPageToPrimary: lightMainPageToPrimary ?? null, 
    lightPanelPrimary: lightPanelPrimary ?? (theme == null ? null : (theme.isLight ? theme.primaryColor : null)), 
    lightPanelPageToPrimary: lightPanelPageToPrimary ?? null, 

    darkAccents: darkAccents ?? (theme == null ? null : (theme.isDark ? DarkStyles.mapWithSingleValue<Color>(theme.accentColor) : null)), 
    darkMainPrimaries: darkMainPrimaries ?? (theme == null ? null : (theme.isDark ? DarkStyles.mapWithSingleValue<Color>(theme.primaryColor) : null)), 
    darkMainPageToPrimaries: darkMainPageToPrimaries ?? null, 
    darkPanelPrimaries: darkPanelPrimaries ?? (theme == null ? null : (theme.isDark ? DarkStyles.mapWithSingleValue<Color>(theme.primaryColor) : null)), 
    darkPanelPageToPrimaries: darkPanelPageToPrimaries ?? null,
  );

  StageColorsData<T,S> fillWith(StageColorsData<T,S> other) => StageColorsData<T,S>._(
    allMainPagesToFill: null,
    allPanelPagesToFill: null,
    lightAccent: this.lightAccent ?? other?.lightAccent, 
    lightMainPrimary: this.lightMainPrimary ?? other?.lightMainPrimary, 
    lightMainPageToPrimary: this.lightMainPageToPrimary ?? other?.lightMainPageToPrimary, 
    lightPanelPrimary: this.lightPanelPrimary ?? other?.lightPanelPrimary, 
    lightPanelPageToPrimary: this.lightPanelPageToPrimary ?? other?.lightPanelPageToPrimary, 
    darkAccents: this.darkAccents ?? other?.darkAccents, 
    darkMainPrimaries: this.darkMainPrimaries ?? other?.darkMainPrimaries, 
    darkMainPageToPrimaries: this.darkMainPageToPrimaries ?? other?.darkMainPageToPrimaries, 
    darkPanelPrimaries: this.darkPanelPrimaries ?? other?.darkPanelPrimaries, 
    darkPanelPageToPrimaries: this.darkPanelPageToPrimaries ?? other?.darkPanelPageToPrimaries,
  );




  //================================
  // Static
  static Map<DarkStyle,Map<A,Color>> _getFullMapDarkPagesPrimaries<A>(Map<DarkStyle,Map<A,Color>> provided, Iterable<A> allPagesToFill){
    if(provided == null) return null;

    Set<A> keys = <A>{
      if(allPagesToFill != null)
        ...allPagesToFill
      else for(final map in provided.values)
        if(map != null)
          ...map.keys,
    };

    Map<A,Color> validMap;
    for(final map in provided.values){
      if(map != null){
        validMap = map;
        break;
      }
    }
    assert(validMap != null, "there has to be at least one map with some colors specified if you want different colors for each page");

    Color validColor;
    for(final color in validMap.values){
      if(color != null){
        validColor = color;
        break;
      }
    }
    assert(validColor != null, "there has to be at least one color specified if you want different colors for each page");

    return <DarkStyle,Map<A,Color>>{
      for(final style in DarkStyle.values)
        style: <A,Color>{
          for(final A key in keys)
            key: (provided[style] != null ? provided[style][key] : null) ?? validMap[key] ?? validColor
        },
    };
  }

  static Map<A,Color> _getFullMapPages<A>(Map<A,Color> provided, Iterable<A> allPagesToFill){
    if(provided == null) return null;

    Set<A> keys = <A>{
      if(allPagesToFill != null)
        ...allPagesToFill
      else ...provided.keys,
    };

    Color validColor;
    for(final color in provided.values){
      if(color != null){
        validColor = color;
        break;
      }
    }

    assert(validColor != null, "there has to be at least one color specified if you want different colors for each page");

    return <A,Color>{
      for(final A key in keys)
        key: provided[key] ?? validColor,
    };
  }

  static Map<DarkStyle,Color> _getFullMapDarkAccents(Map<DarkStyle,Color> provided)
    => <DarkStyle,Color>{
      for(final style in DarkStyle.values)
        if(provided != null)
          style: provided[style] ?? style.defaultAccent
        else 
          style: style.defaultAccent,
    };
  static Map<DarkStyle,Color> _getFullMapDarkPrimaries(Map<DarkStyle,Color> provided)
    => <DarkStyle,Color>{
      for(final style in DarkStyle.values)
        if(provided != null)
          style: provided[style] ?? style.defaultPrimary
        else 
          style: style.defaultPrimary,
    };


}



