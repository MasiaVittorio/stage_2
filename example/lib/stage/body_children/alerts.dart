import 'package:example/core.dart';

class Alerts extends StatelessWidget {

  const Alerts({Key? key}): super(key: key);


  @override
  Widget build(BuildContext context) {
    final StageData stage = Stage.of(context)!;

    return ListView(children: <Widget>[
      
      Section(<Widget>[
        const SectionTitle("Simple"),
        Row(children: <Widget>[
          for(final child in <Widget>[
            ListTile(
              title: const Text("Big"),
              onTap: () => stage.showAlert(headered, size: 500),
            ),
            ListTile(
              title: const Text("Small"),
              onTap: () => stage.showAlert(headered, size: 300),
            ),
          ]) Expanded(child: child,),
        ],),
      ],),

      Section(<Widget>[
        const SectionTitle("Multi page"),
        Row(children: <Widget>[
          for(final child in <Widget>[
            ListTile(
              title: const Text("Vert. swap"),
              onTap: () => stage.showAlert(
                const RadioHeaderedAlert<int>(
                  items: radioItems,
                  animationType: RadioAnimation.verticalSwap,
                ),
                size: 500,
              ),
            ),
            ListTile(
              title: const Text("Horiz. fade"),
              onTap: () => stage.showAlert(
                const RadioHeaderedAlert<int>(
                  items: radioItems,
                  animationType: RadioAnimation.horizontalFade,
                ),
                size: 500,
              ),
            ),
          ]) Expanded(child: child,),
        ],),
      ]),

      Section(<Widget>[

        const SectionTitle("Interactive"),

        Row(children: <Widget>[
          for(final child in const <Widget>[
            _TextInput(),
            _NumberInput(),
          ]) Expanded(child: child,),
        ],),
        
        const _ColorInput(),

        const _ConfirmInput(),

      ],),

      Section(<Widget>[
        const SectionTitle("Nested alerts"),
        ListTile(
          title: const Text("Show nested alerts"),
          onTap: () => stage.showAlert(NestedAlert(1)),
        ),
      ]),

    ],);
  }

  static const Map<int,RadioHeaderedItem> radioItems = <int,RadioHeaderedItem>{
    1: RadioHeaderedItem(
      longTitle: "All favorites",
      title: "Favs", 
      child: SizedBox(height: 200, child: Center(child: Icon(Icons.favorite_border, size: 40,)),), 
      icon: Icons.favorite,
      unselectedIcon: Icons.favorite_border,
    ),
    2: RadioHeaderedItem(
      longTitle: "Other stuff", 
      title: "Other",
      child: SizedBox(height: 200, child: Center(child: Icon(Icons.menu, size: 40,)),), 
      icon: Icons.menu,
    ),
  };

  static final Widget headered = HeaderedAlert(
    "Scroll this list!", 
    child: Column(mainAxisSize: MainAxisSize.min,children: <Widget>[
      for(int i in [1,2,3,4,5,6,7,8,9,10,11])
        ListTile(title: Text("Content $i"),),
    ],
  ),);


}


class _ConfirmInput extends StatefulWidget {
  const _ConfirmInput();
  @override
  __ConfirmInputState createState() => __ConfirmInputState();
}

class __ConfirmInputState extends State<_ConfirmInput> {

  bool? confirm;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: const Text("Confirm alert"),
      leading: const Icon(Icons.check),
      trailing: Text(confirm == true ? "confirmed": "-"),
      onTap: () => Stage.of(context)!.showAlert(
        ConfirmAlert(
          action: () => setState(() {
            confirm = true;
          }),
        ), 
        size: ConfirmAlert.height,
      ),
    );
  }
}


class _ColorInput extends StatefulWidget {
  const _ColorInput();
  @override
  _ColorInputState createState() => _ColorInputState();
}

class _ColorInputState extends State<_ColorInput> {
  Color? color;

  @override
  Widget build(BuildContext context) {
    final StageData stage = Stage.of(context)!;

    return ListTile(
      leading: const Icon(McIcons.palette_outline),
      trailing: color != null ? CircleAvatar(backgroundColor: color, child: Container(),) : null,
      title: const Text("Color pick Alert"),
      onTap: () => stage.pickColor(
        initialColor: color,
        onSubmitted: (Color value) {
          setState((){
            color = value;
          });
          stage.showSnackBar(
            StageSnackBar(
              title: Text("Color: ${value.value.toRadixString(16).toUpperCase()}"), 
              secondary: StageSnackButton(
                onTap: null, 
                backgroundColor: value, 
                child: Icon(Icons.palette, color: value.contrast,),
              ),
            ),
          );
        },
      ),
    );
  }
}


class _TextInput extends StatefulWidget {
  const _TextInput();
  @override
  _TextInputState createState() => _TextInputState();
}

class _TextInputState extends State<_TextInput> {

  String? text;

  @override
  Widget build(BuildContext context) {
    final StageData stage = Stage.of(context)!;
    return ListTile(
      title: const Text("Input text"),
      subtitle: text != null ? Text(text ?? "") : null,
      leading: const Icon(Icons.short_text),
      onTap: () => stage.showAlert(
        InsertAlert(
          initialText: text,
          labelText: "Insert some text",
          onConfirm: (value) {
            setState((){
              text = value;
            });
            stage.showSnackBar(
              StageSnackBar(title: Text("Text: $value")),
            );
          },
        ),
        size: InsertAlert.height,
      ),
    );
  }
}

class _NumberInput extends StatefulWidget {
  const _NumberInput();
  @override
  _NumberInputState createState() => _NumberInputState();
}


class _NumberInputState extends State<_NumberInput> {

  int? number;

  @override
  Widget build(BuildContext context) {
    final StageData stage = Stage.of(context)!;
    return ListTile(
      title: const Text("Input number"),
      subtitle: number != null ? Text("$number") : null,
      leading: const Icon(Icons.dialpad),
      onTap: () => stage.showAlert(
        InsertAlert(
          initialText: number != null ? "$number" : null,
          labelText: "Insert a number",
          inputType: TextInputType.number,
          onConfirm: (value) {
            setState((){
              number = int.tryParse(value);
            });
            stage.showSnackBar(
              StageSnackBar(title: Text("Number: $value")),
            );
          },
        ),
        size: InsertAlert.height,
      ),
    );
  }
}


class NestedAlert extends StatelessWidget {
  final int id;
  NestedAlert(this.id): super(key: ValueKey(id));  
  @override
  Widget build(BuildContext context) {
    return HeaderedAlert(
      "Nested alert #$id",
      bottom: Row(children: <Widget>[
        for(final child in <Widget>[
          ListTile(
            title: const Text("Show next"),
            leading: const Icon(Icons.keyboard_arrow_right),
            onTap: () => Stage.of(context)!.showAlert(NestedAlert(id+1)),
          ),
          ListTile(
            title: const Text("Close completely"),
            leading: const Icon(Icons.close),
            onTap: () => Stage.of(context)!.closePanelCompletely(),
          ),
        ]) Expanded(child: child),
      ],),
      child: Container(),
    );
  }
}