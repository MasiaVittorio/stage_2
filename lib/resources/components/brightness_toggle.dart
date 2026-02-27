import 'package:flutter/material.dart';
import 'package:segmented_slider/segmented_slider.dart';
import 'package:stage/stage.dart';

class StageBrightnessToggle extends StatelessWidget {
  const StageBrightnessToggle({
    this.showDarkStylesOnlyIfDark = false,
    super.key,
  });

  final bool showDarkStylesOnlyIfDark;

  @override
  Widget build(BuildContext context) {
    final StageData stage = Stage.of(context)!;
    final controller = stage.themeController.brightness;

    return Reactive.build2<Brightness, bool?>(
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

enum _V { light, auto, dark }

class _LightDarkAuto extends StatelessWidget {
  const _LightDarkAuto({
    required this.brightness,
    required this.autoDark,
  });

  final bool? autoDark;
  final Brightness? brightness;

  @override
  Widget build(BuildContext context) {
    final StageData stage = Stage.of(context)!;
    final controller = stage.themeController.brightness;

    return SegmentedSlider<_V>(
      segments: [
        SliderSegment(
          value: _V.light,
          selectedIcon: Icon(MdiIcons.weatherSunny),
          label: const Text("Light"),
        ),
        const SliderSegment(
          value: _V.auto,
          selectedIcon: Icon(Icons.brightness_auto),
          label: Text("Auto"),
        ),
        SliderSegment(
          value: _V.dark,
          selectedIcon: Icon(MdiIcons.weatherNight),
          label: const Text("Dark"),
        ),
      ],
      value: switch ((autoDark, brightness?.isLight)) {
        (true, _) => _V.auto,
        (false, true) => _V.light,
        (false, false) => _V.dark,
        _ => null,
      },
      onSelect: (v) {
        switch (v) {
          case _V.light:
            controller.disableAutoDark(Brightness.light);
            break;
          case _V.auto:
            controller.enableAutoDark(context);
            break;
          case _V.dark:
            controller.disableAutoDark(Brightness.dark);
            break;
          default:
        }
      },
    );
  }
}

class _TimeOfDayVSSystem extends StatelessWidget {
  const _TimeOfDayVSSystem();

  @override
  Widget build(BuildContext context) {
    final StageData stage = Stage.of(context)!;
    final controller = stage.themeController.brightness;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SectionTitle("Auto dark mode based on:"),
        controller.autoDarkMode.build(
          (_, mode) => SegmentedSlider<AutoDarkMode>(
            value: mode,
            segments: [
              SliderSegment(
                value: AutoDarkMode.timeOfDay,
                selectedIcon: Icon(MdiIcons.themeLightDark),
                label: const Text("Time of day"),
              ),
              const SliderSegment(
                value: AutoDarkMode.system,
                selectedIcon: Icon(Icons.timeline),
                label: Text("System"),
              ),
            ],
            onSelect: (value) {
              switch (value) {
                case AutoDarkMode.timeOfDay:
                  controller.autoDarkBasedOnTime();
                  return;
                case AutoDarkMode.system:
                  controller.autoDarkBasedOnSystem(context);
                  return;
                case null:
                  return;
              }
            },
          ),
        ),
      ],
    );
  }
}

class _DarkStyleSwitcher extends StatelessWidget {
  const _DarkStyleSwitcher();

  @override
  Widget build(BuildContext context) {
    final StageData stage = Stage.of(context)!;
    final controller = stage.themeController.brightness;

    return controller.darkStyle.build(
      ((_, darkStyle) => ListTile(
            title: const Text("Dark Style:"),
            trailing: AnimatedText(
              darkStyle.name,
              duration: const Duration(milliseconds: 220),
            ),
            leading: const Icon(Icons.format_color_fill),
            onTap: () {
              controller.darkStyle.update(darkStyle.next);
            },
          )),
    );
  }
}
