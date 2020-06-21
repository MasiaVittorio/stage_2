part of stage;


class StagePopBehavior {
  //=========================================
  // Values
  final bool rememberPanelPage;

  final bool backToPreviousMainPage;
  final bool backToDefaultMainPage;

  final bool backToPreviousPanelPage;
  final bool backToDefaultPanelPage;

  final bool backToClosePanel;


  //=========================================
  // Constructor
  const StagePopBehavior({
    bool rememberPanelPage,

    bool backToPreviousMainPage,
    bool backToDefaultMainPage,

    bool backToPreviousPanelPage,
    bool backToDefaultPanelPage,

    bool backToClosePanel,
  }):
    rememberPanelPage = rememberPanelPage ?? false,

    backToDefaultMainPage = backToDefaultMainPage ?? false,
    backToPreviousMainPage = backToPreviousMainPage ?? true,

    backToDefaultPanelPage = backToDefaultPanelPage ?? true,
    backToPreviousPanelPage = backToPreviousPanelPage ?? false,

    backToClosePanel = backToClosePanel ?? true;
}