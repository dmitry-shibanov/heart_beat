import 'dart:async';
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter_heart/helper/PulseWorker.dart';

class PulseProvider with ChangeNotifier {
  PulseWorker _worker = PulseWorker();
  Timer? _timer;
  Duration _interval = Duration(seconds: 1);
  List<int?> _pulses = [];
  int _currentSeconds = 0;
  List<int> complexTest = [];

  bool get isActive => _timer != null && _timer!.isActive;

  int get pulse => _pulses.length != 0
      ? (_pulses.reduce((value, element) => value! + element!)! /
              _pulses.length)
          .toInt()
      : 72;

  int get diff =>
      complexTest.length == 2 ? (complexTest[1] - complexTest[0]).abs() : -100;

  void startTimer(Duration duration, Function() action) async {
    action();
    if (complexTest.length == 2) {
      complexTest.clear();
    }
    _pulses.clear();
    final seconds = duration.inSeconds;
    bool isStarted = await _worker.start();
    if (isStarted) {
      var duration = Duration(seconds: 1);
      _timer = Timer.periodic(duration, (timer) {
        _worker!.current().then((value) {
          print(timer.tick);
          print(value);
          _pulses.add(value);
          _currentSeconds = timer.tick;
          if (timer.tick >= 30) {
            timer.cancel();
            _worker.stop();
            print("pulse is ${pulse}");
            _timer = null;
            complexTest.add(pulse);
            action();
            notifyListeners();
          }
        });
      });
    }
  }

  void stopTimer(Duration duration) {
    if (_timer != null && _timer!.isActive) {
      _timer!.cancel();
      _timer = null;
      _worker.stop();
      complexTest.add(pulse);
      print("pulse is ${pulse}");
      notifyListeners();
    }
  }

  // void clearComplex()
}