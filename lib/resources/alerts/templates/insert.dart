import 'package:flutter/material.dart';
import 'package:stage/stage.dart';

String _theUnchecker(String s) => "";

class InsertAlert extends StatefulWidget {
  InsertAlert({
    required this.onConfirm,
    this.hintText,
    required this.labelText,
    this.inputType = TextInputType.text,
    this.checkErrors = _theUnchecker,
    this.maxLenght = 50,
    this.initialText,
    this.textCapitalization = TextCapitalization.sentences,
    this.twoLinesLabel = false,
  });

  final String? initialText;
  final String? hintText;
  final String labelText;
  final bool twoLinesLabel;
  //if confirm returns false, the panel is not closed
  final Function(String) onConfirm;
  final TextInputType inputType;
  final String? Function(String) checkErrors;
  final int maxLenght;
  final TextCapitalization textCapitalization;

  static const double height = PanelTitle.height + _insert + _buttons;
  static const double twoLinesHeight = PanelTitle.twoLinesHeight + _insert + _buttons;
  static const double _insert = 78.0;
  static const double _buttons = 56.0;

  @override
  _InsertAlertState createState() => _InsertAlertState();
}

class _InsertAlertState extends State<InsertAlert> {

  late TextEditingController controller;
  late FocusNode focusNode;
  bool started = false;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(
      text: widget.initialText ?? "",
    );
    focusNode = FocusNode();
  }

  @override
  void dispose() {
    controller.dispose();
    focusNode.dispose();
    super.dispose();
  }

  String? get displayErrorString => started == false 
    ? null
    : widget.checkErrors(controller.text);
  
  String? get errorString => widget.checkErrors(controller.text);
  bool get valid => (errorString ?? "").isEmpty;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          title,
          textField,
          buttons,
        ],
      ),
    );
  }

  PanelTitle get title => PanelTitle(
    widget.labelText, 
    twoLines: widget.twoLinesLabel,
  );

  Widget get textField {
    final theme = Theme.of(context);
    return SizedBox(
      height: InsertAlert._insert,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 4, 10, 0),
        child: Material(
          clipBehavior: Clip.antiAlias,
          color: SubSection.getColor(theme),
          borderRadius: BorderRadius.circular(10),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextField(
              focusNode: focusNode,
              keyboardType: widget.inputType,
              autofocus: true,
              textAlign: TextAlign.center,
              maxLength: widget.maxLenght,
              controller: controller,
              textCapitalization: widget.textCapitalization,
              style: const TextStyle(fontSize: 17.0),
              onChanged: (String ts) => setState((){
                started = true;
              }),
              cursorColor: theme.textTheme.bodyMedium?.color,
              decoration: InputDecoration(
                errorText: displayErrorString?.nullIfEmpty,
                hintText: widget.hintText,
                border: InputBorder.none,
                hoverColor: Colors.yellow,
                focusColor: Colors.yellow,
                fillColor: Colors.yellow,
                iconColor: Colors.yellow,
                prefixIconColor: Colors.yellow,
                suffixIconColor: Colors.yellow,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget get buttons {
    final stage = Stage.of(context)!;
    return SizedBox(
      height: InsertAlert._buttons,
      child: Row(
        children: <Widget>[
          Expanded(child: button(
            icon: const Icon(Icons.close), 
            title: const Text("Cancel"), 
            onTap: stage.panelController.close,
          ),),
          Expanded(child: button(
            icon: const Icon(Icons.check), 
            title: const Text("Confirm"), 
            onTap: valid ? () {
              final result = widget.onConfirm(controller.text);
              if(result != false){
                stage.panelController.close();
              }
            } : null,
          ),),
        ],
      )
    );
  }

  Widget button({
    required Widget title, 
    required Widget icon, 
    required VoidCallback? onTap,
  }) => InkWell(
    onTap: onTap,
    child: Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          icon,
          const Space.horizontal(8),
          title,
        ],
      ),
    ),
  );

}



extension _StringExt on String {
  String? get nullIfEmpty => isEmpty ? null : this;
}