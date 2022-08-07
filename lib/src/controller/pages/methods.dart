part of stage;

// ignore: library_private_types_in_public_api
extension StagePagesDataExt<T> on _StagePagesData<T> {

  ///========================================
  /// Public
  
  Map<T?,bool>? get currentlyEnabledPages => _enabledPages.value;


  /// ==> Ordered Pages 
  bool movePage(int from, int to){
    // Nice little extension method, null and out-of-range proof
    final bool ret = _orderedPages.value.move(from, to); 
    _orderedPages.refresh();
    return ret;
  }


  /// ==> Pages Enable / Disable 
  bool enablePage(T enablablePage){
    // Check if useful
    if(!pagesData.containsKey(enablablePage)) return false;
    if(_enabledPages.value[enablablePage] == true) return false;

    // Actually enable
    _enabledPages.value[enablablePage] = true;
    _enabledPages.refresh();
    return true;
  }

  bool disablePage(T disablablePage){
    // Check if useful
    if(!pagesData.containsKey(disablablePage)) return false;
    if(_enabledPages.value[disablablePage] == false) return false;

    // Avoid that page if it is the current one
    if(!_avoidPage(disablablePage)) return false; // There was no other page to get back to!

    // Actually disable
    _previousPages.remove(disablablePage);
    _enabledPages.value[disablablePage] = false;
    _enabledPages.refresh();
    return true; // All went well
  }

  bool togglePage(T toggleablePage){
    if(_enabledPages.value[toggleablePage] ?? true){
      return disablePage(toggleablePage);
    } else {
      return enablePage(toggleablePage);
    }
  }

  bool enableAllPages(){
    bool changed = false;

    for(final p in _enabledPages.value.keys){
      if(!_enabledPages.value[p]!){
        _enabledPages.value[p] = true;
        changed = true;
      }
    }

    if(changed){
      _enabledPages.refresh();
      return true;
    } else {
      return false;
    }
  }

  bool isEnabled(T page) => _enabledPages.value[page] ?? false;

  T? get currentPage => _page.value;

  ///==============================================
  /// Private

  /// Only used privately before disabling a page 
  bool _avoidPage(T? pageToAvoid){
    if(_page.value == pageToAvoid){
      if(goToPage(defaultPage)){ 
        return true; // The default was enabled and different from the current one
      } else {
        for(final p in  _orderedPages.value){
          if(goToPage(p)){
            return true; // This page was enabled and different from the current one
          }
        }
        return false; //This means there was no page other than the one to avoid that was enabled
      }
    } else {
      return true; // No reason, already avoided
    }
  }



}