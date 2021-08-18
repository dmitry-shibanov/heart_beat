import 'package:flutter/material.dart';
import 'package:flutter_heart/components/heart.dart';

class OrthostaticResult extends StatelessWidget {
  late final String resultPulse;
  final String? message;
  late double diff;
  OrthostaticResult({required this.resultPulse, this.message}) {
    if (message == null) {
      diff = 1.0;
    } else {
      diff = 0.9;
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Heart(
              height: constraints.maxHeight * 0.45 * diff,
              geometry: EdgeInsets.only(top: constraints.maxHeight * 0.05),
            ),
            Container(
              margin: EdgeInsets.only(
                  top: constraints.maxHeight * 0.1 * diff,
                  bottom: constraints.maxHeight * 0.04 * diff),
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
                  resultPulse,
                  style: TextStyle(
                      color: Color.fromRGBO(38, 38, 38, 1),
                      fontWeight: FontWeight.w800,
                      fontSize: 72),
                ),
              ),
            ),
            Container(
              child: Text(
                'bpm',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w400,
                    color: Color.fromRGBO(138, 138, 138, 1)),
              ),
            ),
            if (message != null)
              FittedBox(
                child: Container(
                  margin: EdgeInsets.only(top: constraints.maxHeight * 0.1),
                  child: Text(
                    message!,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Color.fromRGBO(38, 38, 38, 1),
                        fontWeight: FontWeight.w600,
                        fontSize: 22),
                  ),
                ),
              )
          ],
        );
      },
    );
  }
}
