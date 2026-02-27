import 'package:example/core.dart';
import 'package:example/stage/panel/extended_content/all.dart';

class ThemeEx extends StatelessWidget {
  const ThemeEx({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: Stage.of(context)!.panelScrollPhysics,
      children: const <Widget>[
        Section(<Widget>[
          PanelTitle(
            "Brightness",
            centered: false,
          ),
          StageBrightnessToggle(),
        ]),
        Section(<Widget>[
          SectionTitle("Main Colors"),
          StageMainColors<MainPage>(switchPagesVsSingle: true),
        ]),
        DimensionsSwitcher(),
      ],
    );
  }
}
