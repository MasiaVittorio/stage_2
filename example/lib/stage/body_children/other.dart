import 'package:example/core.dart';

class Other extends StatelessWidget {

  const Other({Key key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(children: const <Widget>[
      Section(<Widget>[
        SectionTitle("Some other content"),
        ListTile(
          title: Text("Just to check the padding"),
          subtitle: Text("At the bottom of this listview"),
        ),
      ]),

      Section(<Widget>[
        SectionTitle("Stuff should"),
        ListTile(
          title: Text("automatically avoid"),
          subtitle: Text("the bottom panel"),
        ),
      ]),

      Section(<Widget>[
        SectionTitle("Without having"),
        ListTile(
          title: Text("to manually put"),
          subtitle: Text("the bottom padding"),
        ),
      ]),

      Section(<Widget>[
        SectionTitle("Because Listviews"),
        ListTile(
          title: Text("automatically pick "),
          subtitle: Text("the mediaquery's padding settings."),
        ),
      ]),


      Section(<Widget>[
        SectionTitle("And fortunately for us"),
        ListTile(
          title: Text("Stage does the job"),
          subtitle: Text("of putting that"),
        ),
      ]),

      Section(<Widget>[
        SectionTitle("padding information"),
        ListTile(
          title: Text("on the mediaquery "),
          subtitle: Text("surrounding the body"),
        ),
      ]),

      Section(<Widget>[
        SectionTitle("So if you"),
        ListTile(
          title: Text("Now,"),
          subtitle: Text("Scroll to the bottom"),
        ),
      ]),
      Section(<Widget>[
        SectionTitle("Of this listview"),
        ListTile(
          title: Text("You should be able"),
          subtitle: Text("To actually see its content"),
        ),
      ]),
      Section(<Widget>[
        SectionTitle("Avoiding"),
        ListTile(
          title: Text("The bottom panel"),
          subtitle: Text("Perfectly"),
        ),
      ]),
    ],);
  }
}