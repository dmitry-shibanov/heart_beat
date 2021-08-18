import 'package:flutter/material.dart';
import 'package:flutter_heart/pages/navigation_main/charts/Charts.dart';
import 'package:flutter_heart/pages/navigation_main/history_page.dart';
import 'package:flutter_heart/pages/navigation_main/measure/measure_pulse.dart';
import 'package:flutter_heart/pages/orthostatic.dart';
import 'package:flutter_icons/flutter_icons.dart';

class Intro extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _IntroState();
  }
}

class _IntroState extends State<Intro> {
  final List<int> images = [1];
  final List<String> content = [
    "Hold your finger on the\ncamera lens and the\nflashlight",
    "The orthostatic test is one of\nthe tools that allows you to\nfind a balance between\ntraining and recovery"
  ];
  final List<Widget> _pages = [
    MeasurePulse(),
    HistoryPage(),
    Charts(),
    Orthostatic()
  ];
  int currentPage = 0;
  int _bottomIndex = 0;

  void changeIndex(int index) {
    setState(() {
      _bottomIndex = index;
    });
  }

// To-Do gradient
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: _bottomIndex == 0 ? 0.0 : 4.0,
        actions: [
          IconButton(
            icon: Icon(
              Feather.settings,
              color: Colors.grey,
            ),
            onPressed: () => Navigator.pushNamed(context, '/settings'),
          )
        ],
      ),
      body: Container(
          margin: EdgeInsets.only(top: 16.0), child: _pages[_bottomIndex]),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _bottomIndex,
        selectedItemColor: Colors.redAccent,
        type: BottomNavigationBarType.fixed,
        onTap: changeIndex,
        items: [
          BottomNavigationBarItem(
              icon: Icon(FontAwesome.heartbeat), label: 'Measure'),
          BottomNavigationBarItem(
              icon: Icon(EvilIcons.clock), label: 'History'),
          BottomNavigationBarItem(
              icon: Icon(FontAwesome.pie_chart), label: 'Statistics'),
          BottomNavigationBarItem(
              icon: Icon(Ionicons.ios_pulse), label: 'Orthostatic test')
        ],
      ),
    );
  }
}
