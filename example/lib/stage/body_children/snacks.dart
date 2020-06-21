import 'package:example/core.dart';

class Snacks extends StatelessWidget {

  const Snacks({Key key}): super(key: key);

  static const Widget simple = StageSnackBar(title: Text("This is a snackbar!")); 
  static const Widget scroll = StageSnackBar(title: Text("Swipe me away!"), scrollable: true,); 
  static const Widget subtitle = StageSnackBar(title: Text("Title"), scrollable: true, subtitle: Text("Subtitle"),); 
  static const Widget secondary = StageSnackBar(title: Text("Title"), scrollable: true, subtitle: Text("Subtitle"), secondary: Icon(Icons.star_border),); 
  static const Widget confirm = StageSnackBar(title: Text("You confirmed!"));

  @override
  Widget build(BuildContext context) {
    final StageData stage = Stage.of(context);

    return ListView(children: <Widget>[

      Section(<Widget>[
        const SectionTitle("Simple"),
        ListTile(
          title: const Text("Regular"),
          onTap: () => stage.showSnackBar(simple),
          onLongPress: () => stage.showSnackBar(simple, rightAligned: true),
        ),
        ListTile(
          title: const Text("Scroll to dismiss"),
          leading: const Icon(McIcons.gesture_swipe_horizontal),
          onTap: () => stage.showSnackBar(scroll),
          onLongPress: () => stage.showSnackBar(scroll, rightAligned: true),
        ),
        ListTile(
          title: const Text("Subtitle"),
          leading: const Icon(Icons.short_text),
          onTap: () => stage.showSnackBar(subtitle),
          onLongPress: () => stage.showSnackBar(subtitle, rightAligned: true),
        ),
        ListTile(
          title: const Text("With secondary widget"),
          leading: const Icon(Icons.star_border),
          onTap: () => stage.showSnackBar(secondary),
          onLongPress: () => stage.showSnackBar(secondary, rightAligned: true),
        ),

      ],),



      Section(<Widget>[
        const SectionTitle("Complex"),
        ListTile(
          leading: const Icon(Icons.check),
          title: const Text("Confirm snackbar"),
          onTap: () => stage.showSnackBar(ConfirmSnackbar(
            label: "Confirm?",
            action: () => stage.showSnackBar(confirm),
          ),),
          onLongPress: () => stage.showSnackBar(
            ConfirmSnackbar(
              label: "Confirm?",
              action: () => stage.showSnackBar(confirm, rightAligned: true),
            ),
            rightAligned: true,
          ),
        ),

        Selector(),
        
      ]),

      const Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text("(Long press to show from right)"),
      ),

    ],);
  }


}


class Selector extends StatefulWidget {
  @override
  _SelectorState createState() => _SelectorState();
}

class _SelectorState extends State<Selector> {

  int selected;

  static const List<IconData> icons = <IconData>[
    Icons.palette,
    Icons.favorite_border,
    Icons.gps_fixed,
    Icons.star_border,
    Icons.gesture,
    Icons.ac_unit,
    Icons.access_alarms,
    Icons.account_circle,
    Icons.airline_seat_flat_angled,
  ];

  @override
  Widget build(BuildContext context) {
    final StageData stage = Stage.of(context);

    final Widget snack = SelectSnackbar(
      initialIndex: selected,
      children: <Widget>[for(final icon in icons) Icon(icon),],
      onTap: (i) {
        this.setState((){selected = i;});
        stage.showSnackBar(StageSnackBar(
          title: Text("Your choice: #${i+1}"),
          secondary: Icon(icons[i]),
        ));
      },
    );

    return ListTile(
      leading: const Icon(Icons.radio_button_checked),
      title: const Text("Select snackbar"),
      trailing: selected != null ? Icon(icons[selected]) : null,
      onTap: () => stage.showSnackBar(snack),
      onLongPress: () => stage.showSnackBar(snack, rightAligned: true)
    );
  }
}