import 'package:flutter/material.dart';
import 'package:flutter_heart/components/heart.dart';
import 'package:flutter_icons/flutter_icons.dart';

class OnBoardingFinal extends StatelessWidget {
  final points = [
    'Recording of measurements',
    'Keep track of your health status',
    'Orthostatic Test'
  ];

  final Widget checkIcon = ShaderMask(
    child: Icon(Feather.check_circle),
    blendMode: BlendMode.srcATop,
    shaderCallback: (bounds) {
      return LinearGradient(colors: [
        Color.fromRGBO(252, 90, 68, 1),
        Color.fromRGBO(196, 20, 50, 1)
      ]).createShader(bounds);
    },
  );

  final listStyle = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 17,
    color: Color.fromRGBO(38, 38, 38, 1),
  );

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Column(
        children: [
          Heart(
            height: constraints.maxHeight * 0.4,
          ),
          SizedBox(
            height: constraints.maxHeight * 0.1,
          ),
          ...(points
              .map(
                (e) => Container(
                  margin: EdgeInsets.only(left: 16),
                  child: ListTile(
                    minLeadingWidth: 15,
                    leading: checkIcon,
                    title: Text(
                      e,
                      style: listStyle,
                    ),
                  ),
                ),
              )
              .toList()),
        ],
      );
    });
  }
}
