import 'package:flutter/material.dart';

class MainProvider with ChangeNotifier {
  bool _isLeading = false;
  bool get isLeading => _isLeading;
  VoidCallback? _action;

  void action() {
    if (action != null) {
      _action!();
    }
    _clearData();
  }

  void _clearData() {
    _action = null;
    _isLeading = false;
    notifyListeners();
  }

  void setLeading(bool value, VoidCallback action) {
    _isLeading = value;
    _action = action;
    notifyListeners();
  }
}
