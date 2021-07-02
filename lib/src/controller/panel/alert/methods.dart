part of stage;

extension StageAlertDataExt on _StageAlertData {
  static const double defaultAlertSize = 250;

  //===================================
  // Public

  void showAlert(Widget child, {
    double size = defaultAlertSize, 
    bool replace = false
  }) async {

    if(this.parent.position > 0.0){
      if(this.children.value.isEmpty){
        previouslyOpenedPanel = true;
      }
      await parent._closeInternal!();
    }

    if(parent.snackbarController!.position != 0.0){
      await parent.snackbarController!.close();
    }

    if(replace && this.sizes.value.isNotEmpty && this.children.value.isNotEmpty){
      sizes.value.removeLast();
      children.value.removeLast();
    }
    sizes.value.add(size);
    children.value.add(child);
    sizes.refresh();
    children.refresh();

    parent.open();
  }

  void recalcAlertSize(double newSize) {
    if(sizes.value.isEmpty) return;
    sizes.value.last = newSize;
    sizes.refresh();
  }



  //===================================
  // Private

  void _removeOneChild(){
    if(sizes.value.isNotEmpty)
      sizes.value.removeLast();
    if(children.value.isNotEmpty)
      children.value.removeLast();
    sizes.refresh();
    children.refresh();
  }


  bool _closedAlertRoutine(){
    if(children.value.isNotEmpty){
      
      _removeOneChild();
      bool shouldReOpen = false;
      if(children.value.isEmpty){
        if(previouslyOpenedPanel){
          shouldReOpen = true;
          previouslyOpenedPanel = false;
        }
      } else {
        shouldReOpen = true;
      }
      if(shouldReOpen){
        SchedulerBinding.instance!.addPostFrameCallback((_) {
          parent.open();
        });
        return true;
      }
    }
    return false;
  }


  void _completelyCloseAlertRoutine(){
    children.value.clear();
    sizes.value.clear();
    sizes.refresh();
    children.refresh();
  }


}

