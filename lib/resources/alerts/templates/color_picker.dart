import 'package:flutter/material.dart';
import 'package:stage/stage.dart';

import 'package:sid_ui/interactive/color_picker/color_picker_manual.dart';
import 'package:sid_ui/interactive/color_picker/color_picker_palette.dart';
import 'package:sid_ui/interactive/color_picker/color_picker_custom.dart';
import 'package:sid_ui/interactive/color_picker/models/palette.dart';


class ColorPickerAlert extends StatefulWidget {
  const ColorPickerAlert({
    this.initialColor,
    required this.onSubmitted,
  });

  final Color? initialColor;
  final Function(Color) onSubmitted;

  @override
  State createState() => _ColorPickerAlertState();
}

class _ColorPickerAlertState extends State<ColorPickerAlert> {

  Color? _color;
  ColorPickerMode _initialMode = ColorPickerMode.custom;

  @override
  void initState() {
    super.initState();

    _color = widget.initialColor ??  Colors.red.shade500;
    
    if(PaletteTab.allColors.contains(_color)) {
      _initialMode = ColorPickerMode.palette;
    } else {
      _initialMode = ColorPickerMode.manual;
    }
  }

  void _onColor(Color? c) => setState(() {
    _color = c;
  });

  @override
  Widget build(BuildContext context) {

    final StageData stage = Stage.of(context)!;

    return RadioHeaderedAlert<ColorPickerMode>(
      withoutHeader: true,
      customBackground: (theme) => theme.canvasColor,
      initialValue: _initialMode,
      bottomAction: FloatingActionButton(
        backgroundColor: _color,
        child: Icon(Icons.save,color: _color!.contrast),
        onPressed: (){
          if(_color != null){
            widget.onSubmitted(_color!);
            stage.closePanel();
          }
        },
      ),
      items: <ColorPickerMode, RadioHeaderedItem>{
        ColorPickerMode.manual  : RadioHeaderedItem(
          longTitle: "Manual color",
          title: "Manual", 
          child: ManualColorPicker(
            color: _color!,
            onChanged: _onColor,
          ), 
          icon: Icons.format_color_fill,
          alreadyScrollableChild: true,
        ),
        ColorPickerMode.custom  : RadioHeaderedItem(
          longTitle: "Custom color",
          title: "Custom", 
          child: CustomColorPicker(
            displayerUndescrollCallback: null,
            color: _color,
            onChanged: _onColor,
          ), 
          icon: Icons.short_text,
          alreadyScrollableChild: true,
        ),
        ColorPickerMode.palette  : RadioHeaderedItem(
          longTitle: "Material palette",
          title: "Palette", 
          child: PaletteColorPicker(
            ///Dont remember what non scrollable means precisely, has to do with the tab controller and re-initiating its state
            paletteUndescrollCallback: stage.closePanel,
            onChanged: _onColor,
            color: _color,
          ), 
          icon: McIcons.palette,
          unselectedIcon: McIcons.palette_outline,
          alreadyScrollableChild: true,
        ),
      },

    );
  }

}

