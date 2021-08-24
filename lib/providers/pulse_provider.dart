import 'dart:async';
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter_heart/helper/PulseWorker.dart';

class PulseProvider with ChangeNotifier {
  PulseWorker _worker = PulseWorker();
  Timer? _timer;
  final List<int?> _pulses = [];
  final List<int> complexTest = [];

  bool get isActive => _timer?.isActive ?? false;

  int get pulse => _pulses.length != 0
      ? _pulses.reduce((value, element) => value! + element!)! ~/ _pulses.length
      : 72;

  int get diff =>
      complexTest.length == 2 ? (complexTest[1] - complexTest[0]).abs() : -100;

  Future<bool> startTimer(Duration timerDuration, VoidCallback action) async {
    if (complexTest.length == 2) {
      complexTest.clear();
    }
    _pulses.clear();
    bool isStarted = false;
    try {
      isStarted = await _worker.start();
    } on Exception catch (exp) {
      throw exp;
    }
    if (isStarted) {
      var moveTime = Duration(seconds: 1);
      _timer = Timer.periodic(moveTime, (timer) {
        _worker.current().then((value) {
          print(timer.tick);
          print(value);
          _pulses.add(value);
          if (timer.tick >= 15) {
            complexTest.add(pulse);
            cancelTimer(timer);
            action();
            notifyListeners();
          }
        });
      });
    }

    return isStarted;
  }

  void cancelTimer([Timer? startTimer]) {
    startTimer?.cancel();
    _worker.stop();
    _timer?.cancel();
    _timer = null;
  }

  void stopTimer() {
    if (isActive) {
      cancelTimer();
      complexTest.add(pulse);
    }
  }
}
