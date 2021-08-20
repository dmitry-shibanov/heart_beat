import 'package:flutter/material.dart';

class OrthostaticTimer extends StatefulWidget {
  final Function(bool) action;
  final String imageAsset;
  OrthostaticTimer({required this.action, required this.imageAsset});
  @override
  _OrthostaticTimerState createState() => _OrthostaticTimerState();
}

class _OrthostaticTimerState extends State<OrthostaticTimer>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
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
            Container(
              height: constraints.maxHeight * 0.6,
              child: Image.asset(widget.imageAsset),
            ),
            TweenAnimationBuilder<Duration>(
                duration: Duration(seconds: 30),
                tween: Tween(begin: Duration(seconds: 30), end: Duration.zero),
                onEnd: () {
                  widget.action(false);
                },
                builder: (context, value, child) {
                  final minutes = value.inMinutes;
                  final seconds = value.inSeconds % 60;
                  return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Text('$minutes:$seconds',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 30)));
                })
          ],
        ),
      );
    });
  }
}
