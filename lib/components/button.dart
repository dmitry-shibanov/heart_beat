import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  late final LinearGradient? gradient;
  late final Color? textColor;
  late final String title;
  late final double height;
  late final double elevation;
  late final EdgeInsetsGeometry? insetsGeometry;
  late final void Function()? onPressed;

  Button(
      {required this.gradient,
      required this.onPressed,
      required this.title,
      this.textColor = Colors.white,
      this.elevation = 4.0,
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
        shape: const StadiumBorder(
          side: BorderSide(color: Colors.redAccent, width: 1.0),
        ),
        gradient: gradient,
      ),
      child: MaterialButton(
        elevation: this.elevation,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        shape: const StadiumBorder(),
        child: Text(
          title,
          style: TextStyle(
              color: textColor, fontSize: 17, fontWeight: FontWeight.w600),
        ),
        onPressed: onPressed,
      ),
    );
  }
}
