import 'package:flutter/cupertino.dart';

class FlashLighDialog extends StatelessWidget {
  final VoidCallback onPressed;

  FlashLighDialog({required this.onPressed});
  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text('No flashlight'),
      content: Text('The device does not have a flashlight'),
      actions: [
        CupertinoDialogAction(
          isDefaultAction: true,
          child: Text('Ok'),
          onPressed: this.onPressed,
        ),
      ],
    );
  }
}
