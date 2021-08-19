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

  TestPulse getRecord(int id) {
    final pules = _userRecords!.firstWhere((element) => element.id == id);

    return pules;
  }

  TestPulse get getLastRecord => _userRecords!.last;

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
    print("id is ${id}");
    _provider!.delete(id!);
  }
}
