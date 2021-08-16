import 'package:flutter/material.dart';

class SubscribePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              Navigator.of(context).pop<int>(0);
            },
          ),
        ),
        body: Column());
  }
}
