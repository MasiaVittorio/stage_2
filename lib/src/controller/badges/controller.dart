part of stage;


class _StageBadgesData<T,S> {

  //================================
  // Disposer
  void dispose(){
    this.mainPages.dispose();
    this.panelPages.dispose();
  }


  //================================
  // Values

  final StageData<T,S> parent;

  final BlocVar<Map<T,bool>> mainPages;
  final BlocVar<Map<S,bool>> panelPages; //might be empty



  //================================
  // Constructor
  _StageBadgesData(this.parent): //pages controllers must already be initialized
    mainPages = BlocVar.modal<Map<T,bool>>(
      initVal: {
        for(T page in parent.mainPagesController.pagesData.keys)
          page: false,
      },
      key: parent._getStoreKey("stage_badges_controller_mainPages"), 
      toJson: (map) => <String,dynamic>{
        for(final e in map.entries)
          parent._writeMainPage(e.key): e.value,
      },
      fromJson: (json) => <T,bool>{
        for(final e in (json as Map).entries)
          parent._readMainPage(e.key): e.value as bool,
      },
      readCallback: (_) => parent._readCallback("stage_badges_controller_mainPages"),
    ),
    panelPages = BlocVar.modal<Map<S,bool>>(
      initVal: {
        for(S page in parent.panelPagesController?.pagesData?.keys ?? [])
          page: false,
      },
      key: parent._getStoreKey("stage_badges_controller_panelPages"), 
      toJson: (map) => <String,dynamic>{
        for(final e in map.entries)
          parent._writePanelPage(e.key): e.value,
      },
      fromJson: (json) => <S,bool>{
        for(final e in (json as Map).entries)
          parent._readPanelPage(e.key): e.value as bool,
      },
      readCallback: (_) => parent._readCallback("stage_badges_controller_panelPages"),
    );
    

  //===============================
  // Getters
  bool get _isCurrentlyReading => this.parent.storeKey != null && (
    this.mainPages.modalReading ||
    this.panelPages.modalReading
  );

  void setMainPage(T mainPage, bool val) 
    => this.mainPages.edit((map){
      map[mainPage] = val;
    });

  void showMainPage(T mainPage) 
    => setMainPage(mainPage, true);

  void clearMainPage(T mainPage) 
    => setMainPage(mainPage, false);

  void setPanelPage(S panelPage, bool val) 
    => this.panelPages.edit((map){
      if(map.containsKey(panelPage))
        map[panelPage] = val;
    });
  void showPanelPage(S panelPage) 
    => setPanelPage(panelPage, true);

  void clearPanelPage(S panelPage) 
    => setPanelPage(panelPage, false);

}