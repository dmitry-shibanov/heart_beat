import 'package:flutter/material.dart';
import 'package:flutter_heart/components/heart.dart';

class FirstMeasure extends StatefulWidget {
  Function() startMeasure;
  FirstMeasure({required this.startMeasure});
  @override
  _FirstMeasureState createState() => _FirstMeasureState();
}

class _FirstMeasureState extends State<FirstMeasure> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.startMeasure();
  }

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
            child: Container(
              width: constraints.maxWidth * 0.65,
              child: Text(
                'Do not remove your finger, measurement is in progress',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 17,
                  color: Color.fromRGBO(177, 177, 177, 1),
                ),
              ),
            ),
          )
        ],
      );
    });
  }
}
