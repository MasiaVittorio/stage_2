import 'package:example/core.dart';
import 'package:stage/resources/components/all.dart';

import 'body.dart';
import 'panel/all.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stage<MainPage,PanelPage>(
      storeKey: "stage_example",

      splashScreen: Container(color: Colors.blue, child: Center(child: Icon(Icons.favorite_border, size: 150)),),

      body: const Body(),
      topBarContent: StageTopBarContent(
        title: StageTopBarTitle<MainPage,PanelPage>(),
        subtitle: StageTopBarSubtitle<PanelPage>((page) => page.subTitle),
      ),
      collapsedPanel: const CollapsedPanel(),
      extendedPanel: const ExtendedPanel(),
      

      stageTheme: StageThemeData.nullable(
        pandaOpenedPanelNavBar: true,
        // forceSystemNavBarStyle: true,
        forcedPrimaryColorBrightnessOnLightTheme: Brightness.dark,
      ),

      mainPageToJson: (p) => p.name,
      jsonToMainPage: (j) => MainPages.fromName(j as String),
      mainPages: StagePagesData.nullable(
        defaultPage: MainPage.alerts,
        orderedPages: [MainPage.other, MainPage.alerts, MainPage.snackBars],
        pagesData: <MainPage,StagePage>{
          for(final page in MainPage.values)
            page: StagePage(
              name: page.name,
              longName: page.longName,
              icon: page.iconFilled,
              unselectedIcon: page.iconOutline,
            ),
        },
      ),

      panelPageToJson: (p) => p.name,
      jsonToPanelPage: (j) => PanelPages.fromName(j as String),
      panelPages: StagePagesData.nullable(
        defaultPage: PanelPage.theme,
        orderedPages: [PanelPage.pages, PanelPage.theme, PanelPage.dimensions, PanelPage.stateless],
        pagesData: <PanelPage,StagePage>{
          for(final page in PanelPage.values)
            page: StagePage(
              name: page.name,
              longName: page.longName,
              icon: page.iconFilled,
              unselectedIcon: page.iconOutline,
            ),
        },
      ),


    );
  }

}
