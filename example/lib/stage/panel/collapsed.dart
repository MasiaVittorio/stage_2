import 'package:example/core.dart';

class CollapsedPanel extends StatelessWidget {

  const CollapsedPanel({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    final stage = Stage.of(context)!;
    return InkResponse(
      onTap: stage.openPanel,
      child: Row(children: <Widget>[
        IconButton(
          icon: const Icon(McIcons.alert), 
          onPressed: () => stage.showAlert(
            ConfirmAlert(
              action: () => stage.showSnackBar(const StageSnackBar(title: Text("Confirmed!"), scrollable: true),),
            ),
            size: ConfirmAlert.height,
          ),
        ),
        const Expanded(child: Center(child: AlertDrag()),),
        IconButton(
          icon: const Icon(Icons.notifications),
          onPressed: () => stage.showSnackBar(ConfirmSnackbar(
            label:"Snackbar!",
            action: () => stage.showSnackBar(const StageSnackBar(title: Text("Confirmed!"), scrollable: true,)),
          ),rightAligned: true),
        ),
      ],),
    );
  }
}