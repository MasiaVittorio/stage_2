part of stage;


class _StageContentState<T,S> extends State<_StageContent<T,S>> with TickerProviderStateMixin {


  //====================================
  // State 

  late AnimationController panelAnimation;
  late AnimationController snackBarAnimation;

  @override
  void initState(){
    super.initState();

    panelAnimation = AnimationController(
      vsync: this,
      lowerBound: 0.0, upperBound: 1.5,
      duration: const Duration(milliseconds: 500),
    )..addListener((){
      final double _val = panelAnimation.value;
      if(_val >= widget.data!.panelController.openedThreshold){
        if(widget.data!.panelController.isMostlyOpened.setDistinct(true)) /// If just opened
          widget.data!.panelController.snackbarController!.close();
      } else if(_val < widget.data!.panelController.closedThreshold) {
        widget.data!.panelController.isMostlyOpened.setDistinct(false);
      }
    });

    snackBarAnimation = AnimationController(
      vsync: this, 
      duration: const Duration(milliseconds: 400),
    ); 
    
    attachListeners();

    widget.data!.themeController
        .brightness._checkBrightness(context);
        /// this will use a scheduler.addPostFrameCallback()  to access the 
        /// MediaQuery.of(context) if needed, So it will not break the initState
  }

  @override
  void dispose(){
    panelAnimation.dispose();
    snackBarAnimation.dispose();
    super.dispose();
  }





  //====================================
  // Logic 

  void attachListeners(){
    widget.data!._attachListeners(
      panelPosition: () => panelAnimation.value.clamp(0.0, 1.0),
      panelVelocity: () => panelAnimation.velocity, 
      panelIsAnimating: () => panelAnimation.isAnimating,
      openPanel: this.openInternal, 
      closePanel: this.closeInternal,

      snackBarPosition: () => snackBarAnimation.value,
      snackBarVelocity: () => snackBarAnimation.velocity,
      snackBarIsAnimating: () => snackBarAnimation.isAnimating,   
      openSnackBar: () => snackBarAnimation.animateTo(1.0),
      closeSnackBar: () async {
        /// being often a delayed action, this has to make sure the stage was not disposed
        if(!mounted) return;
        await snackBarAnimation.animateBack(0.0);
      },
      // LOW PRIORITY: use curves?
    );
  }





  //=========================================
  // Animation controller

  Future<void> closeInternal() async {
    if(!mounted) return;
    if(panelAnimation.value != 0.0) {
      await this.panelAnimation.animateBack(
        0.0, 
        curve: Curves.easeOut,
        duration: Duration(microseconds: (220000 * (panelAnimation.value + (1-panelAnimation.value)/3)).round()),
      );
    }
    return;
  }

  Future<void> openInternal() async {
    if(panelAnimation.value != 1.0) {
      await this.panelAnimation.animateTo(
        1.0, 
        // curve: const Cubic(0.0, 0.0, 0.58, 1.0), // That would be ease out as defined by the material library

        // curve: const Cubic(0.5, 1.15, 0.5, 0.99), // that should be a more visible ease out but I dont really like it
        // duration: const Duration(milliseconds: 250),

        curve: Cubic(0.175, 0.885, 0.32, 1.1), // that overshoots a bit
        duration: const Duration(milliseconds: 300),
      );
    }
    return;
  }





  //========================================
  // Gestures
  void onPanelDrag(DragUpdateDetails details, double delta){
    final double _val = (panelAnimation.value - 1.2 * details.primaryDelta! / delta).clamp(0.0, 1.0);
    if(_val != panelAnimation.value){
      //change the value only if necessary, we do not want
      //to call listeners for no reasons
      panelAnimation.value = _val;
    }
  }

  void onPanelDragEnd(DragEndDetails details)
    => widget.data!.panelController._onPanelDragEnd(details);






  //====================================
  // Build

