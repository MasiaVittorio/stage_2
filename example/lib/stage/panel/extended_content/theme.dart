import 'package:example/core.dart';
import 'package:sid_ui/sid_ui.dart';

class ThemeEx extends StatelessWidget {
  const ThemeEx();
  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: Stage.of(context).panelScrollPhysics,
      children: <Widget>[
        Section(<Widget>[
          const PanelTitle("Brightness", centered: false,),
          StageBrightnessToggle(),
        ]),

        Section(<Widget>[
          const SectionTitle("Main Colors"),
          StageMainColors<MainPage>(switchPagesVsSingle: true),
        ]),

        Section(<Widget>[
          SectionTitle("Panel Colors"),
          StagePanelColors<PanelPage>(switchPagesVsSingle: true),
        ]),

        Section(<Widget>[
          SectionTitle("Accent Color"),
          StageAccentColor(),
        ]),


      ],
    );
  }
}

