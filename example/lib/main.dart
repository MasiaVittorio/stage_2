import 'package:flutter/material.dart';

import 'stage/home_page.dart';
import 'package:sid_ui/sid_ui.dart';

void main() => runApp(StageExample());

class StageExample extends StatelessWidget {
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
