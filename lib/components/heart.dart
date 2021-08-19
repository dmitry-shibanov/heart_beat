import 'package:flutter/material.dart';

class Heart extends StatelessWidget {
  final double? height;
  final double? width;
  final EdgeInsetsGeometry? geometry;

  Heart({this.height, this.width, this.geometry});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: geometry,
      child: Image.asset('assets/images/full_heart.png', fit: BoxFit.cover, scale: 3,),
      height: this.height,
      width: this.width,
    );
  }
}
