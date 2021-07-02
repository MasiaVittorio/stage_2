import 'package:stage/stage.dart';
import 'package:flutter/material.dart';
import 'package:sid_ui/sid_ui.dart';
import 'package:sid_bloc/sid_bloc.dart';


class StageBrightnessToggle extends StatelessWidget {

  const StageBrightnessToggle({Key? key}):super(key:key);

  @override
  Widget build(BuildContext context) {
    final StageData stage = Stage.of(context)!;
    final controller = stage.themeController!.brightness!;

    return BlocVar.build2<Brightness?,bool?>(
      controller.brightness, 
      controller.autoDark, 
      builder: (_, brightness, autoDark) => Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          _LightDarkAuto(brightness: brightness, autoDark: autoDark),
          AnimatedListed(
            listed: autoDark!,
            overlapSizeAndOpacity: 1.0,
            child: const _TimeOfDayVSSystem(),
          ),
          AnimatedListed(
            listed: true,
            // listed: brightness.isDark,
            overlapSizeAndOpacity: 1.0,
            child: const _DarkStyleSwitcher(),
          ),
        ],
      ),
    );

  }
}


class _LightDarkAuto extends StatelessWidget {

  const _LightDarkAuto({
    required this.brightness,
    required this.autoDark,
    Key? key,
  }): super(key: key);

  final bool? autoDark;
  final Brightness? brightness;

  @override
  Widget build(BuildContext context) {
    final StageData stage = Stage.of(context)!;
    final controller = stage.themeController!.brightness;

    return RadioSlider(
      selectedIndex: autoDark! ? 1 : brightness!.isLight ? 0 : 2,
      items: [
        RadioSliderItem(
          icon: const Icon(McIcons.weather_sunny),
          title: const Text("Light"),
        ),
        RadioSliderItem(
          icon: const Icon(Icons.brightness_auto),
          title: const Text("Auto"),
        ),
        RadioSliderItem(
          icon: const Icon(McIcons.weather_night),
          title: const Text("Dark"),
        ),
      ],
      onTap: (i){
        switch (i) {
          case 0:
            controller!.disableAutoDark(Brightness.light);
            break;
          case 1:
            controller!.enableAutoDark(context);
            break;
          case 2:
            controller!.disableAutoDark(Brightness.dark);
            break;
          default:
        }
      },
    );
  }
}

class _TimeOfDayVSSystem extends StatelessWidget {

  const _TimeOfDayVSSystem({
    Key? key,
  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    final StageData stage = Stage.of(context)!;
    final controller = stage.themeController!.brightness!;

    return controller.autoDarkMode.build(((_, mode)
      => RadioSlider(
        title: const Text("Based on:"),
        selectedIndex: mode == AutoDarkMode.timeOfDay ? 0 : 1,
        items: const [
          RadioSliderItem(
            icon: Icon(McIcons.theme_light_dark),
            title: Text("Day time"),
          ),
          RadioSliderItem(
            icon: Icon(Icons.timeline),
            title: Text("System"),
          ),
        ],
        onTap: (i){
          if(i == 0) controller.autoDarkBasedOnTime();
          else controller.autoDarkBasedOnSystem(context);
        },
      )),
    );

  }

}

class _DarkStyleSwitcher extends StatelessWidget {

  const _DarkStyleSwitcher({
    Key? key,
  }): super(key: key);


  @override
  Widget build(BuildContext context) {
    final StageData stage = Stage.of(context)!;
    final controller = stage.themeController!.brightness!;

    return controller.darkStyle.build(((_, darkStyle)
      => ListTile(
        title: const Text("Dark Style:"),
        trailing: AnimatedText(
          darkStyle.name!,
          duration: const Duration(milliseconds: 220),
        ),
        leading: const Icon(Icons.format_color_fill),
        onTap: (){
          controller.darkStyle.setDistinct(DarkStyles.next(darkStyle));
        },
      )),
    );
  }
}
