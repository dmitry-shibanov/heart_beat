import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_heart/components/button.dart';
import 'package:flutter_heart/components/circlePainter.dart';
import 'package:flutter_heart/db/database.dart';
import 'package:flutter_heart/helper/PulseWorker.dart';
import 'package:flutter_heart/models/TestPulse.dart';
import 'package:flutter_heart/pages/navigation_main/measure/result_measure.dart';
import 'package:flutter_heart/providers/data_helper.dart';
import 'package:flutter_heart/providers/pulse_provider.dart';
import 'package:provider/provider.dart';

class MeasurePulse extends StatefulWidget {
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
  final obj = new PulseWorker();

  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  );

  late final Animation<double> _animation =
      Tween<double>(begin: 1.0, end: 0.0).animate(_controller);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller.addStatusListener((status) {
      if (AnimationStatus.completed == status) {
        setState(() {
          startAnimation = !startAnimation;
        });
      } else if (AnimationStatus.reverse == status) {
        startAnimation = !startAnimation;
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void onButtonPressed(PulseProvider provider, DbHelper db) async {
    try {
      if (!startMeasure) {
        // bool result = await obj.start();
        // print("result start ${result}");
        provider.startTimer(Duration(minutes: 1), () {
          // _pageController.nextPage(
          //     duration: Duration(seconds: 1), curve: Curves.easeInOut);
          setState(() {
            // gotData = true;
          });
        });
      } else {
        provider.stopTimer(Duration(minutes: 1));
        print('came here');

        final map = {
          "image": 1,
          "date": DateTime.now().microsecondsSinceEpoch,
          "metric": provider.pulse
        };
        TestPulse pules = TestPulse.fromJson(map);
        db.addRecord(pules);
        setState(() {
          gotData = true;
        });
        // _pageController.nextPage(
        //     duration: Duration(seconds: 1), curve: Curves.easeInOut);
      }
    } catch (Exception) {
      await showCupertinoDialog(
          barrierDismissible: true,
          context: context,
          builder: (ctx) {
            return CupertinoAlertDialog(
              title: Text('No flashlight'),
              content: Text('The device does not have a flashlight'),
              actions: [
                CupertinoDialogAction(
                  isDefaultAction: true,
                  child: Text('Ok'),
                  onPressed: () => Navigator.pop(context, 1),
                ),
              ],
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
        !gotData ? Column(children: [
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
        ]) : Container(
          height: MediaQuery.of(context).size.height * 0.7,
          child:MeasureResult(provider.pulse),),
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
                title: startMeasure ? 'Stop' : gotData ? 'Restart' : 'Start',
                onPressed: () => onButtonPressed(provider, db),
              )),
        )
      ],
    );
  }
}
