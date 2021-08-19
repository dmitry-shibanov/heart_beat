import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class OrthostaticTestResult extends StatelessWidget {
  final points = [
    'The range from 0 to 12 beats indicates good fitness level',
    'The difference of 13-18 beats shows a healthy, but not trained person',
    'The range from 18 to 25 beats indicates a complete lack of physical fitness',
    'If the difference is more than 25 beats, then we can talk either about fatigue, or about a disease of the cardiovascular system or other health problems'
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12.0),
      child: Column(
        children: [
          ...points
              .map(
                (e) => Container(
                  margin: EdgeInsets.symmetric(vertical: 8.0),
                  child: ListTile(
                    leading: Icon(AntDesign.arrowright),
                    title: Text(
                      e,
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                          color: Color.fromRGBO(38, 38, 38, 1)),
                    ),
                  ),
                ),
              )
              .toList()
        ],
      ),
    );
  }
}
