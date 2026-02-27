import 'package:example/core.dart';

import 'stage/home_page.dart';

void main() => runApp(const StageExample());

class StageExample extends StatelessWidget {
  const StageExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Stage Example',
      home: HomePage(),
    );
  }
}
