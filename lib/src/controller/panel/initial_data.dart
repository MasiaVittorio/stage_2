part of stage;

class StagePanelData {
  
  //==================================
  // Values
  final VoidCallback onPanelClose; /// Could be null
  final VoidCallback onPanelOpen; /// Could be null
  final double openedThreshold;
  final double closedThreshold;

  //==================================
  // Constructor
  StagePanelData({
    this.onPanelClose, /// Could be null
    this.onPanelOpen, /// Could be null
    double openedThreshold,
    double closedThreshold,
  }): 
    openedThreshold = openedThreshold ?? defaultOpenedThreshold,
    closedThreshold = math.min(
      closedThreshold ?? defaultClosedThreshold,
      openedThreshold ?? defaultOpenedThreshold,
    );
    
  //==================================
  // Default data
  static const double defaultOpenedThreshold = 0.6;
  static const double defaultClosedThreshold = 0.4;


}