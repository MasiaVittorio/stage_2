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
  final Color? confirmColor;

  final String cancelText;
  final IconData cancelIcon;
  final Color? cancelColor;

  final bool autoCloseAfterConfirm;

  final bool completelyCloseAfterConfirm;

  final bool twoLinesWarning;

  static const double height = AlternativesAlert.tileSize * 2 + PanelTitle.height; 
  static const double twoLinesheight = AlternativesAlert.tileSize * 2 + PanelTitle.twoLinesHeight; 

  const ConfirmAlert({
    required this.action,
    String? warningText,
    String? confirmText,
    IconData? confirmIcon,
    this.confirmColor, //defaults to the text color provided by the context
    String? cancelText,
    IconData? cancelIcon,
    this.cancelColor, //defaults to the text color provided by the context
    this.autoCloseAfterConfirm = true,
    this.completelyCloseAfterConfirm = false,
    this.twoLinesWarning = false,
  }):
    cancelText = cancelText ?? "Cancel",
    confirmText = confirmText ?? "Confirm",
    confirmIcon = confirmIcon ??  _kConfirmIcon,
    cancelIcon = cancelIcon ??  _kCancelIcon,
    warningText = warningText ?? "Are you sure? This action may not be reversible.";

  @override
  Widget build(BuildContext context) {

    return AlternativesAlert(
      twoLinesLabel: twoLinesWarning,
      label: warningText,
      alternatives: [
        Alternative(
          action: action,
          color: confirmColor,
          title: confirmText,
          icon: confirmIcon,
          autoClose: autoCloseAfterConfirm,
          completelyAutoClose: completelyCloseAfterConfirm,
        ),
        Alternative(
          action: (){},
          color: cancelColor,
          title: cancelText,
          icon: cancelIcon,
          autoClose: true,
          completelyAutoClose: false,
        ),
      ],
    );
  }

}