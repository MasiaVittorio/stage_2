import 'package:flutter/material.dart';
import 'package:sid_ui/sid_ui.dart';
import 'package:stage/stage.dart';

import 'package:sid_ui/interactive/material_color_picker/custom_color_picker.dart';
import 'package:sid_ui/interactive/material_color_picker/manual_color_picker.dart';
import 'package:sid_ui/interactive/material_color_picker/palette_color_picker.dart';
import 'package:sid_ui/interactive/material_color_picker/this_double_color.dart';


class ColorPickerAlert extends StatefulWidget {
  ColorPickerAlert({
    this.initialColor,
    @required this.onSubmitted,
  });

  final Color initialColor;
  final Function(Color) onSubmitted;

  @override
  _ColorPickerAlertState createState() => _ColorPickerAlertState();
}

class _ColorPickerAlertState extends State<ColorPickerAlert> {

  Color _color;
  ColorPickerMode _initialMode = ColorPickerMode.custom;

  @override
  void initState() {
    super.initState();

    this._color = widget.initialColor ??  Colors.red.shade500;
    
    if(allMaterialPalette.contains(this._color))
      this._initialMode = ColorPickerMode.palette;
    else 
      this._initialMode = ColorPickerMode.manual;
  }

  void _onColor(Color c) {
    setState(() {
      this._color = c;               
    });
  }

  void _onNewMode(ColorPickerMode newMode){
    if(newMode == ColorPickerMode.palette){
      if(!allMaterialPalette.contains(this._color)){
        this.setState((){
          this._color = findClosest(this._color);
        });
      }
    }      
  }

  @override
  Widget build(BuildContext context) {

    final StageData stage = Stage.of(context);

    final Widget _manualWidget = ManualColorPicker(
      color: this._color,
      onChanged: this._onColor,
    );
    final Widget _customWidget = CustomColorPicker(
      displayerUndescrollCallback: null,
      color: this._color,
      onChanged: this._onColor,
    );
    final Widget _paletteWidget = PaletteColorPicker(
      ///Dont remember what non scrollable means precisely, has to do with the tab controller and re-initiating its state
      paletteUndescrollCallback: stage.closePanel,
      onChanged: this._onColor,
      color: this._color,
    );

    

    return RadioHeaderedAlert<ColorPickerMode>(
      //action: onSubmitted and close
      //action color: ,
      //action icon: , (tutto in un widget?)
      withoutHeader: true,
      canvasBackground: true,
      initialValue: _initialMode,
      onPageChanged: _onNewMode,
      bottomAction: FloatingActionButton(
        backgroundColor: _color,
        child: Icon(Icons.save,color: _color.contrast),
        onPressed: (){
          widget.onSubmitted(_color);
          stage.closePanel();
        },
      ),
      items: <ColorPickerMode, RadioHeaderedItem>{
        ColorPickerMode.manual  : RadioHeaderedItem(
          longTitle: "Manual color",
          title: "Manual", 
          child: _manualWidget, 
          icon: Icons.format_color_fill,
          alreadyScrollableChild: true,
        ),
        ColorPickerMode.custom  : RadioHeaderedItem(
          longTitle: "Custom color",
          title: "Custom", 
          child: _customWidget, 
          icon: Icons.short_text,
          alreadyScrollableChild: true,
        ),
        ColorPickerMode.palette  : RadioHeaderedItem(
          longTitle: "Material palette",
          title: "Palette", 
          child: _paletteWidget, 
          icon: McIcons.palette,
          unselectedIcon: McIcons.palette_outline,
          alreadyScrollableChild: true,
        ),
      },

    );
  }

}

