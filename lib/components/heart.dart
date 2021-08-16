import 'package:flutter/material.dart';
import 'package:flutter_heart/components/circlePainter.dart';

class Heart extends StatefulWidget {
  @override
  _HeartState createState() => _HeartState();
}

class _HeartState extends State<Heart> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        alignment: Alignment(0.0, 0.0),
        children: [
          Image.asset('assets/images/pink_circle.png'),
          Image.asset('assets/images/red_heart.png'),
        ],
      ),
    );
  }
}
