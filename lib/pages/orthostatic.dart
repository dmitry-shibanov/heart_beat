import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_heart/components/button.dart';
import 'package:flutter_heart/helper/PulseWorker.dart';
import 'package:flutter_heart/pages/navigation_main/orthostaticTest/firstIntro.dart';
import 'package:flutter_heart/pages/navigation_main/orthostaticTest/firstMeasure.dart';
import 'package:flutter_heart/pages/navigation_main/orthostaticTest/orthostaticTimer.dart';
import 'package:flutter_heart/pages/navigation_main/orthostaticTest/resultInfo.dart';
import 'package:flutter_heart/pages/navigation_main/orthostaticTest/testResult.dart';
import 'package:flutter_heart/providers/main_page_provider.dart';
import 'package:flutter_heart/providers/pulse_provider.dart';
import 'package:provider/provider.dart';

class Orthostatic extends StatefulWidget {
  @override
  _OrthostaticState createState() => _OrthostaticState();
}

class _OrthostaticState extends State<Orthostatic> {
  final _pageController = PageController();
  int currentPage = 0;
  bool _isDisabled = false;
  int currentSeconds = 0;
  Timer? _timer;
  PulseWorker? _worker;
  List<int?> pulses = [];

  void setDisabled(bool value) {
    setState(() {
      _isDisabled = value;
    });
  }

  startMeasure() async {
    _worker = new PulseWorker();

    bool isStarted = await _worker!.start();
    if (isStarted) {
      var duration = Duration(seconds: 1);
      _timer = Timer.periodic(duration, (timer) async {
        int? pulse = await _worker!.current();
        setState(() {
          print(timer.tick);
          pulses.add(pulse);
          currentSeconds = timer.tick;
          if (timer.tick >= 60) {
            timer.cancel();
            _timer = null;
          }
        });
      });
    }

    if (_timer != null && !_timer!.isActive) {
      _pageController.nextPage(
          duration: Duration(seconds: 1), curve: Curves.easeInOut);
    }
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

  String getMessage(PulseProvider provider) {
    final number = provider.diff;
    if (number <= 12) {
      return 'The range from 0 to 12 beats indicates good fitness level';
    } else if (number >= 13 && number < 18) {
      return 'The difference of 13-18 beats shows a healthy, but not trained person';
    } else if (number >= 18 && number <= 25) {
      return 'The range from 18 to 25 beats indicates a complete lack of physical fitness';
    } else {
      return 'If the difference is more than 25 beats, then we can talk either about fatigue, or about a disease of the cardiovascular system or other health problems';
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PulseProvider>(context);
    final mainProvider = Provider.of<MainProvider>(context);
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
                  provider.startTimer(
                      Duration(minutes: 1),
                      () => _pageController.nextPage(
                          duration: Duration(seconds: 1),
                          curve: Curves.easeInOut));
                  // if (provider.isActive)
                  //   _pageController.nextPage(
                  //       duration: Duration(seconds: 1),
                  //       curve: Curves.easeInOut);
                },
              ),
              FirstMeasure(startMeasure: () => null),
              OrthostaticResult(
                resultPulse: provider.pulse.toString(),
                // (pulses.reduce((value, element) => value! + element!)! /
                //         pulses.length)
                //     .toString(),
              ),
              OrthostaticTimer(
                imageAsset: 'assets/images/sand_clocks.png',
                action: (bool value) {
                  setDisabled(value);
                  provider.startTimer(
                      Duration(minutes: 1),
                      () => _pageController.nextPage(
                          duration: Duration(seconds: 1),
                          curve: Curves.easeInOut));
                  // if (provider.isActive)
                  //   _pageController.nextPage(
                  //       duration: Duration(seconds: 1),
                  //       curve: Curves.easeInOut);
                },
              ),
              FirstMeasure(startMeasure: () => null),
              OrthostaticResult(
                resultPulse: provider.pulse.toString(),
                message: getMessage(provider),
              ),
              OrthostaticTestResult()
            ],
            onPageChanged: (page) {
              if (page == 1 || page == 4) {
                setDisabled(true);
              }
              setState(() {
                currentPage = page;
              });
            },
          ),
        ),
        if (currentPage != 7)
          Expanded(
            child: Align(
                alignment: Alignment.bottomCenter,
                child: Button(
                  title: setButtonTitle(),
                  textColor: currentPage == 2 || currentPage == 5
                      ? Colors.red
                      : Colors.white,
                  gradient: currentPage != 2
                      ? LinearGradient(
                          colors: [
                            Color.fromRGBO(
                                252, 90, 68, _isDisabled ? 0.5 : 1.0),
                            Color.fromRGBO(196, 20, 50, _isDisabled ? 0.5 : 1.0)
                          ],
                        )
                      : null,
                  onPressed: currentPage == 1 || currentPage == 4
                      ? () => null
                      : () {
                          if (currentPage == 2 || currentPage == 5) {
                            provider.stopTimer(Duration(minutes: 1));
                            _pageController.nextPage(
                                duration: Duration(seconds: 1),
                                curve: Curves.easeInOut);
                          } else {
                            _pageController.nextPage(
                                duration: Duration(seconds: 1),
                                curve: Curves.easeInOut);
                          }
                        },
                  insetsGeometry:
                      EdgeInsets.only(right: 16.0, left: 16.0, bottom: 16.0),
                )),
          )
      ],
    );
  }
}
