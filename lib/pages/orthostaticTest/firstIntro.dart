import 'package:flutter/material.dart';

class OrthostaticTestIntro extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Orthostatic test is an easy way to monitor the state of your body and its adaptation to stress',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 22,
            color: Color.fromRGBO(38, 38, 38, 1),
          ),
        ),
        SizedBox(height: 16.0),
        Text(
          'The essence of the test is simple and consists in measuring the pulse lying down and then standing - the difference between these two measurements can tell a lot about your form, the degree of fatigue, the general state of the body, as well as signal problems in the central nervous and cardiovascular systems.,',
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w400,
            color: Color.fromRGBO(70, 70, 70, 1),
          ),
        )
      ],
    );
  }
}
