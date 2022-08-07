part of stage;

class StageDimensions{

  //=============================
  // Values
  final double barSize;
  final double collapsedPanelSize;
  final double panelRadiusClosed;
  final double panelRadiusOpened;
  final double panelHorizontalPaddingClosed;
  final double panelHorizontalPaddingOpened;
  final bool forceOpenedPanelOverNavBar;
  final double parallax; /// 1.0 makes the body move like the panel, 0.1 is recommended

  //=============================
  // Constructor
  const StageDimensions({
    double? barSize,
    double? collapsedPanelSize,
    double? panelRadiusClosed,
    double? panelRadiusOpened,
    double? panelHorizontalPaddingClosed,
    double? panelHorizontalPaddingOpened,
    double? parallax,
    bool? forceOpenedPanelOverNavBar = true,
  }):
    barSize = barSize ?? defaultBarSize,
    collapsedPanelSize = collapsedPanelSize ?? defaultCollapsedPanelSize,
    panelRadiusClosed = panelRadiusClosed ?? defaultPanelRadius,
    panelRadiusOpened = panelRadiusOpened ?? panelRadiusClosed ?? defaultPanelRadius,
    panelHorizontalPaddingClosed = panelHorizontalPaddingClosed ?? defaultPanelHorizontalPaddingClosed,
    panelHorizontalPaddingOpened = panelHorizontalPaddingOpened ?? panelHorizontalPaddingClosed ?? defaultPanelHorizontalPaddingOpened,
    forceOpenedPanelOverNavBar = forceOpenedPanelOverNavBar ?? true,
    parallax = parallax ?? defaultParallax;


  //==============================
  // Copier

  StageDimensions copyWith({
    double? barSize,
    double? collapsedPanelSize,
    double? panelRadiusClosed,
    double? panelRadiusOpened,
    double? panelHorizontalPaddingClosed,
    double? panelHorizontalPaddingOpened,
    bool? forceOpenedPanelOverNavBar,
    bool? parallax,
  }) => StageDimensions(
    barSize: barSize ?? this.barSize,
    collapsedPanelSize: collapsedPanelSize ?? this.collapsedPanelSize,
    panelHorizontalPaddingClosed: panelHorizontalPaddingClosed ?? this.panelHorizontalPaddingClosed,
    panelHorizontalPaddingOpened: panelHorizontalPaddingOpened ?? this.panelHorizontalPaddingOpened,
    panelRadiusClosed: panelRadiusClosed ?? this.panelRadiusClosed,
    panelRadiusOpened: panelRadiusOpened ?? this.panelRadiusOpened,
    forceOpenedPanelOverNavBar: forceOpenedPanelOverNavBar ?? this.forceOpenedPanelOverNavBar,
    parallax: parallax as double? ?? this.parallax,
  );


  //============================
  // Default data
  static const double defaultBarSize = 56.0;
  static const double defaultCollapsedPanelSize = 72.0;
  static const double defaultPanelRadius = 8.0;
  static const double defaultPanelHorizontalPaddingClosed = 16.0;
  static const double defaultPanelHorizontalPaddingOpened = 12.0;
  static const double defaultPanelHorizontalPaddingDelta = 
    defaultPanelHorizontalPaddingClosed - defaultPanelHorizontalPaddingOpened;
  static const double defaultParallax = 0.0;


  //=============================
  // Persistence
  Map<String,dynamic> get json => <String,dynamic>{
    "barSize": barSize,
    "collapsedPanelSize": collapsedPanelSize,
    "panelRadiusClosed": panelRadiusClosed,
    "panelRadiusOpened": panelRadiusOpened,
    "panelHorizontalPaddingClosed": panelHorizontalPaddingClosed,
    "panelHorizontalPaddingOpened": panelHorizontalPaddingOpened,
    "forceOpenedPanelOverNavbar": forceOpenedPanelOverNavBar,
    "parallax": parallax,
  };

