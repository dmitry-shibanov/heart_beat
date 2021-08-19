import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class LineChartCustom extends StatelessWidget {
  const LineChartCustom({required this.isShowingMainData});

  final bool isShowingMainData;

  @override
  Widget build(BuildContext context) {
    return LineChart(
      sampleData1,
      swapAnimationDuration: const Duration(milliseconds: 250),
    );
  }

  LineChartData get sampleData1 => LineChartData(
        lineTouchData: lineTouchData1,
        gridData: gridData,
        titlesData: titlesData1,
        borderData: borderData,
        lineBarsData: lineBarsData1,
        minX: 0,
        maxX: 32,
        maxY: 150,
        minY: -10,
      );

  LineTouchData get lineTouchData1 => LineTouchData(
        touchCallback: (LineTouchResponse touchResponse) {},
        handleBuiltInTouches: true,
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
        ),
      );

  FlTitlesData get titlesData1 => FlTitlesData(
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

  List<LineChartBarData> get lineBarsData1 => [lineChartBarData1_1];

  SideTitles leftTitles({required GetTitleFunction getTitles}) => SideTitles(
        getTitles: getTitles,
        showTitles: true,
        // margin: 8,
        reservedSize: 30,
        getTextStyles: (value) => const TextStyle(
          color: Color.fromRGBO(70, 70, 70, 1),
          fontWeight: FontWeight.w400,
          fontSize: 10,
        ),
      );

  SideTitles get bottomTitles => SideTitles(
        showTitles: true,
        reservedSize: 22,
        margin: 10,
        getTextStyles: (value) => const TextStyle(
          color: Color.fromRGBO(70, 70, 70, 1),
          fontWeight: FontWeight.w400,
          fontSize: 10,
        ),
        getTitles: (value) {
          if (value == 1.0 || value == 31.0) {
            return value.toInt().toString();
          } else if (value > 0 && value != 30 && value.toInt() % 5 == 0) {
            return value.toInt().toString();
          }
          return '';
        },
      );

  FlGridData get gridData => FlGridData(
        show: true,
        horizontalInterval: 20,
      );

  FlBorderData get borderData => FlBorderData(
      show: false,
      border: Border.all(color: const Color(0xff37434d), width: 1));

  LineChartBarData get lineChartBarData1_1 => LineChartBarData(
        isCurved: true,
        colors: [const Color.fromRGBO(196, 20, 50, 1)],
        barWidth: 2,
        isStrokeCapRound: true,
        dotData: FlDotData(
          show: true,
          getDotPainter: (spot, percent, barData, index) =>
              FlDotCirclePainter(radius: 4, color: Colors.redAccent),
        ),
        belowBarData: BarAreaData(show: false),
        spots: [
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

class LineChartSample1 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LineChartSample1State();
}

class LineChartSample1State extends State<LineChartSample1> {
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
                    child:
                        LineChartCustom(isShowingMainData: isShowingMainData),
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
