import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:stage/stage.dart';


const IconData _kCancelIcon = MaterialCommunityIcons.close_circle_outline;
const IconData _kConfirmIcon = Icons.check;

class ConfirmAlert extends StatelessWidget {

  final String warningText;

  final VoidCallback action;

  final String confirmText;
  final IconData confirmIcon;
  final Color confirmColor;

  final String cancelText;
  final IconData cancelIcon;
  final Color cancelColor;

  final bool autoCloseAfterConfirm;

  final bool completelyCloseAfterConfirm;

  final bool twoLinesWarning;

  static const double height = AlternativesAlert.tileSize * 2 + PanelTitle.height; 
  static const double twoLinesheight = AlternativesAlert.tileSize * 2 + PanelTitle.twoLinesHeight; 

  ConfirmAlert({
    @required this.action,
    String warningText,
    String confirmText,
    IconData confirmIcon,
    this.confirmColor, //defaults to the text color provided by the context
    String cancelText,
    IconData cancelIcon,
    this.cancelColor, //defaults to the text color provided by the context
    this.autoCloseAfterConfirm = true,
    this.completelyCloseAfterConfirm = false,
    bool twoLinesWarning = false,
  }):
    this.cancelText = cancelText ?? "Cancel",
    this.confirmText = confirmText ?? "Confirm",
    this.confirmIcon = confirmIcon ??  _kConfirmIcon,
    this.cancelIcon = cancelIcon ??  _kCancelIcon,
    this.warningText = warningText ?? "Are you sure? This action may not be reversible.",
    this.twoLinesWarning = twoLinesWarning ?? false;

  @override
  Widget build(BuildContext context) {

    return AlternativesAlert(
      twoLinesLabel: this.twoLinesWarning,
      label: this.warningText,
      alternatives: [
        Alternative(
          action: this.action,
          color: this.confirmColor,
          title: this.confirmText,
          icon: this.confirmIcon,
          autoClose: this.autoCloseAfterConfirm,
          completelyAutoClose: this.completelyCloseAfterConfirm,
        ),
        Alternative(
          action: (){},
          color: this.cancelColor,
          title: this.cancelText,
          icon: this.cancelIcon,
          autoClose: true,
          completelyAutoClose: false,
        ),
      ],
    );
  }

}