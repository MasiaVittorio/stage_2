import 'package:flutter/material.dart';
import 'package:stage/stage.dart';

String _theUnchecker(String s) => "";

class InsertAlert extends StatefulWidget {
  InsertAlert({
    @required this.onConfirm,
    this.hintText,
    @required this.labelText,
    this.inputType = TextInputType.text,
    this.checkErrors = _theUnchecker,
    this.maxLenght = 50,
    this.initialText,
    this.textCapitalization = TextCapitalization.sentences,
    this.twoLinesLabel = false,
  }): assert(twoLinesLabel != null),
      assert(labelText != null);

  final String initialText;
  final String hintText;
  final String labelText;
  final bool twoLinesLabel;
  //if confirm returns false, the panel is not closed
  final Function(String) onConfirm;
  final TextInputType inputType;
  final String Function(String) checkErrors;
  final int maxLenght;
  final TextCapitalization textCapitalization;

  static const double height = PanelTitle.height + _insert + _buttons;
  static const double twoLinesHeight = PanelTitle.twoLinesHeight + _insert + _buttons;
  static const double _insert = 72.0;
  static const double _buttons = 56.0;

  @override
  _InsertAlertState createState() => _InsertAlertState();
}

class _InsertAlertState extends State<InsertAlert> {

  TextEditingController _controller;
  bool _started = false;

  @override
  void initState() {
    super.initState();
    this._controller = TextEditingController(
      text: widget.initialText ?? "",
    );

  }

  @override
  void dispose() {
    this._controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final String _errorString = _started == false 
      ? ""
      : this.widget.checkErrors(this._controller.text);
    final String _seriousErrorString = this.widget.checkErrors(this._controller.text);
    
    final bool _valid = _errorString == "" || _errorString == null;
    final bool _seriouslyValid = _seriousErrorString == "" || _seriousErrorString == null;
    final stage = Stage.of(context);

    return Material(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[

          PanelTitle(widget.labelText, twoLines: widget.twoLinesLabel,),

          Container(
            height: InsertAlert._insert,
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextField(
              keyboardType: widget.inputType,
              autofocus: true,
              textAlign: TextAlign.center,
              maxLength: this.widget.maxLenght,
              controller: this._controller,
              textCapitalization: widget.textCapitalization ?? TextCapitalization.words,
              style: const TextStyle(inherit:true, fontSize: 18.0),
              onChanged: (String ts) => this.setState((){
                _started = true;
              }),
              decoration: InputDecoration(
                errorText: !_valid ? _errorString : null,
                hintText: this.widget.hintText,
              ),
            ),
          ),

          Container(
            height: InsertAlert._buttons,
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextButton(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        const Icon(Icons.close),
                        const SizedBox(width: 8.0),
                        const Text("Cancel"),
                      ],
                    ),
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsets>(
                        const EdgeInsets.symmetric(vertical: 16.0),
                      ),
                    ),
                    onPressed: stage.panelController.close,
                  ),
                ),
                Expanded(
                  child: TextButton(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        const Icon(Icons.check),
                        const SizedBox(width: 8.0),
                        const Text("Confirm"),
                      ],
                    ),
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsets>(
                        const EdgeInsets.symmetric(vertical: 16.0),
                      ),
                    ),
                    onPressed: _seriouslyValid ? () {
                      final result = this.widget.onConfirm(this._controller.text);
                      if(result != false){
                        stage.panelController.close();
                      }
                    } : null,
                  ),
                )
              ],
            )
          ),

        ],
      ),
    );
  }
}