  static StageDimensions fromJson(dynamic json) => StageDimensions(
    barSize: json["barSize"],
    collapsedPanelSize: json["collapsedPanelSize"],
    panelHorizontalPaddingClosed: json["panelHorizontalPaddingClosed"],
    panelHorizontalPaddingOpened: json["panelHorizontalPaddingOpened"],
    panelRadiusClosed: json["panelRadiusClosed"],
    panelRadiusOpened: json["panelRadiusOpened"],
    forceOpenedPanelOverNavBar: json["forceOpenedPanelOverNavbar"],
    parallax: json["parallax"] ?? defaultParallax,
  );


  //=============================
  // Getters
  double bottomBarSize(MediaQueryData mediaQuery) => barSize + collapsedPanelSize/2 + RadioNavBar.bottomPaddingFromMQ(mediaQuery);

}

extension _BoxConstraintsSize on BoxConstraints {
  Size get size => Size(maxWidth, maxHeight);
}


class _StageDerivedDimensions {
  _StageDerivedDimensions({
    required StageDimensions base,
    required bool panelPages,
    required BoxConstraints constraints,
    required MediaQueryData mediaQuery,
  }){
    final bool landscape = constraints.size.aspectRatio >= 1.0;


    panelWidthOpened = constraints.maxWidth - base.panelHorizontalPaddingOpened*2;
    panelWidthClosed = constraints.maxWidth - base.panelHorizontalPaddingClosed*2;

    topPadding = mediaQuery.padding.top;
    bottomBarSize = base.bottomBarSize(mediaQuery);
    minTopBarSize = topPadding + base.barSize;
    extendedAppBarSize = base.barSize + base.collapsedPanelSize/(landscape ? 2:1);
    maxTopBarSize = topPadding + extendedAppBarSize;

    maxDownExpansion = (panelPages) || (base.forceOpenedPanelOverNavBar)
      ? base.barSize - minimumBottomPadding(base)
      : 0.0;

    panelMinBottomPosition
        = bottomBarSize // away from bottom
        - base.collapsedPanelSize/2 // but a bit of overlap
        - maxDownExpansion; // and more overlap if needed

    totalPanelHeight 
      = constraints.maxHeight // total height
      - panelMinBottomPosition // away from bottom
      - maxTopBarSize // away from top
      + base.collapsedPanelSize/2; // but a bit of overlap

    panelDelta = totalPanelHeight - base.collapsedPanelSize;

    panelMinBottomPositionKeyboard
        = panelMinBottomPosition
        + mediaQuery.viewInsets.bottom; // Keyboard

    alertHeightClamp 
        = (constraints.maxHeight // total height
        - topPadding // away from top (just notification bar, not whole app bar)
        - panelMinBottomPositionKeyboard // away from keyboard
        - minimumBottomPadding(base)) // and a bit more away
        .clamp(base.collapsedPanelSize, double.infinity); /// It cannot be smaller than the collapsed panel tho, 
        /// so if the keyboard is fucking huge the alert will go higher than the screen, fuck it


  }

  late double panelWidthOpened; /// in general it can be opened and use this value even if it is just for an alert!
  late double panelWidthClosed;

  late double topPadding; /// System notification bar
  late double bottomBarSize; /// Colored part from the bottom of the screen
  late double minTopBarSize; /// Accounting for top padding when panel is closed
  late double extendedAppBarSize; /// When panel is opened (without accounting for top padding)
  late double maxTopBarSize; /// Accounting for top padding when panel is opened 
  late double maxDownExpansion; /// How much the panel goes down if it does

  // static const double minimumBottomPadding = 16.0; /// If expanding the panel down, leave this space from the bottom
  double minimumBottomPadding(StageDimensions base) 
    => base.panelHorizontalPaddingOpened; // If expanding the panel down, leave this space from the bottom


  late double panelMinBottomPosition; /// Accounts for the base position of the panel and the expansion ONLY (use it for the regular panel)
  late double totalPanelHeight; /// NOT in case of alert
  late double panelDelta; /// Difference between max and minimum dimension of the panel (NOT in case of alert)

  late double panelMinBottomPositionKeyboard; /// Accounts for the base position of the panel and the expansion AND THE KEYBOARD (use it only if alert is shown)
  late double alertHeightClamp; /// Maximum extent of an alert (accounts for keyboard) 
  /// IMPORTANT: this is agnostic of the desired height of the alert being shown, which may be smaller

}

