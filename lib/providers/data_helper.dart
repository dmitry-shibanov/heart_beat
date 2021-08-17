import 'package:flutter/material.dart';
import 'package:flutter_heart/db/database.dart';
import 'package:flutter_heart/models/TestPulse.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DbHelper with ChangeNotifier {
  DatabaseProvider? _provider;
  List<TestPulse>? _userRecords = [];

  DbHelper(this._userRecords, this._provider) {
    _getAllRecords();
  }

  void _getAllRecords() async {
    if (this._provider != null && _userRecords!.isEmpty) {
      _userRecords = await _provider!.getAllRecords();
    }

    notifyListeners();
  }

  // _incrementCounter() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   int introPage = (prefs.getInt('introPage') ?? 0);
  //   return introPage;
  // }

  TestPulse getRecord(int id) {
    final pules = _userRecords!.firstWhere((element) => element.id == id);

    return pules;
  }

  List<TestPulse> get records => [..._userRecords!];

  void addRecord(TestPulse pules) {
    _userRecords!.add(pules);
    notifyListeners();
    _provider!.insert(pules);
  }

  void removeRecord({TestPulse? pulse, int? id}) {
    if (pulse == null && id == null) {
      throw new Error();
    }

    id ??= id ?? pulse?.id;

    _userRecords!.removeWhere((element) => element.id == id);
    notifyListeners();
    _provider!.delete(id!);
  }
}
