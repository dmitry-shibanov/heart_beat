// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// class Measure extends StatefulWidget {
//   @override
//   _MeasureState createState() => _MeasureState();
// }

// class _MeasureState extends State<Measure> {
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         Container(
//           height: MediaQuery.of(context).size.height*0.7,
//           child:PageView(),),
//         Expanded(
//           child: Align(
//               alignment: Alignment.bottomCenter,
//               child: Container(
//                 width: double.infinity,
//                 margin: EdgeInsets.only(right: 16.0, left: 16.0, bottom: 16.0),
//                 height: 55.0,
//                 decoration: !startMeasure
//                     ? ShapeDecoration(
//                         shape: StadiumBorder(),
//                         gradient: LinearGradient(
//                           colors: [
//                             Color.fromRGBO(252, 90, 68, 1),
//                             Color.fromRGBO(196, 20, 50, 1)
//                           ],
//                         ),
//                       )
//                     : null,
//                 child: MaterialButton(
//                   materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
//                   shape: StadiumBorder(),
//                   child: Text(
//                     'Start',
//                     style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 17,
//                         fontWeight: FontWeight.w600),
//                   ),
//                   onPressed: () async {
//                     try {
//                       if (!startMeasure) {
//                         bool result = await obj.start();
//                         print("result start ${result}");
//                       } else {
//                         bool? result = await obj.stop();
//                         int? current = await obj.current();

//                         print("result stop ${result}");
//                         print("result stop ${current}");
//                       }
//                     } catch (Exception) {
//                       await showCupertinoDialog(
//                           barrierDismissible: true,
//                           context: context,
//                           builder: (ctx) {
//                             return CupertinoAlertDialog(
//                               title: Text('No flashlight'),
//                               content:
//                                   Text('The device does not have a flashlight'),
//                               actions: [
//                                 CupertinoDialogAction(
//                                   isDefaultAction: true,
//                                   child: Text('Ok'),
//                                   onPressed: () => Navigator.pop(context, 1),
//                                 ),
//                               ],
//                             );
//                           });
//                       return;
//                     }
//                     setState(() {
//                       if (!startMeasure) {
//                         _controller.forward();
//                       } else {
//                         _controller.reverse();
//                       }

//                       startMeasure = !startMeasure;
//                     });
//                   },
//                 ),
//               )
//               // : Container(
//               //     width: double.infinity,
//               //     height: 55.0,
//               //     margin:
//               //         EdgeInsets.only(right: 16.0, left: 16.0, bottom: 16.0),
//               //     child: TextButton(
//               //       onPressed: () => null,
//               //       child: Text(
//               //         'Stop',
//               //         style: TextStyle(
//               //             color: Colors.red,
//               //             fontSize: 17,
//               //             fontWeight: FontWeight.w600),
//               //       ),
//               //       style: ButtonStyle(
//               //         shape:
//               //             MaterialStateProperty.all<RoundedRectangleBorder>(
//               //           RoundedRectangleBorder(
//               //             borderRadius: BorderRadius.circular(18.0),
//               //             side: BorderSide(color: Colors.red),
//               //           ),
//               //         ),
//               //       ),
//               //     ),
//               //   ),
//               ),
//         ),)
//       ],
//     );
//   }
// }
