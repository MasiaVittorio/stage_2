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
    this.rememberPanelPage = false,

    this.backToPreviousMainPage = true,
    this.backToDefaultMainPage = false,

    this.backToPreviousPanelPage = false,
    this.backToDefaultPanelPage = true,

    this.backToClosePanel = true,
  });

}