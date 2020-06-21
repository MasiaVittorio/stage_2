import 'package:example/core.dart';

class CollapsedPanel extends StatelessWidget {
  
  const CollapsedPanel();
  
  @override
  Widget build(BuildContext context) {
    final stage = Stage.of(context);
    return InkResponse(
      onTap: stage.openPanel,
      child: Row(children: <Widget>[
        IconButton(
          icon: Icon(McIcons.alert), 
          onPressed: () => stage.showAlert(
            ConfirmAlert(
              action: () => stage.showSnackBar(StageSnackBar(title: Text("Confirmed!"), scrollable: true),),
            ),
            size: ConfirmAlert.height,
          ),
        ),
        Expanded(child: Center(child: AlertDrag()),),
        IconButton(
          icon: Icon(Icons.notifications),
          onPressed: () => stage.showSnackBar(ConfirmSnackbar(
            label:"Snackbar!",
            action: () => stage.showSnackBar(StageSnackBar(title: Text("Confirmed!"), scrollable: true,)),
          ),rightAligned: true),
        ),
      ],),
    );
  }
}