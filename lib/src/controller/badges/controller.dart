part of 'package:stage/stage.dart';

class _StageBadgesData<T, S> {
  //================================
  // Disposer
  void dispose() {
    mainPages.dispose();
    panelPages.dispose();
  }

  //================================
  // Values

  final StageData<T, S> parent;

  final Reactive<Map<T, bool>> mainPages;
  final Reactive<Map<S, bool>> panelPages; //might be empty

  //================================
  // Constructor
  _StageBadgesData(this.parent)
      : //pages controllers must already be initialized
        mainPages = Reactive.modal<Map<T, bool>>(
          initVal: {
            for (T page in parent.mainPagesController.pagesData.keys) page: false,
          },
          key: parent._getStoreKey("stage_badges_controller_mainPages"),
          toJsonEncodable: (map) => <String?, dynamic>{
            for (final e in map.entries) parent._writeMainPage(e.key): e.value,
          },
          fromJsonDecoded: (json) => <T, bool>{
            for (final e in (json as Map).entries) parent._readMainPage(e.key): e.value as bool,
          },
          readCallback: (_) => parent._readCallback("stage_badges_controller_mainPages"),
        ),
        panelPages = Reactive.modal<Map<S, bool>>(
          initVal: {
            for (S page in parent.panelPagesController?.pagesData.keys ?? []) page: false,
          },
          key: parent._getStoreKey("stage_badges_controller_panelPages"),
          toJsonEncodable: (map) => <String?, dynamic>{
            for (final e in map.entries) parent._writePanelPage(e.key): e.value,
          },
          fromJsonDecoded: (json) => <S, bool>{
            for (final e in (json as Map).entries) parent._readPanelPage(e.key): e.value as bool,
          },
          readCallback: (_) => parent._readCallback("stage_badges_controller_panelPages"),
        );

  //===============================
  // Getters
  bool get _isCurrentlyReading =>
      parent.storeKey != null && (mainPages.modalReading || panelPages.modalReading);

  void setMainPage(T mainPage, bool val) => mainPages.edit((map) {
        map[mainPage] = val;
      });

  void showMainPage(T mainPage) => setMainPage(mainPage, true);

  void clearMainPage(T mainPage) => setMainPage(mainPage, false);

  void setPanelPage(S panelPage, bool val) => panelPages.edit((map) {
        if (map.containsKey(panelPage)) {
          map[panelPage] = val;
        }
      });
  void showPanelPage(S panelPage) => setPanelPage(panelPage, true);

  void clearPanelPage(S panelPage) => setPanelPage(panelPage, false);
}
