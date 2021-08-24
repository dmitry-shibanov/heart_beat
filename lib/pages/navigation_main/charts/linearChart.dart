import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_heart/models/TestPulse.dart';
import 'package:flutter_heart/providers/data_helper.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class LineChartCustom extends StatelessWidget {
  const LineChartCustom(
      {required this.isShowingMainData,
      required this.time,
      required this.isMonth});
  final DateTime time;
  final bool isShowingMainData;
  final bool isMonth;

  @override
  Widget build(BuildContext context) {
    return Consumer<DbHelper>(builder: (context, db, child) {
      final records = db.records;
      late final points;
      if (isMonth) {
        points = createProperDataSetMonth(time, records);
      } else {
        points = createProperDataSetYear(time, records);
      }

      return LineChart(
        sampleData(points),
        swapAnimationDuration: const Duration(milliseconds: 250),
      );
    });
  }

  Map<int, double> createProperDataSetMonth(
      DateTime first, List<TestPulse> records) {
    final lastDay = DateTime(time.year, time.month + 1, 0).day;
    final second = DateTime(time.year, time.month, lastDay);
    List<int> days = List.generate(lastDay, (index) => 0);
    Map<int, double> results = {};
    records.forEach((e) {
      print(DateFormat.d().format(e.date));
      if (e.date.microsecondsSinceEpoch >= first.microsecondsSinceEpoch &&
          e.date.microsecondsSinceEpoch <= second.microsecondsSinceEpoch) {
        if (results.containsKey(e.date.day)) {
          results.update(e.date.day, (value) => value + e.metric);
        } else {
          results[e.date.day] = e.metric.toDouble();
        }
        days[e.date.day - 1] += 1;
      }
    });

    final finalMap = results.map((key, value) {
      return new MapEntry(key, value / days[key - 1]);
    });

    return finalMap;
  }

  Map<int, double> createProperDataSetYear(
      DateTime first, List<TestPulse> records) {
    final lastMonth = 12;
    final second = DateTime(time.year, lastMonth, 31);
    List<int> months = List.generate(lastMonth, (index) => 0);
    Map<int, double> results = {};
    records.forEach((e) {
      print(DateFormat.d().format(e.date));
      if (e.date.microsecondsSinceEpoch >= first.microsecondsSinceEpoch &&
          e.date.microsecondsSinceEpoch <= second.microsecondsSinceEpoch) {
        if (results.containsKey(e.date.month)) {
          results.update(e.date.month, (value) => value + e.metric);
        } else {
          results[e.date.month] = e.metric.toDouble();
        }
        months[e.date.month - 1] += 1;
      }
    });

    final finalMap = results.map((key, value) {
      return new MapEntry(key, value / months[key - 1]);
    });

    return finalMap;
  }

  LineChartData sampleData(Map<int, double> points) => LineChartData(
        lineTouchData: lineTouchData,
        gridData: gridData,
        titlesData: titlesData,
        borderData: borderData,
        lineBarsData: lineBarsData(points),
        minX: 0,
        maxX: this.isMonth ? 32 : 13,
        maxY: 150,
        minY: 0,
      );

  LineTouchData get lineTouchData => LineTouchData(
        touchCallback: (LineTouchResponse touchResponse) {},
        handleBuiltInTouches: true,
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
        ),
      );

  FlTitlesData get titlesData => FlTitlesData(
        bottomTitles: bottomTitles,
        leftTitles: leftTitles(
          getTitles: (value) {
            if (value.toInt() % 20 == 0) {
              return value.toInt().toString();
            }

            return '';
          },
        ),
      );

  List<LineChartBarData> lineBarsData(Map<int, double> points) =>
      [lineChartBarData(points)];

  SideTitles leftTitles({required GetTitleFunction getTitles}) => SideTitles(
        getTitles: getTitles,
        showTitles: true,
        margin: 8,
        // reservedSize: 30,
        getTextStyles: (context, value) => const TextStyle(
          color: Color.fromRGBO(70, 70, 70, 1),
          fontWeight: FontWeight.w400,
          fontSize: 13,
        ),
      );

  SideTitles get bottomTitles => SideTitles(
        rotateAngle: this.isMonth ? null : -90.0,
        showTitles: true,
        reservedSize: 22,
        margin: 10,
        getTextStyles: (context, value) => const TextStyle(
          color: Color.fromRGBO(70, 70, 70, 1),
          fontWeight: FontWeight.w400,
          fontSize: 10,
        ),
        getTitles: (value) {
          final months = [
            '',
            'JAN',
            'FEB',
            'MAR',
            'APR',
            'MAY',
            'JUNE',
            'JULY',
            'AUG',
            'SEPT',
            'OCT',
            'NOV',
            'DEC',
            '',
            '',
          ];
          if (this.isMonth) {
            if (value == 1.0 || value == 31.0) {
              return value.toInt().toString();
            } else if (value > 0 && value != 30 && value.toInt() % 5 == 0) {
              return value.toInt().toString();
            }
          } else {
            return months[value.toInt()];
          }
          return '';
        },
      );

  FlGridData get gridData => FlGridData(
        show: true,
        horizontalInterval: 20,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
            dashArray: [5,5]
          );
        },
      );

  FlBorderData get borderData => FlBorderData(
      show: false,
      border: Border.all(color: const Color(0xff37434d), width: 1));

  LineChartBarData lineChartBarData(Map<int, double> points) =>
      LineChartBarData(
        isCurved: true,
        colors: [const Color.fromRGBO(196, 20, 50, 1)],
        barWidth: 2,
        isStrokeCapRound: true,
        dotData: FlDotData(
          show: true,
          checkToShowDot: (spot, barData) {
            return this.isMonth ? spot.x % 5 == 0 : true;
          },
          getDotPainter: (spot, percent, barData, index) =>
              FlDotCirclePainter(radius: 4, color: Colors.redAccent),
        ),
        belowBarData: BarAreaData(show: false),
        spots: [
          ...points.entries.map((e) {
            return FlSpot(e.key.toDouble(), e.value);
          }).toList()
          // FlSpot(3, 87),
          // FlSpot(5, 83),
          // FlSpot(10, 100),
          // FlSpot(13, 105),
          // FlSpot(15, 100),
          // FlSpot(20, 77),
          // FlSpot(25, 85),
          // FlSpot(31, 83),
        ],
      );
}

class LineChartSample extends StatefulWidget {
  final DateTime time;
  final bool isMonth;
  LineChartSample(this.time, this.isMonth);
  @override
  State<StatefulWidget> createState() => LineChartSampleState();
}

class LineChartSampleState extends State<LineChartSample> {
  late bool isShowingMainData;

  @override
  void initState() {
    super.initState();
    isShowingMainData = true;
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.23,
      child: Container(
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(18)),
            boxShadow: const [
              BoxShadow(
                color: Colors.white,
                blurRadius: 10,
                spreadRadius: 0,
              )
            ]),
        child: Stack(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16.0, left: 6.0),
                    child: LineChartCustom(
                      isShowingMainData: isShowingMainData,
                      time: widget.time,
                      isMonth: widget.isMonth,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
