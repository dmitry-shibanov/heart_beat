import 'package:flutter/material.dart';
import 'package:flutter_heart/components/heart.dart';

class FirstMeasure extends StatefulWidget {
  @override
  _FirstMeasureState createState() => _FirstMeasureState();
}

class _FirstMeasureState extends State<FirstMeasure> {
  //   startTimeout([int milliseconds]) {
  //   var duration = interval;
  //   Timer.periodic(duration, (timer) {
  //     setState(() {
  //       print(timer.tick);
  //       currentSeconds = timer.tick;
  //       if (timer.tick >= timerMaxSeconds) timer.cancel();
  //     });
  //   });
  // }
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, constraints) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Heart(
            height: constraints.maxHeight * 0.45,
          ),
          FittedBox(
            child: Text(
              'Do not remove your finger, measurement is in progress',
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 17,
                color: Color.fromRGBO(177, 177, 177, 1),
              ),
            ),
          )
        ],
      );
    });
  }
}
