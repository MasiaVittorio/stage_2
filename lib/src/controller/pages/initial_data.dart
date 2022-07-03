part of stage;


class StagePagesData<T> {

  ///====================================================
  /// Values

  final T? defaultPage; /// Navigation (back button / pop behavior)
  
  final List<T>? orderedPages; 
 
  final Map<T,StagePage?>? pagesData; /// Names, icons and stuff

  final Map<T,bool>? enabledPages;


  //==================================
  // Constructor
  StagePagesData._({
    required this.defaultPage,
    required Map<T, StagePage?> this.pagesData,
    List<T>? orderedPages,
    Map<T,bool?>? enabledPages,
  }): 
    assert(defaultPage is T),
    enabledPages = _getEnabled(enabledPages, pagesData, orderedPages),
    orderedPages = orderedPages ?? <T>[...pagesData.keys];


  /// If there is not another stage wrapping the current one, you will need to specify defaultPage and pagesData at least!
  const StagePagesData.nullable({
    this.defaultPage,
    this.enabledPages,
    this.orderedPages,
    this.pagesData,
  });

  StagePagesData<T>? get complete => _create<T>(
    inheritedData: null,
    manualNullable: this,
  );

  static StagePagesData<T>? _create<T>({
    required StagePagesData<T>? inheritedData,
    required StagePagesData<T>? manualNullable,
  }) => (manualNullable?.fillWith(inheritedData) ?? inheritedData);



  Set<T> get _allKeys => <T>{
    if(orderedPages != null)
      ...orderedPages!,
    if(enabledPages != null)
      ...enabledPages!.keys,
    if(pagesData != null)
      ...pagesData!.keys,
  };

  StagePagesData<T> fillWith(StagePagesData<T>? other) {
    final Set<T> keys = <T>{
      ...this._allKeys,
      if(other != null)
        ...other._allKeys,
    };

    return StagePagesData._(
      defaultPage: this.defaultPage ?? other?.defaultPage,
      orderedPages: this.orderedPages ?? other?.orderedPages,
      pagesData: <T,StagePage?>{
        for(final T key in keys)
          key: (this.pagesData != null ? this.pagesData![key] : null) 
            ?? (other?.pagesData != null ? other?.pagesData![key] : null),
      },
      enabledPages: <T,bool?>{
        for(final T key in keys)
          key: (this.enabledPages != null ? this.enabledPages![key] : null) 
            ?? (other?.enabledPages != null ? other?.enabledPages![key] : null),
      },
    );
  }


  //================================
  // Static
  static Map<T,bool> _getEnabled<T>(Map<T,bool?>? starting, Map<T,StagePage?> pagesData, List<T>? orderedPages){
    return <T,bool>{
      for(final T key in <T>{
        ...pagesData.keys, 
        if(starting != null)
          ...starting.keys, 
        if(orderedPages != null)
          ...orderedPages
      })
        key: (starting == null 
          ? null 
          : starting[key]
        ) ?? true,
    };
  }

}
