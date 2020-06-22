part of stage;


typedef StageAlertShower = Future<void> Function(Widget, double, bool);


class _StageAlertData {

  //================================
  // Disposer
  void dispose(){
    children?.dispose();
    sizes?.dispose();
    isShowing?.dispose();
    currentChild?.dispose();
    currentSize?.dispose();
    savedStates.clear();
  }


  //================================
  // Values 
  final _StagePanelData parent;

  // State 
  final BlocVar<List<Widget>> children = BlocVar<List<Widget>>(<Widget>[]);
  final BlocVar<List<double>> sizes = BlocVar<List<double>>(<double>[]);
  final Map<String,dynamic> savedStates = <String,dynamic>{};

  // Derived 
  BlocVar<bool> isShowing;
  BlocVar<Widget> currentChild;
  BlocVar<double> currentSize;

  // Logic
  /// if the panel was opened already without displaying any alert before displaying the first
  bool previouslyOpenedPanel = false; 


  //================================
  // Constructor
  _StageAlertData(this.parent){
    currentChild = BlocVar.fromCorrelate<Widget, List<Widget>>(
      from: children, 
      map: (l) => l == null || l.isEmpty ? null : l.last,
    );
    currentSize = BlocVar.fromCorrelate<double, List<double>>(
      from: sizes, 
      map: (l) => l == null || l.isEmpty ? null : l.last,
    );
    isShowing = BlocVar.fromCorrelateLatest2<bool,Widget,double>(
      currentChild,
      currentSize, 
      map: (c,s) => c != null && s != null,
      distinct: true,
    );
  }


}