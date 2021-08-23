import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_heart/components/button.dart';
import 'package:flutter_heart/pages/navigation_main/orthostaticTest/firstIntro.dart';
import 'package:flutter_heart/pages/navigation_main/orthostaticTest/firstMeasure.dart';
import 'package:flutter_heart/pages/navigation_main/orthostaticTest/orthostaticTimer.dart';
import 'package:flutter_heart/pages/navigation_main/orthostaticTest/resultInfo.dart';
import 'package:flutter_heart/pages/navigation_main/orthostaticTest/testResult.dart';
import 'package:flutter_heart/providers/pulse_provider.dart';
import 'package:provider/provider.dart';

class Orthostatic extends StatefulWidget {
  final Function(VoidCallback) parentCb;

  Orthostatic(this.parentCb);
  @override
  _OrthostaticState createState() => _OrthostaticState();
}

class _OrthostaticState extends State<Orthostatic> {
  final _pageController = PageController();
  int currentPage = 0;
  bool _isDisabled = false;
  bool _isReset = false;

  void resetData() {
    _pageController.jumpToPage(0);
    setState(() {
      _isDisabled = false;
      _isReset = false;
    });
  }

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
      case 5:
        return "Stop";
      default:
        return "Get Results";
    }
  }

  String getMessageHealth(PulseProvider provider) {
    final number = provider.diff;
    if (number <= 12) {
      return 'Good fitness level';
    } else if (number >= 13 && number < 18) {
      return 'Healthy, but not trained personn';
    } else if (number >= 18 && number <= 25) {
      return 'Complete lack of physical fitness';
    } else {
      return 'Fatigue, or about a disease of the cardiovascular system or other health problems';
    }
  }

  void _stopMetrics(PulseProvider provider) {
    if (!_isReset) {
      provider.stopTimer();
      _pageController.nextPage(
          duration: Duration(seconds: 1), curve: Curves.easeInOut);
    }
  }

  VoidCallback getOnPressButton(PulseProvider provider) {
    switch (currentPage) {
      case 1:
      case 4:
        return () => null;
      case 2:
      case 5:
        return () => _stopMetrics(provider);
      case 6:
        return () {
          setState(() {
            _isReset = true;
          });
          _pageController.nextPage(
              duration: Duration(seconds: 1), curve: Curves.easeInOut);
          widget.parentCb(resetData);
        };
      default:
        return () {
          if (!_isReset) {
            _pageController.nextPage(
                duration: Duration(seconds: 1), curve: Curves.easeInOut);
          }
        };
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PulseProvider>(context);
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
                  try {
                    provider
                        .startTimer(
                            Duration(minutes: 1),
                            () => _pageController.nextPage(
                                duration: Duration(seconds: 1),
                                curve: Curves.easeInOut))
                        .catchError((err) {
                          showCupertinoDialog(
                        barrierDismissible: true,
                        context: context,
                        builder: (ctx) {
                          return CupertinoAlertDialog(
                            title: Text('No flashlight'),
                            content:
                                Text('The device does not have a flashlight'),
                            actions: [
                              CupertinoDialogAction(
                                isDefaultAction: true,
                                child: Text('Ok'),
                                onPressed: () => Navigator.pop(context, 1),
                              ),
                            ],
                          );
                        });
                        });
                  } catch (Exception) {
                    
                  }
                },
              ),
              FirstMeasure(startMeasure: () => null),
              OrthostaticResult(
                resultPulse: provider.pulse.toString(),
              ),
              OrthostaticTimer(
                imageAsset: 'assets/images/hourglass.png',
                action: (bool value) {
                  setDisabled(value);
                  _pageController.nextPage(
                      duration: Duration(seconds: 1), curve: Curves.easeInOut);
                  provider.startTimer(
                      Duration(minutes: 1),
                      () => _pageController.nextPage(
                          duration: Duration(seconds: 1),
                          curve: Curves.easeInOut));
                },
              ),
              FirstMeasure(startMeasure: () => null),
              OrthostaticResult(
                resultPulse: provider.pulse.toString(),
                message: getMessageHealth(provider),
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
                  gradient: currentPage == 2 || currentPage == 5
                      ? null
                      : LinearGradient(
                          colors: [
                            Color.fromRGBO(
                                252, 90, 68, _isDisabled ? 0.5 : 1.0),
                            Color.fromRGBO(196, 20, 50, _isDisabled ? 0.5 : 1.0)
                          ],
                        ),
                  onPressed: getOnPressButton(provider),
                  insetsGeometry:
                      EdgeInsets.only(right: 16.0, left: 16.0, bottom: 16.0),
                )),
          )
      ],
    );
  }
}
