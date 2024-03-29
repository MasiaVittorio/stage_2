import 'package:stage/stage.dart';
import 'package:flutter/material.dart';

class StageBrightnessToggle extends StatelessWidget {

  const StageBrightnessToggle({
    this.showDarkStylesOnlyIfDark = false,
    Key? key,
  }):super(key:key);

  final bool showDarkStylesOnlyIfDark;

  @override
  Widget build(BuildContext context) {
    final StageData stage = Stage.of(context)!;
    final controller = stage.themeController.brightness;

    return BlocVar.build2<Brightness,bool?>(
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
            listed: (!showDarkStylesOnlyIfDark) || brightness.isDark,
            overlapSizeAndOpacity: 1.0,
            child: const Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: _DarkStyleSwitcher(),
            ),
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
    final controller = stage.themeController.brightness;

    return RadioSlider(
      selectedIndex: autoDark! ? 1 : brightness!.isLight ? 0 : 2,
      items: const [
        RadioSliderItem(
          icon: Icon(McIcons.weather_sunny),
          title: Text("Light"),
        ),
        RadioSliderItem(
          icon: Icon(Icons.brightness_auto),
          title: Text("Auto"),
        ),
        RadioSliderItem(
          icon: Icon(McIcons.weather_night),
          title: Text("Dark"),
        ),
      ],
      onTap: (i){
        switch (i) {
          case 0:
            controller.disableAutoDark(Brightness.light);
            break;
          case 1:
            controller.enableAutoDark(context);
            break;
          case 2:
            controller.disableAutoDark(Brightness.dark);
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
    final controller = stage.themeController.brightness;

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
          if(i == 0) {
            controller.autoDarkBasedOnTime();
          } else {
            controller.autoDarkBasedOnSystem(context);
          }
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
    final controller = stage.themeController.brightness;

    return controller.darkStyle.build(((_, darkStyle)
      => ListTile(
        title: const Text("Dark Style:"),
        trailing: AnimatedText(
          darkStyle.name,
          duration: const Duration(milliseconds: 220),
        ),
        leading: const Icon(Icons.format_color_fill),
        onTap: (){
          controller.darkStyle.setDistinct(darkStyle.next);
        },
      )),
    );
  }
}
