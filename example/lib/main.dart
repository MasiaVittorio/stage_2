import 'package:example/core.dart';

import 'stage/home_page.dart';

void main() => runApp(const StageExample());

class StageExample extends StatelessWidget {
  
  const StageExample({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stage Example',
      home: RadioSliderTheme(
        data: RadioSliderThemeData(
          height: 50,
        ),
        child: const HomePage(),
      ),
    );
  }
}
