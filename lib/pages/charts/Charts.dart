import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_heart/pages/charts/barChart.dart';
import 'package:flutter_heart/pages/charts/linearChart.dart';

class Charts extends StatefulWidget {
  @override
  _ChartsState createState() => _ChartsState();
}

class _ChartsState extends State<Charts> {
  int groupValue = 0;
  Map<int, Widget> _map = {0: Text('week'), 1: Text('month'), 2: Text('year')};

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          margin: EdgeInsets.symmetric(horizontal: 24.0),
          child: CupertinoSlidingSegmentedControl<int>(
            children: _map,
            onValueChanged: (number) {
              setState(() {
                groupValue = number!;
              });
            },
            groupValue: groupValue,
          ),
        ),
        loadGraph()
      ],
    );
  }

  loadGraph() {
    if (groupValue == 0) {
      return LineChartSample1();
    } else if (groupValue == 1) {
      return BarChartSample1();
    }
    return LineChartSample1();
  }
}
