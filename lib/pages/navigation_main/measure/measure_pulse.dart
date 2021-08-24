import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_heart/components/button.dart';
import 'package:flutter_heart/components/circlePainter.dart';
import 'package:flutter_heart/components/flshlight_dialog.dart';
import 'package:flutter_heart/models/TestPulse.dart';
import 'package:flutter_heart/pages/navigation_main/measure/result_measure.dart';
import 'package:flutter_heart/providers/data_helper.dart';
import 'package:flutter_heart/providers/pulse_provider.dart';
import 'package:provider/provider.dart';

class MeasurePulse extends StatefulWidget {
  final Function(VoidCallback?) parentCb;

  MeasurePulse(this.parentCb);

  @override
  _MeasurePulseState createState() => _MeasurePulseState();
}

class _MeasurePulseState extends State<MeasurePulse>
    with SingleTickerProviderStateMixin {
  bool startMeasure = false;
  final _pageController = PageController();
  bool startAnimation = false;
  bool gotData = false;
  Widget sprite = SpriteDemo();

  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  );

  late final Animation<double> _animation =
      Tween<double>(begin: 1.0, end: 0.0).animate(_controller);

  void resetData() {
    setState(() {
      startMeasure = false;
      startAnimation = false;
      gotData = false;
      _controller.reset();
    });
  }

  @override
  void initState() {
    super.initState();
    _controller.addStatusListener((status) {
      if (AnimationStatus.completed == status) {
        setState(() {
          startAnimation = true;
        });
      } else if (AnimationStatus.reverse == status) {
        startAnimation = false;
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void collectPulseData(PulseProvider provider, DbHelper db) {
    final map = {
      "image": 1,
      "date": DateTime.now().microsecondsSinceEpoch,
      "metric": provider.pulse
    };
    TestPulse pules = TestPulse.fromJson(map);
    db.addRecord(pules);
  }

  Future<void> onButtonPressed(PulseProvider provider, DbHelper db) async {
    try {
      if (!gotData) {
        if (!startMeasure) {
          final result = await provider.startTimer(Duration(seconds: 15), () {
            collectPulseData(provider, db);
            widget.parentCb(resetData);
            setState(() {
              gotData = true;
              startMeasure = false;
            });
          });
          if (!result) {
            throw new Exception();
          }
        } else {
          provider.stopTimer();
          collectPulseData(provider, db);
          widget.parentCb(resetData);
          setState(() {
            gotData = true;
          });
        }
      } else {
        _controller.reverse();
        widget.parentCb(null);
        Future.delayed(Duration(seconds: 1), () {
          setState(() {
            gotData = !gotData;
            startMeasure = true;
          });
          provider.startTimer(Duration(seconds: 15), () {
            collectPulseData(provider, db);
            widget.parentCb(resetData);
            setState(() {
              gotData = true;
              startMeasure = false;
            });
          });
        });
      }
    } catch (Exception) {
      await showCupertinoDialog(
          barrierDismissible: true,
          context: context,
          builder: (ctx) {
            return FlashLighDialog(
              onPressed: () => Navigator.pop(context, 1),
            );
          });
      return;
    }
    setState(() {
      if (!startMeasure) {
        _controller.forward();
      } else {
        _controller.reverse();
      }

      startMeasure = !startMeasure;
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PulseProvider>(context);
    final db = Provider.of<DbHelper>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        !gotData
            ? Column(children: [
                Stack(
                  alignment: Alignment(0.0, 0.0),
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 3,
                    ),
                    FadeTransition(
                      opacity: _animation,
                      child: Image.asset('assets/images/pink_circle.png'),
                    ),
                    Visibility(
                      child: sprite,
                      visible: startAnimation,
                    ),
                    Image.asset(
                      'assets/images/red_heart.png',
                      scale: 3,
                    ),
                  ],
                ),
                SizedBox(height: 40.0),
                startMeasure
                    ? Text(
                        'Do not remove your finger,\n measurement is in progress',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Color.fromRGBO(177, 177, 177, 1),
                            fontSize: 17,
                            fontWeight: FontWeight.w400),
                      )
                    : Text(
                        'Put your finger on camera\n and flashlight',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 17,
                          color: Color.fromRGBO(70, 70, 70, 1),
                        ),
                      ),
              ])
            : Container(
                height: MediaQuery.of(context).size.height * 0.7,
                child: MeasureResult(provider.pulse),
              ),
        Expanded(
          child: Align(
              alignment: Alignment.bottomCenter,
              child: Button(
                textColor: startMeasure || gotData ? Colors.red : Colors.white,
                gradient: startMeasure || gotData
                    ? null
                    : LinearGradient(
                        colors: [
                          Color.fromRGBO(252, 90, 68, 1),
                          Color.fromRGBO(196, 20, 50, 1)
                        ],
                      ),
                title: startMeasure
                    ? 'Stop'
                    : gotData
                        ? 'Restart'
                        : 'Start',
                onPressed: () => onButtonPressed(provider, db),
              )),
        )
      ],
    );
  }
}
