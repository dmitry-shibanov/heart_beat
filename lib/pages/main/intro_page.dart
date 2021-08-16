import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class Intro extends StatelessWidget {
  final List<int> images = [1];
  final List<String> content = [
    "Hold your finger on the\ncamera lens and the\nflashlight",
    "The orthostatic test is one of\nthe tools that allows you to\nfind a balance between\ntraining and recovery"
  ];
  int currentPage = 0;
// To-Do gradient
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ElevatedButton(
              onPressed: () => null,
              child: Text(
                'Next',
                style: TextStyle(color: Colors.white),
              ),
              style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.red)))))
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
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
        currentIndex: currentPage,
        type: BottomNavigationBarType.fixed,
        onTap: (index) => null,
      ),
    );
  }
}
