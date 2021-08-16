import 'package:flutter/material.dart';

class OnBoardingCommon extends StatelessWidget {
  int index;

  OnBoardingCommon(this.index);

  final images = [
    'assets/images/green_man.png',
    'assets/images/run_man.png',
    'assets/images/bodybuilding_man.png'
  ];

  final content = [
    'Hold your finger on the camera lens and the flashlight',
    'The orthostatic test is one of the tools that allows you to find a balance between training and recovery',
    'The orthostatic test is one of the tools that allows you to find a balance between training and recovery'
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 24.0),
          child: Text(
            content[this.index],
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w600,
              color: Color.fromRGBO(38, 38, 38, 1),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(right: 52, left: 42, top: 50),
          child: Image.asset(
            images[this.index],
            width: double.infinity,
            height: 281,
            fit: BoxFit.cover,
          ),
        )
      ],
    );
  }
}
