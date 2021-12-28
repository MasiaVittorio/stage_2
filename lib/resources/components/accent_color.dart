import 'package:flutter/material.dart';
import 'package:stage/stage.dart';
// import 'main_colors.dart'; // For the circle color displayer

class StageAccentColor extends StatelessWidget {

  const StageAccentColor();

  @override
  Widget build(BuildContext context) {

    final StageData stage = Stage.of(context)!;

    return stage.themeController.derived.accentColor.build(((_, accentColor)
      => ListTile(
        title: const Text("Accent"),
        leading: ColorCircleDisplayer(accentColor),
        onTap: () => stage.pickColor(
          onSubmitted: (Color color) => stage.themeController.currentColorsController!.editAccent(color),
          initialColor: accentColor,
        ),
      )),
    );

  }

}
