import 'package:flutter/material.dart';

class OnBoardingCommon extends StatelessWidget {
  late final String imageStr;
  late final String content;

  OnBoardingCommon({required this.imageStr, required this.content});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 24.0),
          child: Text(
            content,
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
            imageStr,
            width: double.infinity,
            // height: 281,
            fit: BoxFit.cover,
          ),
        )
      ],
    );
  }
}
