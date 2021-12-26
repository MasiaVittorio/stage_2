// import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:stage/stage.dart';

enum RadioAnimation {
  verticalSwap, /// All the children coexist in the stack and their state is kept
  horizontalFade, /// Google's standard animation, smooth and fast but doesn't keep the state of the non visible children
  none, /// Not animated, if the children are really heavy this can be desirable?
}


class RadioHeaderedItem extends RadioNavBarItem {
  final Widget child;
  final String longTitle;
  final bool alreadyScrollableChild;

  const RadioHeaderedItem({
    required this.longTitle,
    required this.child,
    String? title,
    required IconData icon,
    IconData? unselectedIcon,
    Color? color,
    double? iconSize,
    this.alreadyScrollableChild = false,
  }): super(
    title: title ?? longTitle,
    icon: icon,
    unselectedIcon: unselectedIcon,
    color: color,
    iconSize: iconSize,
  );
}

class RadioHeaderedAlert<T> extends StatefulWidget {

  const RadioHeaderedAlert({
    this.orderedValues,
    required this.items,
    this.initialValue,
    this.bottomAccentColor,
    bool accentSelected = false,
    this.animationType = RadioAnimation.horizontalFade,
    this.onPageChanged,
    this.canvasBackground = false,
    this.bottomAction,
    this.withoutHeader = false,
    this.customScrollPhysics,
  }): this.accentSelected = (bottomAccentColor != null) || accentSelected;


  final Map<T,RadioHeaderedItem> items;
  final T? initialValue;
  final List<T>? orderedValues;
  final Color? bottomAccentColor;
  final bool accentSelected;
  final bool canvasBackground;
  final RadioAnimation animationType;
  final void Function(T)? onPageChanged;
  final Widget? bottomAction;
  final bool withoutHeader;

  /// If we need to use this not as an alert in a panel but elsewhere
  final ScrollPhysics? customScrollPhysics;

  @override
  _RadioHeaderedAlertState<T> createState() => _RadioHeaderedAlertState<T>();
}

class _RadioHeaderedAlertState<T> extends State<RadioHeaderedAlert<T>> {

  late T page;
  late List<T> orderedPages;
  T? previous;

  @override
  void initState() {
    super.initState();
    orderedPages = widget.orderedValues ?? widget.items.keys.toList();
    page = (widget.initialValue ?? orderedPages.first)!;
  }

  @override
  Widget build(BuildContext context) {
    return _RadioHeaderedAlertWidget<T>(
      page: page, 
      items: widget.items,
      orderedPages: orderedPages, 
      onSelect: (T newVal) => this.setState((){
        widget.onPageChanged?.call(newVal);
        previous = page;
        page = newVal;
      }), 
      previous: previous,
      canvasBackground: widget.canvasBackground,
      animationType: widget.animationType,
      bottomAccentColor: widget.bottomAccentColor,
      accentSelected: widget.accentSelected,
      bottomAction: widget.bottomAction,
      withoutHeader: widget.withoutHeader,
      customScrollPhysics: widget.customScrollPhysics,
    );
  }
}


class _RadioHeaderedAlertWidget<T> extends StatelessWidget {

  const _RadioHeaderedAlertWidget({
    required this.page,
    required this.orderedPages,
    required this.onSelect,
    required this.animationType,
    required this.previous,
    required this.canvasBackground,
    required this.bottomAccentColor,
    required this.accentSelected,
    required this.items,
    required this.bottomAction,
    required this.withoutHeader,
    required this.customScrollPhysics,
  });

  final Map<T,RadioHeaderedItem> items;
  final T page;
  final List<T> orderedPages;
  final void Function(T) onSelect;
  final Color? bottomAccentColor;
  final bool accentSelected;
  final RadioAnimation animationType;
  final T? previous;
  final bool canvasBackground;
  final Widget? bottomAction;
  final bool withoutHeader;

  final ScrollPhysics? customScrollPhysics;


  @override
  Widget build(BuildContext context) {
    final StageData? stage = Stage.of(context);

    final Widget navBar = RadioNavBar<T>(
      selectedValue: page,
      orderedValues: orderedPages,
      tileSize: bottomAction != null ? 56.0+8.0*2 : RadioNavBar.defaultTileSize,
      items: {for(final entry in items.entries) 
        entry.key : RadioNavBarItem(
          title: entry.value.title,
          icon: entry.value.icon,
          unselectedIcon: entry.value.unselectedIcon,
          color: entry.value.color,
          iconSize: entry.value.iconSize,
        ),
      },
      onSelect: this.onSelect,
      accentTextColor: this.accentSelected 
        ? this.bottomAccentColor ?? Theme.of(context).colorScheme.secondary
        : null,
    );


    Widget child;
    switch (animationType) {
      case RadioAnimation.verticalSwap:
        child = Stack(
          fit: StackFit.expand, 
          children: <Widget>[
            for(final T item in this.orderedPages)
              Positioned.fill(
                child: AnimatedPresented(
                  duration: const Duration(milliseconds: 215),
                  presented: item == page,
                  curve: Curves.fastOutSlowIn.flipped,
                  presentMode: PresentMode.slide,
                  child: itemChild(items[item]!, stage),
                ),
              )
          ],
        );
        break;
      case RadioAnimation.horizontalFade:
        child = RadioPageTransition<T>(
          page: page, 
          previous: previous ?? page, 
          orderedPages: orderedPages,
          children: <T,Widget>{
            for(final T p in orderedPages)
              p: itemChild(items[p]!, stage),
          }, 
          canvasBackground: canvasBackground,
        );
        break;
      case RadioAnimation.none:
        child = SizedBox.expand(child: itemChild(items[page]!, stage));
        break;
      default:
        child = Container();
    }


    return HeaderedAlert(
      this.items[page]!.longTitle,
      bottom:Row(children: <Widget>[
        Expanded(child: navBar),
        if(bottomAction != null)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: bottomAction,
          ),
      ],),
      child: child,
      alreadyScrollableChild: true, // every single child decide for himself
      canvasBackground: canvasBackground,
      withoutHeader: withoutHeader,
    );
  }


  Widget itemChild(RadioHeaderedItem item, StageData? stage) => item.alreadyScrollableChild 
    ? item.child 
    : SingleChildScrollView(
      physics: this.customScrollPhysics ?? stage!.panelController.panelScrollPhysics(),
      padding: EdgeInsets.only(top: this.withoutHeader ? 0.0 : PanelTitle.height),
      child: item.child,
    );

}
