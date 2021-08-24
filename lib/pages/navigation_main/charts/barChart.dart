import 'dart:async';
import 'package:flutter/gestures.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_heart/models/TestPulse.dart';
import 'package:flutter_heart/providers/data_helper.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class BarChartCustom extends StatefulWidget {
  final DateTime start;
  final DateTime finish;
  BarChartCustom({required this.start, required this.finish});

  final List<Color> availableColors = [
    Colors.purpleAccent,
    Colors.yellow,
    Colors.lightBlue,
    Colors.orange,
    Colors.pink,
    Colors.redAccent,
  ];

  @override
  State<StatefulWidget> createState() => BarChartCustomState();
}

class BarChartCustomState extends State<BarChartCustom> {
  final Color barBackgroundColor = Colors.red;//const Color(0xff72d8bf);
  final Duration animDuration = const Duration(milliseconds: 250);

  int touchedIndex = -1;

  bool isPlaying = false;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        color: Colors.white,
        child: Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Consumer<DbHelper>(
                        builder: (context, db, widget) {
                          return BarChart(
                            mainBarData(db),
                            swapAnimationDuration: animDuration,
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  BarChartGroupData makeGroupData(
    int x,
    double y, {
    bool isTouched = false,
    Color barColor = Colors.red,
    double width = 22,
    List<int> showTooltips = const [],
  }) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          y: isTouched ? y + 1 : y,
          colors: isTouched ? [Colors.yellow] : [barColor],
          width: width,
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            y: 20,
            colors: [barBackgroundColor],
          ),
        ),
      ],
      showingTooltipIndicators: showTooltips,
    );
  }

  Map<int, double> createProperDataSet(
      DateTime first, DateTime second, List<TestPulse> records) {
    List<int> days = List.generate(7, (index) => 0);
    Map<int, double> results = {};
    records.forEach((e) {
      print(DateFormat.d().format(e.date));
      if (e.date.microsecondsSinceEpoch >= first.microsecondsSinceEpoch &&
          e.date.microsecondsSinceEpoch <= second.microsecondsSinceEpoch) {
            int key = (e.date.weekday + 1) % 7;
        if (results.containsKey(key)) {
          results.update(key, (value) => value + e.metric);
        } else {
          results[key] = e.metric.toDouble();
        }
        days[key - 1] += 1;
      }
    });

    final finalMap = results.map((key, value) {
      return new MapEntry(key, value / days[key - 1]);
    });

    return finalMap;
  }

  List<BarChartGroupData> showingGroups(Map<int, double> map) {
    print(DateTime.now().weekday);
    final keys = map.keys.toList();
    return List.generate(7, (i) {
      if (keys.contains(i + 1)) {
        double value = map[i + 1]!;
        return makeGroupData(i, value, isTouched: i == touchedIndex);
      }
      return makeGroupData(i, 0, isTouched: i == touchedIndex);
    });
  }

  BarChartData mainBarData(DbHelper db) {
    final records = db.records;
    final dataSet = createProperDataSet(widget.start, widget.finish, records);
    print("dataSet is ${dataSet}");
    return BarChartData(
      maxY: 150,
      gridData: FlGridData(
        show: true,
        horizontalInterval: 20,
        getDrawingHorizontalLine: (value) {
          return FlLine(
              color: const Color(0xff37434d),
              strokeWidth: 1,
              dashArray: [5, 5]);
        },
      ),
      barTouchData: BarTouchData(
        touchTooltipData: BarTouchTooltipData(
            tooltipBgColor: Colors.blueGrey,
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              String weekDay;
              switch (group.x.toInt()) {
                case 0:
                  weekDay = 'Monday';
                  break;
                case 1:
                  weekDay = 'Tuesday';
                  break;
                case 2:
                  weekDay = 'Wednesday';
                  break;
                case 3:
                  weekDay = 'Thursday';
                  break;
                case 4:
                  weekDay = 'Friday';
                  break;
                case 5:
                  weekDay = 'Saturday';
                  break;
                case 6:
                  weekDay = 'Sunday';
                  break;
                default:
                  throw Error();
              }
              return BarTooltipItem(
                weekDay + '\n',
                TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: (rod.y - 1).toString(),
                    style: TextStyle(
                      color: Colors.yellow,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              );
            }),
        touchCallback: (barTouchResponse) {
          setState(() {
            if (barTouchResponse.spot != null &&
                barTouchResponse.touchInput is! PointerUpEvent &&
                barTouchResponse.touchInput is! PointerExitEvent) {
              touchedIndex = barTouchResponse.spot!.touchedBarGroupIndex;
            } else {
              touchedIndex = -1;
            }
          });
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          getTextStyles: (context, value) => const TextStyle(
              color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 14),
          margin: 16,
          getTitles: (double value) {
            switch (value.toInt()) {
              case 0:
                return 'SUN';
              case 1:
                return 'MON';
              case 2:
                return 'TUE';
              case 3:
                return 'WED';
              case 4:
                return 'TUE';
              case 5:
                return 'FRI';
              case 6:
                return 'SUT';
              default:
                return '';
            }
          },
        ),
        leftTitles: SideTitles(
            showTitles: true,
            getTitles: (value) {
              if (value.toInt() % 20 == 0) {
                return value.toInt().toString();
              }

              return '';
            }),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: showingGroups(dataSet),
    );
  }

  Future<dynamic> refreshState() async {
    setState(() {});
    await Future<dynamic>.delayed(
        animDuration + const Duration(milliseconds: 50));
    if (isPlaying) {
      await refreshState();
    }
  }
}
