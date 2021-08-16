import 'dart:async';

import 'package:flutter/material.dart';

class CustomTimer extends StatefulWidget {
  DateTime time;

  CustomTimer(this.time);

  @override
  _TimerState createState() => _TimerState();
}

class _TimerState extends State<CustomTimer> {
  final interval = const Duration(seconds: 1);
  final int timerMaxSeconds = 60;
  late int currentSeconds;

  _TimerState() {
    this.currentSeconds = widget.time.second;
  }

  String get timerText =>
      '${((timerMaxSeconds - currentSeconds) ~/ 60).toString().padLeft(2, '0')}: ${((timerMaxSeconds - currentSeconds) % 60).toString().padLeft(2, '0')}';

  startTimeout([int milliseconds = 0]) {
    var duration = interval;
    Timer.periodic(duration, (timer) {
      setState(() {
        print(timer.tick);
        currentSeconds = timer.tick;
        if (timer.tick >= timerMaxSeconds) timer.cancel();
      });
    });
  }

  @override
  void initState() {
    startTimeout();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          timerText,
          style: TextStyle(
              color: Color.fromRGBO(70, 70, 70, 1),
              fontWeight: FontWeight.w700,
              fontSize: 30),
        )
      ],
    );
  }
}
