part of 'package:stage/stage.dart';

class _StagePagesData<T> {
  ///====================================================
  /// Dispose the resources
  void dispose() {
    _page.dispose();
    _enabledPages.dispose();
    _orderedPages.dispose();
  }

  ///====================================================
  /// Values
  final StageData parent;

  final List<T> _previousPages = <T>[];

  /// Navigation (back button / pop behavior)

  final T? defaultPage;

  /// First page

  final Reactive<T> _page;

  /// Current Page

  final Reactive<List<T>> _orderedPages;

  final Map<T, StagePage?> pagesData;

  /// Names, icons and stuff

  late Reactive<Map<T, bool>> _enabledPages;

  /// not final because after reading the saved data it must call a
  /// specific function to adjust the first page appearing on screen

  final void Function(T)? _onPageChanged;

  /// Custom Notifier

  //================================
  // Constructor
  _StagePagesData(
    this.parent, {
    required String uniqueKey,
    required void Function(T)? onPageChanged,
    required StagePagesData<T> initialData,
    required dynamic Function(T) pageToJson,
    required T Function(dynamic) jsonToPage,
  })  : _onPageChanged = onPageChanged,
        defaultPage = initialData.defaultPage,
        _page = Reactive<T>(initialData.defaultPage ?? initialData.orderedPages!.first!),
        pagesData = initialData.pagesData!,
        _orderedPages = Reactive.modal<List<T>>(
          initVal: initialData.orderedPages!,
          key: parent._getStoreKey("$uniqueKey // stage_pages_orderedPages"),
          toJsonEncodable: (list) => [for (final T page in list) pageToJson(page)],
          fromJsonDecoded: (json) => <T>[for (final j in (json as List)) jsonToPage(j)],
          readCallback: (_) => parent._readCallback("$uniqueKey // stage_pages_orderedPages"),
        ) {
    _enabledPages = Reactive.modal<Map<T, bool>>(
      initVal: initialData.enabledPages!,
      key: parent._getStoreKey("$uniqueKey // stage_pages_enabledPages"),
      toJsonEncodable: (map) => <String, dynamic>{
        for (final e in map.entries) jsonEncode(pageToJson(e.key)): e.value,
      },
      fromJsonDecoded: (json) => <T, bool>{
        for (final e in (json as Map).entries)
          jsonToPage(jsonDecode(e.key as String)): e.value as bool,
      },
      //it cannot be final because we need to set this callback while we initialize it
      readCallback: (map) {
        parent._readCallback("$uniqueKey // stage_pages_enabledPages");
        if (!map[_page.value!]!) {
          _avoidPage(_page.value);
        }
      },
      // copier: (m) => Map<T, bool>.from(m),
      // TODO: i believe copier to not be needed anymo'
    );
  }

  //================================
  // Getters
  bool get _isCurrentlyReading =>
      parent.storeKey != null && (_enabledPages.modalReading || _orderedPages.modalReading);

  T? get previousPage => _previousPages.isNotEmpty ? _previousPages.last : null;

  StagePagesData<T> get extractData => StagePagesData<T>._(
        defaultPage: defaultPage,
        pagesData: pagesData,
        enabledPages: _enabledPages.value,
        orderedPages: _orderedPages.value,
      );

  ///===========================================================
  /// Private (declared here because VSCode does not see their
  ///   usage in the state if declared in the extension, WTF)

  /// ==> Navigation (back button / pop behavior)
  bool _backToPreviousPage() {
    if (_previousPages.isEmpty) {
      return false;
    } else {
      _page.update(_previousPages.removeLast());
      return true;
    }
  }

  bool _backToDefaultPage() {
    if (defaultPage != null && _page.value != defaultPage) {
      if (_enabledPages.value[defaultPage!]!) {
        _page.update(defaultPage as T);
        return true;
      }
    }
    return false;
  }

  ///===========================================================
  /// Public (declared here because by calling Stage.of(context) without specifying T,S
  /// and then calling goToPage(Typed stuff), it will throw something like (Type) => void != (dynamic) => void
  /// I don't know why. I shouldn't have to wonder why, it should not work like this,
  /// but we need to do this terribleness

  /// ==> Current Page
  bool goToPage(T? newPage) {
    // Check if makes sense
    if (newPage == null) return false;
    if (_page.value == newPage) return false;
    if (!isEnabled(newPage)) return false;

    // Close snackbar if shown
    if (parent.panelController.snackbarController._pagePersistentSnackBarId !=
        parent.panelController.snackbarController.snackBarId) {
      parent.closeSnackBar();
    }

    // Put current (previous) page value on top of the stack
    _previousPages.remove(_page.value);
    _previousPages.add(_page.value);

    // Remove new (current) page from the previous stack
    _previousPages.remove(newPage);

    // Actually go to the new (current) page
    _page.update(newPage);
    _onPageChanged?.call(newPage); // And notify

    return true; // All went well
  }
}
