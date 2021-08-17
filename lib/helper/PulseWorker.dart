import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class PulseWorker {
  final _platform = new MethodChannel('aw.measure.cia');
  Future<bool> start() async {
    if (kDebugMode) {
      return Future.value(true);
    }
    return await _platform.invokeMethod<bool>('start') ?? false;
  }

  Future<bool> stop() async {
    if (kDebugMode) {
      return Future.value(true);
    }
    return _platform.invokeMethod('stop').then((value) => value as bool);
  }

  Future<int?> current() async {
    if (kDebugMode) {
      return Future.value(Random().nextInt(100));
    }
    return _platform
        .invokeMethod('current')
        .then((value) => (value == null) ? null : value as int);
  }
}
