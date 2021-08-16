class TestPulse {
  late int _id;
  late int _smile;
  late int _dateMiliseconds;
  late int _metric;

  int get id => _id;
  int get smile => _smile;
  int get metric => _metric;
  DateTime get date =>
      DateTime.fromMicrosecondsSinceEpoch(this._dateMiliseconds);

  TestPulse.fromJson(Map<dynamic, dynamic> map) {
    this._id = map['_id'];
    this._smile = map['smile'];
    this._dateMiliseconds = map['date'];
    this._metric = map['metric'];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = new Map();
    map['_id'] = this._id;
    map['smile'] = this._smile;
    map['date'] = this._dateMiliseconds;
    map['metric'] = this._metric;
    return map;
  }
}
