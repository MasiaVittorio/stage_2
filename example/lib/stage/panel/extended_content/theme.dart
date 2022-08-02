import 'package:example/core.dart';

class ThemeEx extends StatelessWidget {
  
  const ThemeEx({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: Stage.of(context)!.panelScrollPhysics,
      children: const <Widget>[
        Section(<Widget>[
          PanelTitle("Brightness", centered: false,),
          StageBrightnessToggle(),
        ]),

        Section(<Widget>[
          SectionTitle("Main Colors"),
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

