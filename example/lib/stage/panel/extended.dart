import 'package:example/core.dart';
import 'extended_content/all.dart';

class ExtendedPanel extends StatelessWidget {
  
  const ExtendedPanel();
  
  @override
  Widget build(BuildContext context) 
    => const StageExtendedPanel(children: <PanelPage,Widget>{
      PanelPage.stateless: StatelessVarsEx(),
      PanelPage.theme: ThemeEx(),
      PanelPage.pages: PagesEx(),
      PanelPage.dimensions: DimensionsEx(),
    });
}