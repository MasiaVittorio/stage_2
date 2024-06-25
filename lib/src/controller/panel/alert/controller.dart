part of 'package:stage/stage.dart';

typedef StageAlertShower = Future<void> Function(Widget, double, bool);

class _StageAlertData {
  //================================
  // Disposer
  void dispose() {
    children.dispose();
    sizes.dispose();
    savedStates.clear();
    currentChild.dispose();
    currentSize.dispose();
    isShowing.dispose();
  }

  //================================
  // Values
  final _StagePanelData parent;

  // State
  final Reactive<List<Widget>> children = Reactive<List<Widget>>(<Widget>[]);
  final Reactive<List<double>> sizes = Reactive<List<double>>(<double>[]);
  final Map<String, dynamic> savedStates = <String, dynamic>{};

  // Derived
  late Reactive<bool> isShowing;
  late Reactive<Widget?> currentChild;
  late Reactive<double?> currentSize;

  // Logic
  /// if the panel was opened already without displaying any alert before displaying the first
  bool previouslyOpenedPanel = false;

  //================================
  // Constructor
  _StageAlertData(this.parent) {
    currentChild = children.related<Widget?>((l) => l.isEmpty ? null : l.last);
    currentSize = sizes.related<double?>((l) => l.isEmpty ? null : l.last);
    isShowing = (currentChild, currentSize).related<bool>(
      (c, s) => c != null && s != null,
    );
  }
}
