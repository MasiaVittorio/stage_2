part of stage;

///This is the controller of a [Stage]. It contains all the logic of it.
/// You can access it by calling [Stage.of(context)].
/// You can have it store its values (for user-side customizations) on disk by providing an unique key 
/// that distinguish it from others.
/// The main pages are identified by the T type, the panel pages (optional), by the S type.
class StageData<T,S> {


  //================================
  // Disposer
  void dispose(){
    isReadingFromDisk?.dispose();
    panelPagesController?.dispose();
    mainPagesController?.dispose();
    panelController?.dispose();
    dimensionsController?.dispose();
    themeController?.dispose();
  }




  //================================
  // Values

  /// the key used by this stage controller to store variables on disk
  /// (if not provided, those values will not be written or read)
  final String storeKey;

  /// Persistence
  final T Function(dynamic) _jsonToMainPage; /// Reading the main page from disk
  final dynamic Function(T) _mainPageToJson; /// Writing a main page to disk (useless if T is an already jsonable type like String or int)
  final S Function(dynamic) _jsonToPanelPage;
  final dynamic Function(S) _panelPageToJson;

  /// wether this controller is still reading the 
  /// saved values from disk for at least one variable
  final BlocVar<bool> isReadingFromDisk = BlocVar<bool>(true);

  /// Controllers
  _StageDimensionsData dimensionsController; /// Panel / Scaffold dimensions and stuff
  _StagePagesData<T> mainPagesController; /// Main screen navigation
  _StagePagesData<S> panelPagesController; /// In-panel navigation: This whole controller may be null if the panel does not have different pages
  _StagePanelData panelController; /// Opening and closing the panel
  _StageThemeData<T,S> themeController; /// Theming options (Colors / Brightnesses...)
  final StagePopBehavior popBehavior; /// Cannot be customize by the user or change over time



  //================================
  // Constructor
  StageData({
    // Persistence
    @required this.storeKey,
    @required T Function(dynamic) jsonToMainPage,
    @required dynamic Function(T) mainPageToJson,
    @required S Function(dynamic) jsonToPanelPage,
    @required dynamic Function(S) panelPageToJson,

    // Initial data
    @required StageThemeData<T,S> initialThemeData,
    @required StagePagesData<T> initialMainPagesData,
    @required StagePagesData<S> initialPanelPagesData, /// Could be null
    @required StageDimensions initialDimensions, /// Could be null
    @required StagePanelData panelData, /// Could be null
    @required void Function(T) onMainPageChanged,

    @required StagePopBehavior popBehavior, /// Could be null
  }) :
      _jsonToMainPage = jsonToMainPage,
      _jsonToPanelPage = jsonToPanelPage,
      _mainPageToJson = mainPageToJson,
      _panelPageToJson = panelPageToJson,
      popBehavior = popBehavior ?? const StagePopBehavior()
  {

    panelController = _StagePanelData(
      this,
      initialData: panelData ?? StagePanelData(),
    );

    dimensionsController = _StageDimensionsData(
      this,
      initialDimensions: initialDimensions ?? const StageDimensions(),
    );

    mainPagesController = _StagePagesData<T>(
      this,
      uniqueKey: "MAIN",
      onPageChanged: onMainPageChanged,
      initialData: initialMainPagesData,
      pageToJson: (T p) => _writeMainPage(p), 
      jsonToPage: (j) => _readMainPage(j),
      /// ^ Needed explicitly as it is different if the pages controller is dedicated to the panel or the main pages
    );

    /// This whole controller may be null if the panel does not have different pages
    panelPagesController = initialPanelPagesData == null ? null : _StagePagesData<S>(
      this,
      uniqueKey: "PANEL",
      onPageChanged: null,
      initialData: initialPanelPagesData,
      pageToJson: (S p) => _writePanelPage(p),
      jsonToPage: (j) => _readPanelPage(j),
      /// ^ Needed explicitly as it is different if the pages controller is dedicated to the panel or the main pages
    );

    
    /// This controller has some variables that are derived from the current page and the state of the panel.
    /// Therefore it has to be initialized last
    themeController = _StageThemeData<T,S>(
      this,
      initialData: initialThemeData,
    );
    _readCallback("controller initialized");

    Future.delayed(Duration(milliseconds: 100)).then((_){
      _readCallback("controller initialized delayed for safety");
    }); /// Some of the BlocVars callbacks are not called for some misterious fucking reason

  }





  //====================================
  // Private Stuff
  String _getStoreKey(String end) => storeKey == null ? null : "$_defKey // $storeKey // $end";
  static const String _defKey = "MVSidereus Art, Package: Stage, unique default Store Key";

  void _readCallback(String note) async {
    final bool current = _isCurrentlyReading;
    this.isReadingFromDisk.setDistinct(current);
  }

  bool get _isCurrentlyReading => this.storeKey != null && (
    (this.dimensionsController?._isCurrentlyReading ?? true) ||
    (this.mainPagesController?._isCurrentlyReading ?? true) ||
    (this.themeController?._isCurrentlyReading ?? true) || // if these and  up are null it means that those controllers are not initialised yet
    (this.panelPagesController?._isCurrentlyReading ?? false) 
  );

  S _readPanelPage(dynamic j) => this._jsonToPanelPage?.call(j) ?? j as T;
  dynamic _writePanelPage(S p) => this._panelPageToJson?.call(p) ?? p;
  T _readMainPage(dynamic j) => this._jsonToMainPage?.call(j) ?? j as T;
  dynamic _writeMainPage(T p) => this._mainPageToJson?.call(p) ?? p;


  Future<bool> _decidePop() async {
    
    final _StageSnackBarData snackBarData = panelController.snackbarController;
    final _StageAlertData alertData = panelController.alertController;


    if(snackBarData.isShowing.value){
      snackBarData.close();
      return false;
    } else if(alertData.isShowing.value){
      if(panelController.isMostlyOpened.value){
        panelController.close();
        return false;
      }
    } else {
      if(panelController.isMostlyOpened.value){
        if(popBehavior.backToPreviousPanelPage){
          /// The entire panel pages controller may be null if the panel does not have pages
          if(panelPagesController?._backToPreviousPage() ?? false){
            return false; 
          } 
          /// While the pop behavior always has non null parameters
        }
        if(popBehavior.backToDefaultPanelPage){
          if(panelPagesController?._backToDefaultPage() ?? false){
            return false;
          }
        }
        if(popBehavior.backToClosePanel){
          panelController.close();
          return false;
        }
      } else {
        if(popBehavior.backToPreviousMainPage){
          if(mainPagesController._backToPreviousPage()){
            return false;
          }
        }
        if(popBehavior.backToDefaultMainPage){
          if(mainPagesController._backToDefaultPage()){
            return false;
          }
        }
      }
    }
    return true;
  } 




}