  @override
  Widget build(BuildContext context) {

    final MediaQueryData mediaQuery = MediaQuery.of(context);
    final StageData<T,S> data = widget.data!;

    final Widget topBar = widget.topBarBuilder(this.panelAnimation);

    final Widget panelBackground = Positioned.fill(child:_PanelBackground(
      animation: panelAnimation, 
      backgroundColor: widget.backgroundColor,
      backgroundOpacity: widget.backgroundOpacity,
    ),);


    final Widget scaffoldBody = data.isReadingFromDisk.build(((_, isReading) => (isReading && widget.splashScreen != null) 
      ? SizedBox.expand(child: widget.splashScreen)
      : data.dimensionsController.dimensions.build((_, dimensions){

        Widget builder(BuildContext context, BoxConstraints constraints){

          final _StageDerivedDimensions derived = _StageDerivedDimensions(
            base: dimensions,
            panelPages: data.panelPagesController != null,
            constraints: constraints,
            mediaQuery: mediaQuery,
          );

          final Widget? boxedCollapsed = (widget.collapsedPanel != null) 
            ? _BoxedCollapsedPanel( 
              widget.collapsedPanel!,
              dimensions: dimensions,
              derived: derived,
            )
            : null;
          
          final Widget boxedExtended = _BoxedExtendedPanel<T,S>(
            widget.extendedPanelBuilder == null 
              ? widget.extendedPanel!
              : Builder(builder: (context) 
                => widget.extendedPanelBuilder!(context, panelAnimation)
              ), 
            derived: derived,
            dimensions: dimensions,
            data: data,
          );

          final double bodyHeight = constraints.maxHeight - derived.minTopBarSize - derived.bottomBarSize;
          final Widget boxedBody = SizedBox(
            width: constraints.maxWidth,
            height: bodyHeight,
            child: MediaQuery(
              data: mediaQuery.copyWith(
                padding: EdgeInsets.only(bottom: dimensions.collapsedPanelSize / 2),
              ),
              child: widget.body,
            ),
          );

          final Widget bottomNavBar = Positioned(
            bottom: 0.0,
            left: 0.0,
            right: 0.0,
            height: derived.bottomBarSize, /// This needs mediaQuery (derived dimensions) because of the bottom padding
            /// e.g.: iPhones have that bar at the bottom that needs to be avoided
            child: _BottomBar<T,S>(),
          );

          return SizedBox(
            width: constraints.maxWidth,
            height: constraints.maxHeight,
            child: BlocVar.build2<bool,double?>(
              data.panelController.alertController!.isShowing!, 
              data.panelController.alertController!.currentSize!, 
              builder: (_, bool? alert, double? alertSize){
                
                /// This depends on the current desired alert Size, so cannot be 
                /// done agnostically in the derived dimensions before 
                final double maxAlertHeight = (alertSize ?? 0.0).clamp(
                  dimensions.collapsedPanelSize, 
                  derived.alertHeightClamp,
                );

                final double realDelta = alert!
                  ? maxAlertHeight - dimensions.collapsedPanelSize // alert delta
                  : derived.panelDelta; // regular panel delta

                final Widget bottomGesture = Positioned(
                  bottom: 0.0,
                  left: 0.0,
                  right: 0.0,
                  height: derived.bottomBarSize,
                  child: _BottomGesture(
                    onPanelDrag: (details) => this.onPanelDrag(details, realDelta),
                    onPanelDragEnd: this.onPanelDragEnd,
                  ),
                );

                final Widget alertBackground = Positioned.fill(child: _AlertBackground(
                  onPanelDrag: (details) => this.onPanelDrag(details, realDelta),
                  onPanelDragEnd: this.onPanelDragEnd,
                  // animation: this.panelAnimation, 
                  backgroundColor: widget.backgroundColor,
                  backgroundOpacity: widget.backgroundOpacity, 
                ),);

                final Widget panel = _Panel(
                  maxAlertHeight: maxAlertHeight, 
                  dimensions: dimensions, 
                  boxedCollapsed: boxedCollapsed, 
                  boxedExtended: boxedExtended, 
                  realDelta: realDelta, 
                  derived: derived, 
                  panelAnimation: this.panelAnimation, 
                  snackBarAnimation: this.snackBarAnimation, 
                  onPanelDrag: this.onPanelDrag, 
                  onPanelDragEnd: this.onPanelDragEnd,
                  shadowBuilder: widget.shadowBuilder, 
                  singleShadow: widget.singleShadow,
                );

                return AnimatedBuilder(animation: panelAnimation, child: panel, builder: (_, child){
                  /// the animated builder must be around the stack and not around the two children in need of the animation value
                  /// because the stack wants pure [Positioned] children in its list, so they cannot be wrapped inside AnimatedBuilder themselves

                  final double pureVal = panelAnimation.value;
                  final double clampedVal = pureVal.clamp(0.0, 1.0);


                  return Stack(
                    fit: StackFit.expand,
                    children: <Widget>[

                      Positioned(
                        left: 0.0,
                        right: 0.0,
                        height: bodyHeight,
                        top: derived.minTopBarSize - (alert ? 0.0 : dimensions.parallax*clampedVal*realDelta),
                        child: boxedBody,
                      ),

                      bottomNavBar,

                      panelBackground,

                      bottomGesture,

                      //Top App Bar
                      Positioned(
                        top: 0.0,
                        left: 0.0,
                        right: 0.0,
                        height: 8.0 // extra space at the bottom to display the shadow properly 
                          + DoubleExt.mapToRange(
                            (!alert // Expand the app bar while opening the panel
                              ? clampedVal // But only if the regular panel is opened 
                              : 0.0 // (NOT alerts)
                            ),
                            derived.minTopBarSize, 
                            derived.maxTopBarSize
                          ),
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 8.0), // cast shadow
                          child: topBar, 
                        ),
                      ),

                      alertBackground,

                      //Panel
                      Positioned(
                        left: 0.0,
                        right: 0.0,
                        bottom: derived.bottomBarSize // avoid the bottom bar
                          - dimensions.collapsedPanelSize/2 // bit of overlap with the top part of the bottom bar
                          - clampedVal * derived.maxDownExpansion // expand down over the bottom bar while opening
                          + (alert ? mediaQuery.viewInsets.bottom : 0.0), // make the panel avoid keyboard only if alert is shown,
                        height: dimensions.collapsedPanelSize + pureVal * realDelta, // current panel size
                        child: child!,
                      ),

                    ],
                  );
                },);
              },
            ),
          );
        }

        if(widget.wholeScreen){
          final BoxConstraints constraints = BoxConstraints(
            maxWidth: mediaQuery.size.width,
            maxHeight: mediaQuery.size.height,
          );
          return builder(context, constraints);
        } else {
          return LayoutBuilder(builder: (cont,constr) => ConstrainedBox(
            constraints: constr,
            child: builder(cont, constr),
          ),);
        }

      })
    ));

    return data.themeController.derived.themeData!.build(((_,theme) => Theme(
      data: theme,
      child: ListTileTheme.merge(
        iconColor: theme.textTheme.bodyText2?.color,
        child: WillPopScope(
          onWillPop: () => data._decidePop(),
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: scaffoldBody,
          ),
        ),
      ),)),
    );
  }

}

