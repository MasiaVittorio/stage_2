import 'package:example/core.dart';
import 'body_children/all.dart';

class Body extends StatelessWidget {

  const Body();

  @override
  Widget build(BuildContext context) 
    => const StageBody<MainPage>(children: <MainPage,Widget>{
      MainPage.alerts: Alerts(key: ValueKey("widget_key_alerts")),
      MainPage.other: Other(key: ValueKey("widget_key_other")),
      MainPage.snackBars: Snacks(key: ValueKey("widget_key_snackBars")),
    },);
}
