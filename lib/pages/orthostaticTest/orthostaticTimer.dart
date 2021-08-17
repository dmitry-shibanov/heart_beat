import 'package:flutter/material.dart';

class OrthostaticTimer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        children: [
          Text(
            'Lie down for 10 minutes, and then measure your pulse at rest',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 22,
              color: Color.fromRGBO(38, 38, 38, 1),
            ),
          ),
          SizedBox(height: 16.0),
          Image.asset('assets/images/man_with_clocks.png')
        ],
      ),
    );
  }
}
