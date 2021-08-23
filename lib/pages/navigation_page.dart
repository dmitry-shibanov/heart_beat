import 'package:flutter/material.dart';
import 'package:flutter_heart/pages/navigation_main/charts/Charts.dart';
import 'package:flutter_heart/pages/navigation_main/history_page.dart';
import 'package:flutter_heart/pages/navigation_main/measure/measure_pulse.dart';
import 'package:flutter_heart/pages/orthostatic.dart';
import 'package:flutter_heart/providers/pulse_provider.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';

class Intro extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _IntroState();
  }
}

class _IntroState extends State<Intro> {
  final List<String> titles = ['History', 'Statistics', 'Orthostatic Test'];
  late final List<Widget> _pages;
  int _bottomIndex = 0;
  bool isBackButtonAvailable = false;
  VoidCallback? backCallBack;

  _IntroState() {
    _pages = [
      MeasurePulse(pressBackButtonCallBack),
      HistoryPage(),
      Charts(),
      Orthostatic(pressBackButtonCallBack)
    ];
  }

  void changeIndex(int index) {
    setState(() {
      _bottomIndex = index;
      isBackButtonAvailable = false;
    });
  }

  Widget? getTitle() {
    if (_bottomIndex > 0) {
      return Text(
        titles[_bottomIndex - 1],
        style: TextStyle(
            color: Colors.black, fontSize: 17, fontWeight: FontWeight.w600),
      );
    }

    return null;
  }

  void pressBackButtonCallBack(VoidCallback? cb) {
    setState(() {
      backCallBack = cb;
      isBackButtonAvailable = cb == null ? false : true;
    });
  }

  Widget getPage(PulseProvider provider) {
    provider.stopTimer();

    return _pages[_bottomIndex];
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PulseProvider>(context);
    return Scaffold(
      appBar: AppBar(
        leading: isBackButtonAvailable
            ? BackButton(
                onPressed: () {
                  backCallBack!();
                  setState(() {
                    isBackButtonAvailable = false;
                  });
                },
                color: Colors.black,
              )
            : null,
        title: getTitle(),
        backgroundColor: Colors.white,
        elevation: _bottomIndex == 0 ? 0.0 : 4.0,
        actions: [
          IconButton(
            icon: Icon(
              Feather.settings,
              color: Colors.grey,
            ),
            onPressed: (){
              provider.stopTimer();
              Navigator.pushNamed(context, '/settings');
            },
          )
        ],
      ),
      body: Container(
          margin: EdgeInsets.only(top: 16.0), child: getPage(provider)),
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
