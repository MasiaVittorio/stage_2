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
    bool rememberPanelPage = false,

    bool backToPreviousMainPage = true,
    bool backToDefaultMainPage = false,

    bool backToPreviousPanelPage = false,
    bool backToDefaultPanelPage = true,

    bool backToClosePanel = true,
  }):
    rememberPanelPage = rememberPanelPage,

    backToPreviousMainPage = backToPreviousMainPage,
    backToDefaultMainPage = backToDefaultMainPage,

    backToPreviousPanelPage = backToPreviousPanelPage,
    backToDefaultPanelPage = backToDefaultPanelPage,

    backToClosePanel = backToClosePanel;
}