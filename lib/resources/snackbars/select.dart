import 'package:stage/stage.dart';
import 'package:flutter/material.dart';


class SelectSnackbar extends StatelessWidget {
  const SelectSnackbar({
    required this.children,
    this.initialIndex,
    required this.onTap,
    this.autoClose = true,
  });
  final List<Widget> children;
  final int? initialIndex;
  final void Function(int) onTap;
  final bool autoClose;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (_, constraints)
      => _SnackbarSelector(
        height: constraints.maxHeight,
        width: constraints.maxWidth,
        initialIndex: initialIndex,
        onTap: onTap,
        autoClose: autoClose, 
        children: children,
      ),
    );
  }
}

class _SnackbarSelector extends StatefulWidget {
  const _SnackbarSelector({
    required this.width,
    required this.height,
    required this.children,
    required this.initialIndex,
    required this.autoClose,
    required this.onTap,
  });

  final double height;
  final double width;
  final List<Widget> children;
  final int? initialIndex;
  final void Function(int) onTap;
  final bool autoClose;

  @override
  _SnackbarSelectorState createState() => _SnackbarSelectorState();
}

class _SnackbarSelectorState extends State<_SnackbarSelector> with SingleTickerProviderStateMixin {

  late AnimationController animationController;
  late ScrollController scrollController;
  int? selectedIndex;

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.initialIndex;
    scrollController = ScrollController(
      initialScrollOffset: initialScrollOffset,
    );
    animationController = AnimationController(
      vsync: this, 
      value: 0,
      upperBound: 1.5,
      duration: const Duration(milliseconds: 800),
    );
    prepare();
  }

  void prepare(){
    animationController.animateTo(1, curve: Curves.easeOutBack);
  }

  @override
  void dispose() {
    animationController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  //make the selected element visible at start
  double get initialScrollOffset {
    final max = maxOffset;
    if(max <=0) return 0;
    return (
      elementWidth * ( //scroll the selected one at the top
        (widget.initialIndex ?? 0.0)
        + 1 //another step to make it disappear
      )
      - visibleWidth //and then put it at the bottom of the view
    ).clamp(0.0, maxOffset);
  } //this prevents useless scroll for the first few items

  double elementOffset(int index) => elementWidth * index * 1.0;
  double get elementWidth => widget.height + 5.0;
  double get occupiedSpace => widget.children.length * elementWidth * 1.0;
  double get maxOffset => occupiedSpace - visibleWidth;
  double get visibleWidth => widget.width - widget.height;
  //the snackbar is occupied by the closing button at the right, but you can paint content below it

  @override
  Widget build(BuildContext context) {
    final StageData stage = Stage.of(context)!;
    final bool rightAligned = stage.panelController.snackbarController.snackBarRightAligned;

    List<Widget> children = <Widget>[
      for(int i=0; i<widget.children.length; ++i)
        IconTheme.merge(
          data: IconThemeData(
            opacity: i == selectedIndex ? 1.0 : 0.65,
            size: i == selectedIndex ? 25 : 23,
          ),
          child: StageSnackButton(
            onTap: (){
              widget.onTap(i);
              setState((){
                selectedIndex = i;
              });
            },
            accent: i == selectedIndex,
            autoClose: widget.autoClose, 
            child: widget.children[i],
          ),
        ),
      StageSnackButton.placeHolder,
    ];

    if(!rightAligned) children = children.reversed.toList();

    late Widget child;

    if(occupiedSpace < visibleWidth){
      child = Row(children: [
        for(int i=0; i<children.length; i++)
          ...[
            children[i],
            if(i<children.length - 2)
              const Spacer(flex: 3,)
            else if(i == children.length - 1) 
              const Spacer(flex: 1,),
          ]
      ],);
    } else {
      child = SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        reverse: !rightAligned,
        controller: scrollController,
        physics: SidereusScrollPhysics(
          topBounce: true,
          topBounceCallback: stage.closeSnackBar,
          alwaysScrollable: true,
          neverScrollable: false,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: children.separateWith(const SizedBox(width: 5)),
        ),
      );
    }


    return AnimatedBuilder(
      animation: animationController,
      child: child,
      builder: (_, child)
        => Transform.translate(
          offset: Offset(
            (1 - animationController.value) * 
            (rightAligned ? 200 : -200), 
            0,
          ),
          child: child,
        ),
    );
  }
}