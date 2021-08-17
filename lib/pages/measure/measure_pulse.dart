import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_heart/components/circlePainter.dart';
import 'package:flutter_heart/helper/PulseWorker.dart';

class MeasurePulse extends StatefulWidget {
  @override
  _MeasurePulseState createState() => _MeasurePulseState();
}

class _MeasurePulseState extends State<MeasurePulse>
    with SingleTickerProviderStateMixin {
  bool startMeasure = false;
  bool startAnimation = false;
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

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Stack(
          alignment: Alignment(0.0, 0.0),
          children: [
            FadeTransition(
              opacity: _animation,
              child: Image.asset('assets/images/pink_circle.png'),
            ),
            Visibility(
              child: sprite,
              visible: startAnimation,
            ),
            Image.asset('assets/images/red_heart.png'),
          ],
        ),
        SizedBox(height: 40.0),
        Text(
          'Put your finger on camera\n and flashlight',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 17,
            color: Color.fromRGBO(70, 70, 70, 1),
          ),
        ),
        Expanded(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: 
                 Container(
                    width: double.infinity,
                    margin:
                        EdgeInsets.only(right: 16.0, left: 16.0, bottom: 16.0),
                    height: 55.0,
                    decoration: !startMeasure
                        ? ShapeDecoration(
                            shape: StadiumBorder(),
                            gradient: LinearGradient(
                              colors: [
                                Color.fromRGBO(252, 90, 68, 1),
                                Color.fromRGBO(196, 20, 50, 1)
                              ],
                            ),
                          )
                        : null,
                    child: MaterialButton(
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      shape: StadiumBorder(),
                      child: Text(
                        'Start',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.w600),
                      ),
                      onPressed: () async {
                        try {
                          if (!startMeasure) {
                            bool result = await obj.start();
                            print("result start ${result}");
                          } else {
                            bool? result = await obj.stop();
                            int? current = await obj.current();

                            print("result stop ${result}");
                            print("result stop ${current}");
                          }
                        } catch (Exception) {
                          await showCupertinoDialog(
                              barrierDismissible: true,
                              context: context,
                              builder: (ctx) {
                                return CupertinoAlertDialog(
                                  title: Text('No flashlight'),
                                  content: Text(
                                      'The device does not have a flashlight'),
                                  actions: [
                                    CupertinoDialogAction(
                                      isDefaultAction: true,
                                      child: Text('Ok'),
                                      onPressed: () =>
                                          Navigator.pop(context, 1),
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
                      },
                    ),
                  )
                // : Container(
                //     width: double.infinity,
                //     height: 55.0,
                //     margin:
                //         EdgeInsets.only(right: 16.0, left: 16.0, bottom: 16.0),
                //     child: TextButton(
                //       onPressed: () => null,
                //       child: Text(
                //         'Stop',
                //         style: TextStyle(
                //             color: Colors.red,
                //             fontSize: 17,
                //             fontWeight: FontWeight.w600),
                //       ),
                //       style: ButtonStyle(
                //         shape:
                //             MaterialStateProperty.all<RoundedRectangleBorder>(
                //           RoundedRectangleBorder(
                //             borderRadius: BorderRadius.circular(18.0),
                //             side: BorderSide(color: Colors.red),
                //           ),
                //         ),
                //       ),
                //     ),
                //   ),
          ),
        )
      ],
    );
  }
}
