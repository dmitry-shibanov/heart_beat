class TestPulse {
  late int _id;
  late int _smile;
  late int _dateMiliseconds;
  late int _metric;

  int get id => _id;
  int get smile => _smile;
  int get metric => _metric;

  set id(int value) {
    this._id = value;
  }

  set smile(int value) {
    this._smile = value;
  }

  DateTime get date =>
      DateTime.fromMicrosecondsSinceEpoch(this._dateMiliseconds);

  TestPulse.fromJson(Map<dynamic, dynamic> map) {
    if (map["_id"] != null) {
      this._id = map['_id'];
    }
    this._smile = map['image'];
    this._dateMiliseconds = map['date'];
    this._metric = map['metric'];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = new Map();
    if (_id != null) {
      map['_id'] = this._id;
    }
    map['image'] = this._smile;
    map['date'] = this._dateMiliseconds;
    map['metric'] = this._metric;
    return map;
  }
}
