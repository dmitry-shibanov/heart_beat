import 'package:flutter/material.dart';
import 'package:flutter_heart/providers/pulse_provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class MeasureResult extends StatefulWidget {
  final int result;
  MeasureResult(this.result);
  @override
  _MeasureResultState createState() => _MeasureResultState();
}

class _MeasureResultState extends State<MeasureResult> {
  int currentMood = 1;
  List<String> mood = [
    'assets/images/svg/Emoji_happy.svg',
    'assets/images/svg/Emoji_normal.svg',
    'assets/images/svg/Emoji_sad.svg'
  ];

  BoxDecoration? getLayer(int mood) {
    if (currentMood == mood) {
      return BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/layer.png'),
            fit: BoxFit.cover,
            alignment: Alignment(0.0, -0.3)),
      );
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PulseProvider>(context);
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/smaller_heart.png',
              scale: 3,
            ),
            Container(
              margin: EdgeInsets.only(
                  top: constraints.maxHeight * 0.05,
                  bottom: constraints.maxHeight * 0.03),
              child: Text(
                'Your result',
                style: TextStyle(
                    color: Color.fromRGBO(70, 70, 70, 1),
                    fontWeight: FontWeight.w400,
                    fontSize: 17),
              ),
            ),
            FittedBox(
              child: Container(
                child: Text(
                  provider.pulse.toString(),
                  style: TextStyle(
                      color: Color.fromRGBO(38, 38, 38, 1),
                      fontWeight: FontWeight.w800,
                      fontSize: 72),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: constraints.maxHeight * 0.1),
              child: Text(
                'bpm',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w400,
                    color: Color.fromRGBO(138, 138, 138, 1)),
              ),
            ),
            Text(
              'How is your mood?',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 22,
                color: Color.fromRGBO(38, 38, 38, 1),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: constraints.maxHeight * 0.04,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ...mood
                      .asMap()
                      .map<int, Widget>((index, imageStr) {
                        return MapEntry(
                            index,
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  currentMood = index;
                                });
                              },
                              child: Container(
                                height: MediaQuery.of(context).size.width / 5,
                                width: MediaQuery.of(context).size.width / 5,
                                child: Align(
                                  alignment: Alignment(0.0, 1.0),
                                  child: Container(
                                    height:
                                        MediaQuery.of(context).size.width / 6,
                                    width:
                                        MediaQuery.of(context).size.width / 6,
                                    child: SvgPicture.asset(
                                      imageStr,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                decoration: getLayer(index),
                              ),
                            ));
                      })
                      .values
                      .toList(),
                ],
              ),
            )
          ],
        );
      },
    );
  }
}
