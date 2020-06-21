import 'package:stage/stage.dart';
import 'package:flutter/material.dart';


class ConfirmSnackbar extends StatelessWidget {

  const ConfirmSnackbar({
    @required this.action,
    @required this.label,
  });

  final String label;
  final VoidCallback action;

  @override
  Widget build(BuildContext context) {
    return StageSnackBar(
      scrollable: true,
      title: Text(label),
      secondary: StageSnackButton(
        onTap: action,
        child: const Icon(Icons.check),
        autoClose: true,
      ),
    );
  }
}