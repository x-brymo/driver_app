import 'package:flutter/material.dart';

class ButtonCustom extends StatelessWidget {
  const ButtonCustom({
    super.key,
    required this.width,
    required this.height,
    required this.color,
    required this.text,
    required this.style,
    required this.radius,
    required this.onTap
  });

  final double? width;
  final double? height;
  final Color? color;
  final String text;
  final TextStyle? style;
  final double radius;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.all(
            Radius.circular(radius)
          )
        ),
        child: Center(
          child: Text(
            text,
            style: style,
          ),
        ),
      ),
    );
  }
}