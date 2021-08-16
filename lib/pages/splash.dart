import 'package:flutter/material.dart';
import 'package:flutter_heart/components/heart.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 40.0),
            child: Heart(),
          ),
          Container(
            width: MediaQuery.of(context).size.width / 2,
            child: Text(
              'Heart Rate Monitor: bpm | bpm',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      )),
    );
  }
}
