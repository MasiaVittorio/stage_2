part of stage;

//====================================
// Inherited Logic

class StageProvider<T,S> extends StatefulWidget {

  StageProvider({
    Key key,
    @required this.child,
    @required this.data,
  }): super(key: key);

  final Widget child;
  final StageData<T,S> data;

  static StageData<A,B> of<A,B>(BuildContext context){
    final inherited = context.dependOnInheritedWidgetOfExactType<_StageInherited>();
    return inherited?.data;
  }

  @override
  _StageProviderState createState() => _StageProviderState();
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
    Key key,
    @required Widget child,
    @required this.data,
  }) : super(key: key, child: child);

  final StageData<T,S> data;

  @override
  bool updateShouldNotify(_StageInherited<T,S> oldWidget) => false;
}


