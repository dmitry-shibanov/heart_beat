import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_heart/pages/navigation_main/charts/barChart.dart';
import 'package:flutter_heart/pages/navigation_main/charts/linearChart.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:intl/intl.dart';

class Charts extends StatefulWidget {
  @override
  _ChartsState createState() => _ChartsState();
}

class _ChartsState extends State<Charts> {
  int groupValue = 0;
  Map<int, Widget> _map = {0: Text('week'), 1: Text('month'), 2: Text('year')};
  List<int> multiPly = [0, 0, 0];
  late DateTime first;
  late DateTime second;
  late DateTime yearDate;
  late DateTime monthDate;

  _ChartsState() {
    var now = DateTime.now();
    var start = now.subtract(Duration(days: now.weekday - 1));
    first = start.add(Duration(days: 7));
    second = first.subtract(Duration(days: 7));
    yearDate = DateTime(now.year + multiPly[2], 1, 1);
    monthDate = DateTime(now.year, now.month + multiPly[1], 1);
  }

  String getTitle() {
    switch (groupValue) {
      case 0:
        var now = DateTime.now();
        final diff = (now.weekday - 7).abs();
        final start = now.subtract(Duration(days: now.weekday - diff));
        setState(() {
          first = start.add(Duration(days: (multiPly[0] + 1) * 7));
          second = first.subtract(Duration(days: 6));
        });

        var firstDate = DateFormat.d().format(first);
        var secondDate = DateFormat.d().format(second);

        var firstMonth = DateFormat.MMM().format(first);
        var secondMonth = DateFormat.MMM().format(second);

        return "${secondDate} ${secondMonth} - ${firstDate} ${firstMonth}";
      case 1:
        final now = DateTime.now();
        setState(() {
          monthDate = DateTime(now.year, now.month + multiPly[1], 1);
        });
        return DateFormat.MMM().format(monthDate);
      case 2:
        final now = DateTime.now();
        setState(() {
          yearDate = DateTime(now.year + multiPly[2], 1, 1);
        });
        return DateFormat.y().format(yearDate);
      default:
        return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          margin:
              EdgeInsets.only(right: 24.0, left: 24.0, top: 8.0, bottom: 24.0),
          child: CupertinoSlidingSegmentedControl<int>(
            children: _map,
            onValueChanged: (number) {
              setState(() {
                groupValue = number!;
                // multiPly = [1, 1, 1];
              });
            },
            groupValue: groupValue,
          ),
        ),
        Container(
          margin: EdgeInsets.only(bottom: 24.0, right: 16.0, left: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(getTitle()),
              Row(children: [
                IconButton(
                    icon: Icon(AntDesign.arrowleft),
                    onPressed: () {
                      setState(() {
                        multiPly[groupValue]--;
                      });
                    }),
                IconButton(
                    icon: Icon(AntDesign.arrowright),
                    onPressed: () {
                      setState(() {
                        multiPly[groupValue]++;
                      });
                    })
              ])
            ],
          ),
        ),
        loadGraph()
      ],
    );
  }

  loadGraph() {
    if (groupValue == 0) {
      return BarChartCustom(start: second, finish: first);
    } else if (groupValue == 1) {
      return LineChartSample(monthDate, true);
    }
    return LineChartSample(yearDate, false);
  }
}
