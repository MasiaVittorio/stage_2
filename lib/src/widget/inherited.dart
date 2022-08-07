part of stage;

//====================================
// Inherited Logic



class StageProvider<T,S> extends StatefulWidget {

  const StageProvider({
    required this.child,
    required this.data,
    super.key,
  });

  final Widget child;
  final StageData<T,S> data;

  static StageData<A,B>? of<A,B>(BuildContext context){
    final inherited = context.dependOnInheritedWidgetOfExactType<_StageInherited>();
    return inherited?.data as StageData<A, B>?;
  }

  @override
  State<StageProvider> createState() => _StageProviderState();
}

class _StageProviderState extends State<StageProvider> {
  ///  It seems that it is important to not have <T,S> here for the dependOnBlaBla to work
  @override
  Widget build(BuildContext context)
    => _StageInherited(
      data: widget.data,
      child: widget.child,
    );
}



class _StageInherited<T,S> extends InheritedWidget {
  const _StageInherited({
    required super.child,
    required this.data,
    super.key,
  });

  final StageData<T,S> data;

  @override
  bool updateShouldNotify(_StageInherited<T,S> oldWidget) => false;
}


