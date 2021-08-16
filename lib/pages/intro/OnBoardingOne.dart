import 'package:flutter/material.dart';
import 'package:flutter_heart/components/heart.dart';

class OnBoardingOne extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Heart(),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 40.0),
          child:Text(
          'This heart rate app helps you keep track of your heart health. It is very easy to use it at any time, as it is always at hand',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 22,
              color: Color.fromRGBO(38, 38, 38, 1)),
        ),),
      ],
    );
  }
}
