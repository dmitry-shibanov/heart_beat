import 'dart:async';
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter_heart/helper/PulseWorker.dart';

class PulseProvider with ChangeNotifier {
  PulseWorker _worker = PulseWorker();
  Timer? _timer;
  final List<int?> _pulses = [];
  final List<int> complexTest = [];

  bool get isActive => _timer != null && _timer!.isActive;

  int get pulse => _pulses.length != 0
      ? _pulses.reduce((value, element) => value! + element!)! ~/
              _pulses.length
      : 72;

  int get diff =>
      complexTest.length == 2 ? (complexTest[1] - complexTest[0]).abs() : -100;

  Future<void> startTimer(Duration timerDuration, VoidCallback action) async {
    if (complexTest.length == 2) {
      complexTest.clear();
    }
    _pulses.clear();
    bool isStarted;
    try {
    isStarted = await _worker.start();
    } catch(exp) {
      print('came here');
      throw exp;
    }
    if (isStarted) {
      var moveTime = Duration(seconds: 1);
      _timer = Timer.periodic(moveTime, (timer) {
        _worker?.current().then((value) {
          print(timer.tick);
          print(value);
          _pulses.add(value);
          if (timer.tick >= 15) {
            print("pulse is ${pulse}");
            complexTest.add(pulse);
            cancelTimer(timer);
            action();
            notifyListeners();
          }
        });
      });
    }
  }

  void cancelTimer([Timer? startTimer]) {
    startTimer?.cancel();
    _worker.stop();
    _timer?.cancel();
    _timer = null;
    
  }

  void stopTimer() {
    if (_timer != null && _timer!.isActive) {
      cancelTimer();
      complexTest.add(pulse);
      print("pulse is ${pulse}");
    }
  }
}
