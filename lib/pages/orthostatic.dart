import 'package:flutter/material.dart';
import 'package:flutter_heart/pages/navigation_main/orthostaticTest/firstIntro.dart';
import 'package:flutter_heart/pages/navigation_main/orthostaticTest/firstMeasure.dart';
import 'package:flutter_heart/pages/navigation_main/orthostaticTest/orthostaticTimer.dart';
import 'package:flutter_heart/pages/navigation_main/orthostaticTest/resultInfo.dart';
import 'package:flutter_heart/pages/navigation_main/orthostaticTest/testResult.dart';

class Orthostatic extends StatefulWidget {
  @override
  _OrthostaticState createState() => _OrthostaticState();
}

class _OrthostaticState extends State<Orthostatic> {
  final _pageController = PageController();
  int currentPage = 0;
  bool _isDisabled = false;

  void setDisabled(bool value) {
    setState(() {
      _isDisabled = value;
    });
  }

  String setButtonTitle() {
    switch (currentPage) {
      case 0:
      case 1:
      case 4:
        return "Start";
      case 2:
        return "Stop";
      default:
        return "Get Results";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.65,
          child: PageView(
            controller: _pageController,
            physics: new NeverScrollableScrollPhysics(),
            children: [
              OrthostaticTestIntro(),
              OrthostaticTimer(
                imageAsset: 'assets/images/man_with_clocks.png',
                action: (bool value) {
                  setDisabled(value);
                  _pageController.nextPage(
                      duration: Duration(seconds: 1), curve: Curves.easeInOut);
                },
              ),
              FirstMeasure(),
              OrthostaticResult(
                resultPulse: '72',
              ),
              OrthostaticTimer(
                imageAsset: 'assets/images/sand_clocks.png',
                action: (bool value) {
                  setDisabled(value);
                  _pageController.nextPage(
                      duration: Duration(seconds: 1), curve: Curves.easeInOut);
                },
              ),
              OrthostaticResult(
                resultPulse: '72',
                message: 'Good fitness level',
              ),
              OrthostaticTestResult()
            ],
            onPageChanged: (page) {
              if (page == 1) {
                setDisabled(true);
              }
              setState(() {
                currentPage = page;
              });
            },
          ),
        ),
        Expanded(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              margin: EdgeInsets.only(right: 16.0, left: 16.0, bottom: 16.0),
              height: 55.0,
              decoration: ShapeDecoration(
                shape: StadiumBorder(),
                gradient: LinearGradient(
                  colors: [
                    Color.fromRGBO(252, 90, 68, _isDisabled ? 0.5 : 1.0),
                    Color.fromRGBO(196, 20, 50, _isDisabled ? 0.5 : 1.0)
                  ],
                ),
              ),
              child: MaterialButton(
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                shape: StadiumBorder(),
                child: Text(
                  setButtonTitle(),
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w600),
                ),
                onPressed: () {
                  _pageController.nextPage(
                      duration: Duration(seconds: 1), curve: Curves.easeInOut);
                },
              ),
            ),
          ),
        )
      ],
    );
  }
}
