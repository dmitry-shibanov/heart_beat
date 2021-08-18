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
  List<int> multiPly = [1, 1, 1];

  String getTitle() {
    switch (groupValue) {
      case 0:
        var firstDate = DateFormat.d().format(DateTime.now());
        var secondDate =
            DateFormat.d().format(DateTime.now().add(Duration(days: 7)));

        var firstMonth = DateFormat.MMM().format(DateTime.now());
        var secondMonth =
            DateFormat.MMM().format(DateTime.now().add(Duration(days: 7)));

        return "${firstDate} ${firstMonth} - ${secondDate} ${secondMonth}";
      case 1:
        return  DateFormat.MMM().format(DateTime.now());
      case 2:
        return DateFormat.y().format(DateTime.now());
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
                multiPly = [1, 1, 1];
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
                  onPressed: () => multiPly[groupValue]--,
                ),
                IconButton(
                  icon: Icon(AntDesign.arrowright),
                  onPressed: () => multiPly[groupValue]++,
                )
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
      return BarChartSample1();
    } else if (groupValue == 1) {
      return LineChartSample1();
    }
    return LineChartSample1();
  }
}
