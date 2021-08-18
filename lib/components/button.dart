import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  late final LinearGradient gradient;
  late final double height;
  late final EdgeInsetsGeometry? insetsGeometry;
  late final void Function()? onPressed;

  Button(
      {required this.gradient,
      required this.onPressed,
      this.height = 55.0,
      this.insetsGeometry =
          const EdgeInsets.only(right: 16.0, left: 16.0, bottom: 16.0)});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: insetsGeometry,
      height: height,
      decoration: ShapeDecoration(
        shape: const StadiumBorder(),
        gradient: gradient,
      ),
      child: MaterialButton(
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        shape: const StadiumBorder(),
        child: Text(
          'Start',
          style: const TextStyle(
              color: Colors.white, fontSize: 17, fontWeight: FontWeight.w600),
        ),
        onPressed: onPressed,
      ),
    );
  }
}
